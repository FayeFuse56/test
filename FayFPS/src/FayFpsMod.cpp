#include <algorithm>
#include <atomic>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include <dlfcn.h>
#include <EGL/egl.h>
#include <GLES2/gl2.h>

#include <pl/Mod.hpp>
#include <pl/ModMenu.hpp>
#include <pl/memory/Hook.hpp>

namespace {

constexpr const char* kExtremeModule = "fayfps.extreme";
constexpr const char* kGameModule = "fayfps.game";
constexpr const char* kParticlesModule = "fayfps.particles";
constexpr const char* kSoundModule = "fayfps.sound";

constexpr const char* kFrameMode = "frameMode";
constexpr const char* kBlendStrength = "blendStrength";
constexpr const char* kDisableVsync = "disableVsync";
constexpr const char* kMinRealFps = "minRealFps";

constexpr const char* kSkipRain = "skipRain";
constexpr const char* kRenderBlockEntities = "renderBlockEntities";
constexpr const char* kRenderEntityEffects = "renderEntityEffects";

constexpr const char* kMasterParticles = "masterParticles";
constexpr const char* kExplosionParticles = "explosionParticles";
constexpr const char* kTerrainParticles = "terrainParticles";
constexpr const char* kBreakingParticles = "breakingParticles";
constexpr const char* kSmokeParticles = "smokeParticles";

constexpr const char* kMasterSound = "masterSound";
constexpr const char* kRepeatedMobSound = "repeatedMobSound";
constexpr const char* kExplosionSound = "explosionSound";

constexpr float kQuad[16] = {
    -1.f,-1.f,0.f,0.f,  1.f,-1.f,1.f,0.f,
    -1.f, 1.f,0.f,1.f,  1.f, 1.f,1.f,1.f
};

constexpr const char* kVs = R"GLSL(
attribute vec2 aPos;
attribute vec2 aUV;
varying vec2 vUV;
void main() {
  vUV = aUV;
  gl_Position = vec4(aPos, 0.0, 1.0);
}
)GLSL";

constexpr const char* kFs = R"GLSL(
precision mediump float;
varying vec2 vUV;
uniform sampler2D uPrev;
uniform sampler2D uCur;
uniform float uT;
uniform float uStrength;
void main() {
  vec4 p = texture2D(uPrev, vUV);
  vec4 c = texture2D(uCur, vUV);
  float t = mix(step(0.5, uT), uT, uStrength);
  gl_FragColor = mix(p, c, t);
}
)GLSL";

using EglSwapBuffersFn = decltype(&eglSwapBuffers);
using EglSwapIntervalFn = decltype(&eglSwapInterval);
using PresentationTimeFn = EGLBoolean(EGLAPIENTRY*)(EGLDisplay, EGLSurface, int64_t);

using GenVertexArraysFn = void(*)(GLsizei, GLuint*);
using BindVertexArrayFn = void(*)(GLuint);
using DeleteVertexArraysFn = void(*)(GLsizei, const GLuint*);

GenVertexArraysFn gGenVao = nullptr;
BindVertexArrayFn gBindVao = nullptr;
DeleteVertexArraysFn gDeleteVao = nullptr;
constexpr GLenum kVaoBinding = 0x85B5;

static bool parseBool(std::string_view v) {
  return v == "true" || v == "1" || v == "on";
}

static int parseInt(std::string_view v, int lo, int hi, int fallback) {
  std::string s(v);
  char* end = nullptr;
  long x = std::strtol(s.c_str(), &end, 10);
  if (end == s.c_str()) return fallback;
  return static_cast<int>(std::clamp<long>(x, lo, hi));
}

static bool containsToken(const std::string& s, std::string_view token) {
  return s.find(token) != std::string::npos;
}

