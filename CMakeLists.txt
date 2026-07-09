cmake_minimum_required( VERSION 3.0 )
project(repro)

file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS "./src/*.cpp")

add_executable(repro ${SOURCES})

target_compile_features(repro PUBLIC cxx_std_23)

target_include_directories(repro PRIVATE "./src/")

find_package(Drogon REQUIRED)

target_link_libraries(
	repro
	PRIVATE
			fmt
			Drogon::Drogon
)
