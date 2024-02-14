cmake_minimum_required( VERSION 3.15 )

project( f VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable( f src/main.cpp )

target_compile_features( f PUBLIC cxx_std_23 )