class GlStateGuard {
public:
  GlStateGuard() {
    glGetIntegerv(GL_CURRENT_PROGRAM, &program);
    glGetIntegerv(GL_ACTIVE_TEXTURE, &activeTexture);
    glGetIntegerv(GL_VIEWPORT, viewport);
    glGetIntegerv(GL_FRAMEBUFFER_BINDING, &framebuffer);
    glGetIntegerv(GL_ARRAY_BUFFER_BINDING, &arrayBuffer);
    depth = glIsEnabled(GL_DEPTH_TEST);
    blend = glIsEnabled(GL_BLEND);
    cull = glIsEnabled(GL_CULL_FACE);
    glGetBooleanv(GL_DEPTH_WRITEMASK, &depthMask);
    glGetBooleanv(GL_COLOR_WRITEMASK, colorMask);
    if (gBindVao) glGetIntegerv(kVaoBinding, &vao);

    glActiveTexture(GL_TEXTURE0);
    glGetIntegerv(GL_TEXTURE_BINDING_2D, &tex0);
    glActiveTexture(GL_TEXTURE1);
    glGetIntegerv(GL_TEXTURE_BINDING_2D, &tex1);
    glActiveTexture(static_cast<GLenum>(activeTexture));
  }

  ~GlStateGuard() {
    if (gBindVao) gBindVao(static_cast<GLuint>(vao));
    glBindFramebuffer(GL_FRAMEBUFFER, static_cast<GLuint>(framebuffer));
    glBindBuffer(GL_ARRAY_BUFFER, static_cast<GLuint>(arrayBuffer));
    glViewport(viewport[0], viewport[1], viewport[2], viewport[3]);
    glUseProgram(static_cast<GLuint>(program));
    glDepthMask(depthMask);
    glColorMask(colorMask[0], colorMask[1], colorMask[2], colorMask[3]);

    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, static_cast<GLuint>(tex0));
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, static_cast<GLuint>(tex1));
    glActiveTexture(static_cast<GLenum>(activeTexture));

    setCap(GL_DEPTH_TEST, depth);
    setCap(GL_BLEND, blend);
    setCap(GL_CULL_FACE, cull);
  }

private:
  static void setCap(GLenum cap, GLboolean enabled) {
    enabled ? glEnable(cap) : glDisable(cap);
  }
  GLint program = 0, activeTexture = GL_TEXTURE0, framebuffer = 0, arrayBuffer = 0, vao = 0;
  GLint viewport[4] = {0,0,0,0};
  GLint tex0 = 0, tex1 = 0;
  GLboolean depth = GL_FALSE, blend = GL_FALSE, cull = GL_FALSE;
  GLboolean depthMask = GL_TRUE;
  GLboolean colorMask[4] = {GL_TRUE,GL_TRUE,GL_TRUE,GL_TRUE};
};

class FayFpsMod {
public:
  static FayFpsMod& instance() {
    static FayFpsMod mod;
    return mod;
  }

  FayFpsMod() : self(*ll::mod::NativeMod::current()) {}

  bool load() {
    self.getLogger().info("Fay FPS Optimizer loading");
    return true;
  }

  bool enable() {
    if (!hookEgl()) return false;
    installGameHooks();
    registerMenus();
    self.getLogger().info("Fay FPS Optimizer enabled");
    return true;
  }

  bool disable() {
    pl::modmenu::unregisterModule(kExtremeModule);
    pl::modmenu::unregisterModule(kGameModule);
    pl::modmenu::unregisterModule(kParticlesModule);
    pl::modmenu::unregisterModule(kSoundModule);
    swapHook.reset();
    intervalHook.reset();
    gameHooks.clear();
    destroyGl();
    self.getLogger().info("Fay FPS Optimizer disabled");
    return true;
  }

  bool unload() {
    self.getLogger().info("Fay FPS Optimizer unloaded");
    return true;
  }

private:
  ll::mod::NativeMod& self;

  pl::memory::HookHandle swapHook;
  pl::memory::HookHandle intervalHook;
  std::vector<pl::memory::HookHandle> gameHooks;

  EglSwapBuffersFn originalSwap = nullptr;
  EglSwapIntervalFn originalInterval = nullptr;
  PresentationTimeFn presentationTime = nullptr;

  std::atomic_bool extremeEnabled{true};
  std::atomic_bool gameEnabled{true};
  std::atomic_bool particlesEnabled{true};
  std::atomic_bool soundEnabled{true};

  std::atomic_int frameMode{1};
  std::atomic_int blendStrength{70};
  std::atomic_bool disableVsync{true};
  std::atomic_int minRealFps{20};

