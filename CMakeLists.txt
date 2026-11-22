cmake_minimum_required(VERSION 3.25)

project(
	repro
	DESCRIPTION "repro"
	LANGUAGES C CXX
)

set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_EXTENSIONS OFF)

include(FetchContent)
FetchContent_Declare(
  libpqxx
	GIT_REPOSITORY https://github.com/jtv/libpqxx
	GIT_TAG 8.0.0 # 7.10.7 works
)
FetchContent_MakeAvailable(libpqxx)

add_executable(repro main.cpp)
target_compile_definitions(repro PRIVATE _GLIBCXX_DEBUG=1) # comment that and it works
target_link_libraries(repro PRIVATE pqxx)
