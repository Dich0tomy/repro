cmake_minimum_required( VERSION 3.25 )

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED YES)

set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POLICY_VERSION_MINIMUM 3.5)

project(repro)

add_subdirectory(vendor)
add_subdirectory(src)