  std::atomic_bool skipRain{false};
  std::atomic_bool renderBlockEntities{true};
  std::atomic_bool renderEntityEffects{true};

  std::atomic_bool masterParticles{true};
  std::atomic_bool explosionParticles{false};
  std::atomic_bool terrainParticles{true};
  std::atomic_bool breakingParticles{true};
  std::atomic_bool smokeParticles{true};

  std::atomic_int masterSound{100};
  std::atomic_int repeatedMobSound{45};
  std::atomic_int explosionSound{60};

  bool vsyncApplied = false;
  bool glReady = false;
  bool haveHistory = false;
  bool gameHooksRetried = false;
  GLsizei width = 0, height = 0;
  GLuint texPrev = 0, texCur = 0;
  GLuint program = 0, vao = 0;
  GLint locPos = -1, locUv = -1, locPrev = -1, locCur = -1, locT = -1, locStrength = -1;
  int64_t lastCallNs = 0;
  int64_t lastPresentNs = 0;

  using SpawnParticleFn = void(*)(void*, const std::string&, const void*, void*);
  using TerrainParticleFn = void(*)(void*, const void*, const void*, const void*, float, float, float);
  using BreakingParticleFn = void(*)(void*, const void*, const void*, const void*);
  using SmokeParticleFn = void(*)(void*, int, const void*, int);
  using TickRainFn = void(*)(void*);
  using RenderBlockEntitiesFn = void(*)(void*, void*, bool);
  using RenderEntityEffectsFn = void(*)(void*, void*);
  using DeferredSoundFn = void(*)(void*, const std::string&, const void*, float, float);

  SpawnParticleFn originalSpawnParticle = nullptr;
  TerrainParticleFn originalTerrainParticle = nullptr;
  TerrainParticleFn originalTerrainSlide = nullptr;
  BreakingParticleFn originalBreakingParticle = nullptr;
  SmokeParticleFn originalSmokeParticle = nullptr;
  TickRainFn originalTickRain = nullptr;
  RenderBlockEntitiesFn originalRenderBlockEntities = nullptr;
  RenderEntityEffectsFn originalRenderEntityEffects = nullptr;
  DeferredSoundFn originalDeferredSound = nullptr;

  static constexpr const char* sSpawnParticle =
      "_ZN5Level19spawnParticleEffectERKNSt6__ndk112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEERK4Vec3P9Dimension";
  static constexpr const char* sTerrainParticle =
      "_ZN19LevelRendererPlayer24addTerrainParticleEffectERK8BlockPosRK5BlockRK4Vec3fff";
  static constexpr const char* sTerrainSlide =
      "_ZN19LevelRendererPlayer21addTerrainSlideEffectERK8BlockPosRK5BlockRK4Vec3fff";
  static constexpr const char* sBreakingParticle =
      "_ZN19LevelRendererPlayer29addBreakingItemParticleEffectERK4Vec3RK24BreakingItemParticleDataRK20ResolvedItemIconInfo";
  static constexpr const char* sSmokeParticle =
      "_ZN19LevelRendererPlayer20_spawnSmokeParticlesE12ParticleTypeRK4Vec3i";
  static constexpr const char* sTickRain =
      "_ZN19LevelRendererPlayer8tickRainEv";
  static constexpr const char* sRenderBlockEntities =
      "_ZN19LevelRendererPlayer19renderBlockEntitiesER22BaseActorRenderContextb";
  static constexpr const char* sRenderEntityEffects =
      "_ZN19LevelRendererPlayer19renderEntityEffectsER22BaseActorRenderContext";
  static constexpr const char* sDeferredSound =
      "_ZN19LevelRendererPlayer17playDeferredSoundERKNSt6__ndk112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEERK4Vec3ff";

