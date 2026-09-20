cmake_minimum_required(VERSION 3.22)
project(fay_fps_optimizer LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(NOT ANDROID)
  message(FATAL_ERROR "Android NDK build required")
endif()

include(FetchContent)

set(PRELOADER_ANDROID_ROOT "" CACHE PATH "Path to LiteLDev/preloader-android")
if(NOT EXISTS "${PRELOADER_ANDROID_ROOT}/include/pl/Mod.hpp")
  message(FATAL_ERROR "PRELOADER_ANDROID_ROOT is invalid")
endif()

if(NOT TARGET preloader)
  add_subdirectory("${PRELOADER_ANDROID_ROOT}" "${CMAKE_BINARY_DIR}/_preloader_android")
endif()

if(NOT TARGET fmt::fmt)
  FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG 11.2.0)
  set(FMT_DOC OFF CACHE BOOL "" FORCE)
  set(FMT_TEST OFF CACHE BOOL "" FORCE)
  set(FMT_INSTALL OFF CACHE BOOL "" FORCE)
  FetchContent_MakeAvailable(fmt)
endif()

find_library(LOG_LIB log)
find_library(EGL_LIB EGL)
find_library(GLES2_LIB GLESv2)

add_library(fayfps_mod SHARED src/FayFpsMod.cpp)
set_target_properties(fayfps_mod PROPERTIES OUTPUT_NAME "fayfps_mod")

target_include_directories(fayfps_mod PRIVATE "${PRELOADER_ANDROID_ROOT}/include")
target_compile_options(fayfps_mod PRIVATE -Wall -Wextra -Wpedantic -fvisibility=hidden -fvisibility-inlines-hidden)

target_link_libraries(fayfps_mod PRIVATE preloader fmt::fmt)
if(LOG_LIB)
  target_link_libraries(fayfps_mod PRIVATE "${LOG_LIB}")
endif()
if(EGL_LIB)
  target_link_libraries(fayfps_mod PRIVATE "${EGL_LIB}")
endif()
if(GLES2_LIB)
  target_link_libraries(fayfps_mod PRIVATE "${GLES2_LIB}")
endif()

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/out/${ANDROID_ABI}")