  bool hookEgl() {
    void* swap = dlsym(RTLD_DEFAULT, "eglSwapBuffers");
    if (!swap) {
      self.getLogger().error("eglSwapBuffers not found");
      return false;
    }
    swapHook = pl::memory::HookHandle(
        swap, reinterpret_cast<void*>(&swapDetour),
        reinterpret_cast<void**>(&originalSwap),
        pl::memory::HookPriority::Normal);
    if (!swapHook.installed()) {
      self.getLogger().error("Failed to hook eglSwapBuffers");
      return false;
    }

    void* interval = dlsym(RTLD_DEFAULT, "eglSwapInterval");
    if (interval) {
      intervalHook = pl::memory::HookHandle(
          interval, reinterpret_cast<void*>(&intervalDetour),
          reinterpret_cast<void**>(&originalInterval),
          pl::memory::HookPriority::Normal);
    }

    presentationTime = reinterpret_cast<PresentationTimeFn>(
        eglGetProcAddress("eglPresentationTimeANDROID"));

    gGenVao = reinterpret_cast<GenVertexArraysFn>(eglGetProcAddress("glGenVertexArraysOES"));
    gBindVao = reinterpret_cast<BindVertexArrayFn>(eglGetProcAddress("glBindVertexArrayOES"));
    gDeleteVao = reinterpret_cast<DeleteVertexArraysFn>(eglGetProcAddress("glDeleteVertexArraysOES"));
    if (!gGenVao || !gBindVao || !gDeleteVao) {
      gGenVao = reinterpret_cast<GenVertexArraysFn>(eglGetProcAddress("glGenVertexArrays"));
      gBindVao = reinterpret_cast<BindVertexArrayFn>(eglGetProcAddress("glBindVertexArray"));
      gDeleteVao = reinterpret_cast<DeleteVertexArraysFn>(eglGetProcAddress("glDeleteVertexArrays"));
    }
    return true;
  }

  void registerMenus() {
    pl::modmenu::ModuleBuilder(kExtremeModule, "Extreme FPS")
      .modId(self.getId())
      .description("Frame generation + V-Sync bypass. Frame Mode: 0=Off, 1=2x display FPS, 2=3x display FPS.")
      .defaultEnabled(true)
      .config(kFrameMode, "Frame Mode (0 Off / 1 2x / 2 3x)", pl::modmenu::ConfigType::SliderInt, "1", "0", "2")
      .config(kBlendStrength, "Interpolation Blend %", pl::modmenu::ConfigType::SliderInt, "70", "0", "100")
      .config(kDisableVsync, "Disable V-Sync", pl::modmenu::ConfigType::Toggle, "true")
      .config(kMinRealFps, "Stop FrameGen below real FPS", pl::modmenu::ConfigType::SliderInt, "20", "0", "60")
      .onToggle(onToggle)
      .onConfigChanged(onConfig)
      .registerModule();

    pl::modmenu::ModuleBuilder(kGameModule, "Game System")
      .modId(self.getId())
      .description("Optional renderer cuts for maximum performance. Risky visual cuts are OFF by default.")
      .defaultEnabled(true)
      .config(kSkipRain, "Disable Rain Tick/Effects", pl::modmenu::ConfigType::Toggle, "false")
      .config(kRenderBlockEntities, "Render Block Entities", pl::modmenu::ConfigType::Toggle, "true")
      .config(kRenderEntityEffects, "Render Entity Effects", pl::modmenu::ConfigType::Toggle, "true")
      .onToggle(onToggle)
      .onConfigChanged(onConfig)
      .registerModule();

    pl::modmenu::ModuleBuilder(kParticlesModule, "Particles & Effects")
      .modId(self.getId())
      .description("Reduce particles that can spike GPU/CPU load. Explosion particles default OFF.")
      .defaultEnabled(true)
      .config(kMasterParticles, "Master Particles", pl::modmenu::ConfigType::Toggle, "true")
      .config(kExplosionParticles, "Explosion Particles", pl::modmenu::ConfigType::Toggle, "false")
      .config(kTerrainParticles, "Terrain Particles", pl::modmenu::ConfigType::Toggle, "true")
      .config(kBreakingParticles, "Item Break Particles", pl::modmenu::ConfigType::Toggle, "true")
      .config(kSmokeParticles, "Smoke Particles", pl::modmenu::ConfigType::Toggle, "true")
      .onToggle(onToggle)
      .onConfigChanged(onConfig)
      .registerModule();

    pl::modmenu::ModuleBuilder(kSoundModule, "Sound Control")
      .modId(self.getId())
      .description("Reduce loud/repeated sounds without muting the whole game.")
      .defaultEnabled(true)
      .config(kMasterSound, "All Sound Volume %", pl::modmenu::ConfigType::SliderInt, "100", "0", "100")
      .config(kRepeatedMobSound, "Repeated Mob/Ambient %", pl::modmenu::ConfigType::SliderInt, "45", "0", "100")
      .config(kExplosionSound, "Explosion Sound %", pl::modmenu::ConfigType::SliderInt, "60", "0", "100")
      .onToggle(onToggle)
      .onConfigChanged(onConfig)
      .registerModule();
  }

  static void onToggle(std::string_view module, bool enabled) {
    auto& m = instance();
    if (module == kExtremeModule) {
      m.extremeEnabled.store(enabled);
      m.haveHistory = false;
    } else if (module == kGameModule) {
      m.gameEnabled.store(enabled);
    } else if (module == kParticlesModule) {
      m.particlesEnabled.store(enabled);
    } else if (module == kSoundModule) {
      m.soundEnabled.store(enabled);
    }
  }

  static void onConfig(std::string_view module, std::string_view key, std::string_view value) {
    auto& m = instance();
    if (module == kExtremeModule) {
      if (key == kFrameMode) {
        m.frameMode.store(parseInt(value, 0, 2, 1));
        m.haveHistory = false;
      } else if (key == kBlendStrength) {
        m.blendStrength.store(parseInt(value, 0, 100, 70));
      } else if (key == kDisableVsync) {
        m.disableVsync.store(parseBool(value));
        m.vsyncApplied = false;
      } else if (key == kMinRealFps) {
        m.minRealFps.store(parseInt(value, 0, 60, 20));
      }
    } else if (module == kGameModule) {
      if (key == kSkipRain) m.skipRain.store(parseBool(value));
      else if (key == kRenderBlockEntities) m.renderBlockEntities.store(parseBool(value));
      else if (key == kRenderEntityEffects) m.renderEntityEffects.store(parseBool(value));
    } else if (module == kParticlesModule) {
      if (key == kMasterParticles) m.masterParticles.store(parseBool(value));
      else if (key == kExplosionParticles) m.explosionParticles.store(parseBool(value));
      else if (key == kTerrainParticles) m.terrainParticles.store(parseBool(value));
      else if (key == kBreakingParticles) m.breakingParticles.store(parseBool(value));
      else if (key == kSmokeParticles) m.smokeParticles.store(parseBool(value));
    } else if (module == kSoundModule) {
      if (key == kMasterSound) m.masterSound.store(parseInt(value, 0, 100, 100));
      else if (key == kRepeatedMobSound) m.repeatedMobSound.store(parseInt(value, 0, 100, 45));
      else if (key == kExplosionSound) m.explosionSound.store(parseInt(value, 0, 100, 60));
    }
  }

  void* gameHandle() {
    static void* h = nullptr;
    if (!h) {
      h = dlopen("libminecraftpe.so", RTLD_NOW | RTLD_NOLOAD);
      if (!h) h = dlopen("libminecraftpe.so", RTLD_NOW);
    }
    return h;
  }

  void* resolveGame(const char* symbol) {
    void* p = dlsym(RTLD_DEFAULT, symbol);
    if (p) return p;
    void* h = gameHandle();
    return h ? dlsym(h, symbol) : nullptr;
  }

  template <typename Fn>
  void installOptional(const char* label, const char* symbol, void* detour, Fn& original) {
    void* target = resolveGame(symbol);
    if (!target) {
      self.getLogger().info("{} hook unavailable on this Minecraft build", label);
      return;
    }
    pl::memory::HookHandle h(
        target, detour, reinterpret_cast<void**>(&original),
        pl::memory::HookPriority::Normal);
    if (h.installed()) {
      gameHooks.emplace_back(std::move(h));
      self.getLogger().info("{} hook installed", label);
    } else {
      self.getLogger().info("{} hook failed; feature will pass through", label);
    }
  }

  void installGameHooks() {
    if (!gameHooks.empty()) return;
    installOptional("named particles", sSpawnParticle, reinterpret_cast<void*>(&spawnParticleDetour), originalSpawnParticle);
    installOptional("terrain particles", sTerrainParticle, reinterpret_cast<void*>(&terrainParticleDetour), originalTerrainParticle);
    installOptional("terrain slide", sTerrainSlide, reinterpret_cast<void*>(&terrainSlideDetour), originalTerrainSlide);
    installOptional("item break particles", sBreakingParticle, reinterpret_cast<void*>(&breakingParticleDetour), originalBreakingParticle);
    installOptional("smoke particles", sSmokeParticle, reinterpret_cast<void*>(&smokeParticleDetour), originalSmokeParticle);
    installOptional("rain", sTickRain, reinterpret_cast<void*>(&tickRainDetour), originalTickRain);
    installOptional("block entities", sRenderBlockEntities, reinterpret_cast<void*>(&renderBlockEntitiesDetour), originalRenderBlockEntities);
    installOptional("entity effects", sRenderEntityEffects, reinterpret_cast<void*>(&renderEntityEffectsDetour), originalRenderEntityEffects);
    installOptional("deferred sound", sDeferredSound, reinterpret_cast<void*>(&deferredSoundDetour), originalDeferredSound);
  }

  static EGLBoolean swapDetour(EGLDisplay dpy, EGLSurface surface) {
    return instance().handleSwap(dpy, surface);
  }

  static EGLBoolean intervalDetour(EGLDisplay dpy, EGLint interval) {
    auto& m = instance();
    if (!m.originalInterval) return EGL_FALSE;
    if (m.extremeEnabled.load() && m.disableVsync.load()) return m.originalInterval(dpy, 0);
    return m.originalInterval(dpy, interval);
  }

  EGLBoolean handleSwap(EGLDisplay dpy, EGLSurface surface) {
    if (!originalSwap) return EGL_FALSE;

    if (!gameHooksRetried && gameHooks.empty()) {
      gameHooksRetried = true;
      installGameHooks();
    }

    if (extremeEnabled.load() && disableVsync.load() && originalInterval && !vsyncApplied) {
      originalInterval(dpy, 0);
      vsyncApplied = true;
    }

    int mode = frameMode.load();
    if (!extremeEnabled.load() || mode <= 0 || !presentationTime || !gBindVao) {
      haveHistory = false;
      return originalSwap(dpy, surface);
    }

    EGLint w = 0, h = 0;
    if (!eglQuerySurface(dpy, surface, EGL_WIDTH, &w) ||
        !eglQuerySurface(dpy, surface, EGL_HEIGHT, &h) ||
        w <= 0 || h <= 0 || !ensureGl(w, h)) {
      return originalSwap(dpy, surface);
    }

    int64_t now = std::chrono::duration_cast<std::chrono::nanoseconds>(
        std::chrono::steady_clock::now().time_since_epoch()).count();

    int threshold = minRealFps.load();
    if (threshold > 0 && lastCallNs > 0) {
      int64_t dt = now - lastCallNs;
      if (dt > (1000000000LL / threshold)) {
        haveHistory = false;
        lastCallNs = now;
        return originalSwap(dpy, surface);
      }
    }

    GlStateGuard guard;
    capture();

    if (!haveHistory) {
      EGLBoolean r = originalSwap(dpy, surface);
      haveHistory = true;
      lastCallNs = now;
      lastPresentNs = now;
      std::swap(texPrev, texCur);
      return r;
    }

    int64_t intervalNs = std::clamp<int64_t>(now - lastCallNs, 2'000'000LL, 100'000'000LL);
    float strength = static_cast<float>(blendStrength.load()) / 100.f;

    for (int i = 1; i <= mode; ++i) {
      float t = static_cast<float>(i) / static_cast<float>(mode + 1);
      int64_t ts = lastPresentNs + static_cast<int64_t>(static_cast<double>(intervalNs) * t);
      presentationTime(dpy, surface, ts);
      drawBlend(t, strength);
      originalSwap(dpy, surface);
    }

    int64_t realTs = lastPresentNs + intervalNs;
    presentationTime(dpy, surface, realTs);
    drawBlend(1.f, 1.f);
    EGLBoolean result = originalSwap(dpy, surface);

    lastPresentNs = realTs;
    lastCallNs = now;
    std::swap(texPrev, texCur);
    return result;
  }

  bool ensureGl(GLsizei w, GLsizei h) {
    if (!program && !buildProgram()) return false;
    if (!vao) gGenVao(1, &vao);

    if (glReady && width == w && height == h) return true;
    destroyTextures();

    texPrev = createTexture(w, h);
    texCur = createTexture(w, h);
    if (!texPrev || !texCur) {
      destroyTextures();
      return false;
    }
    width = w;
    height = h;
    glReady = true;
    haveHistory = false;
    return true;
  }

  GLuint createTexture(GLsizei w, GLsizei h) {
    GLuint t = 0;
    glGenTextures(1, &t);
    if (!t) return 0;
    glBindTexture(GL_TEXTURE_2D, t);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, nullptr);
    return t;
  }

  void capture() {
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    glBindTexture(GL_TEXTURE_2D, texCur);
    glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0, width, height);
  }

  void drawBlend(float t, float strength) {
    gBindVao(vao);
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    glViewport(0, 0, width, height);
    glDisable(GL_DEPTH_TEST);
    glDisable(GL_BLEND);
    glDisable(GL_CULL_FACE);
    glDepthMask(GL_FALSE);
    glColorMask(GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE);

    glUseProgram(program);
    glBindBuffer(GL_ARRAY_BUFFER, 0);

    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texPrev);
    glUniform1i(locPrev, 0);
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, texCur);
    glUniform1i(locCur, 1);
    glUniform1f(locT, t);
    glUniform1f(locStrength, strength);

    glVertexAttribPointer(static_cast<GLuint>(locPos), 2, GL_FLOAT, GL_FALSE, 4*sizeof(float), kQuad);
    glEnableVertexAttribArray(static_cast<GLuint>(locPos));
    glVertexAttribPointer(static_cast<GLuint>(locUv), 2, GL_FLOAT, GL_FALSE, 4*sizeof(float), kQuad + 2);
    glEnableVertexAttribArray(static_cast<GLuint>(locUv));
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glDisableVertexAttribArray(static_cast<GLuint>(locPos));
    glDisableVertexAttribArray(static_cast<GLuint>(locUv));
  }

  GLuint compile(GLenum type, const char* src) {
    GLuint s = glCreateShader(type);
    glShaderSource(s, 1, &src, nullptr);
    glCompileShader(s);
    GLint ok = GL_FALSE;
    glGetShaderiv(s, GL_COMPILE_STATUS, &ok);
    if (!ok) {
      glDeleteShader(s);
      return 0;
    }
    return s;
  }

  bool buildProgram() {
    GLuint vs = compile(GL_VERTEX_SHADER, kVs);
    GLuint fs = compile(GL_FRAGMENT_SHADER, kFs);
    if (!vs || !fs) {
      if (vs) glDeleteShader(vs);
      if (fs) glDeleteShader(fs);
      return false;
    }
    program = glCreateProgram();
    glAttachShader(program, vs);
    glAttachShader(program, fs);
    glBindAttribLocation(program, 0, "aPos");
    glBindAttribLocation(program, 1, "aUV");
    glLinkProgram(program);
    glDeleteShader(vs);
    glDeleteShader(fs);

    GLint ok = GL_FALSE;
    glGetProgramiv(program, GL_LINK_STATUS, &ok);
    if (!ok) {
      glDeleteProgram(program);
      program = 0;
      return false;
    }

    locPos = glGetAttribLocation(program, "aPos");
    locUv = glGetAttribLocation(program, "aUV");
    locPrev = glGetUniformLocation(program, "uPrev");
    locCur = glGetUniformLocation(program, "uCur");
    locT = glGetUniformLocation(program, "uT");
    locStrength = glGetUniformLocation(program, "uStrength");
    return locPos >= 0 && locUv >= 0 && locPrev >= 0 && locCur >= 0 && locT >= 0 && locStrength >= 0;
  }

  void destroyTextures() {
    if (texPrev) glDeleteTextures(1, &texPrev);
    if (texCur) glDeleteTextures(1, &texCur);
    texPrev = texCur = 0;
  }

  void destroyGl() {
    destroyTextures();
    if (program) glDeleteProgram(program);
    program = 0;
    if (vao && gDeleteVao) gDeleteVao(1, &vao);
    vao = 0;
    glReady = false;
    haveHistory = false;
    width = height = 0;
  }

  static bool isExplosionName(const std::string& name) {
    return containsToken(name, "explosion") || containsToken(name, "explode") ||
           containsToken(name, "largeexplode") || containsToken(name, "hugeexplosion");
  }

  static bool isRepeatedMobSound(const std::string& name) {
    return containsToken(name, "ambient") || containsToken(name, "idle") ||
           containsToken(name, ".say") || containsToken(name, "step") ||
           containsToken(name, "breathe") || containsToken(name, "breath");
  }

  static void spawnParticleDetour(void* thiz, const std::string& name, const void* pos, void* dim) {
    auto& m = instance();
    if (!m.originalSpawnParticle) return;
    if (m.particlesEnabled.load()) {
      if (!m.masterParticles.load()) return;
      if (!m.explosionParticles.load() && isExplosionName(name)) return;
    }
    m.originalSpawnParticle(thiz, name, pos, dim);
  }

  static void terrainParticleDetour(void* thiz, const void* pos, const void* block, const void* emitter,
                                    float count, float velocity, float radius) {
    auto& m = instance();
    if (!m.originalTerrainParticle) return;
    if (m.particlesEnabled.load() && (!m.masterParticles.load() || !m.terrainParticles.load())) return;
    m.originalTerrainParticle(thiz, pos, block, emitter, count, velocity, radius);
  }

  static void terrainSlideDetour(void* thiz, const void* pos, const void* block, const void* emitter,
                                 float count, float velocity, float radius) {
    auto& m = instance();
    if (!m.originalTerrainSlide) return;
    if (m.particlesEnabled.load() && (!m.masterParticles.load() || !m.terrainParticles.load())) return;
    m.originalTerrainSlide(thiz, pos, block, emitter, count, velocity, radius);
  }

  static void breakingParticleDetour(void* thiz, const void* pos, const void* data, const void* tex) {
    auto& m = instance();
    if (!m.originalBreakingParticle) return;
    if (m.particlesEnabled.load() && (!m.masterParticles.load() || !m.breakingParticles.load())) return;
    m.originalBreakingParticle(thiz, pos, data, tex);
  }

  static void smokeParticleDetour(void* thiz, int particleType, const void* pos, int data) {
    auto& m = instance();
    if (!m.originalSmokeParticle) return;
    if (m.particlesEnabled.load() && (!m.masterParticles.load() || !m.smokeParticles.load())) return;
    m.originalSmokeParticle(thiz, particleType, pos, data);
  }

  static void tickRainDetour(void* thiz) {
    auto& m = instance();
    if (!m.originalTickRain) return;
    if (m.gameEnabled.load() && m.skipRain.load()) return;
    m.originalTickRain(thiz);
  }

  static void renderBlockEntitiesDetour(void* thiz, void* ctx, bool alpha) {
    auto& m = instance();
    if (!m.originalRenderBlockEntities) return;
    if (m.gameEnabled.load() && !m.renderBlockEntities.load()) return;
    m.originalRenderBlockEntities(thiz, ctx, alpha);
  }

  static void renderEntityEffectsDetour(void* thiz, void* ctx) {
    auto& m = instance();
    if (!m.originalRenderEntityEffects) return;
    if (m.gameEnabled.load() && !m.renderEntityEffects.load()) return;
    m.originalRenderEntityEffects(thiz, ctx);
  }

  static void deferredSoundDetour(void* thiz, const std::string& name, const void* pos, float volume, float pitch) {
    auto& m = instance();
    if (!m.originalDeferredSound) return;
    if (m.soundEnabled.load()) {
      float scale = static_cast<float>(m.masterSound.load()) / 100.f;
      if (isExplosionName(name)) scale *= static_cast<float>(m.explosionSound.load()) / 100.f;
      else if (isRepeatedMobSound(name)) scale *= static_cast<float>(m.repeatedMobSound.load()) / 100.f;
      volume *= scale;
      if (volume <= 0.001f) return;
    }
    m.originalDeferredSound(thiz, name, pos, volume, pitch);
  }
};

} // namespace

PL_REGISTER_MOD(FayFpsMod, FayFpsMod::instance())
