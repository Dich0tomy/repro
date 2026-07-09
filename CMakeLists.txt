cmake_minimum_required(VERSION 3.0)
project(Repro)

file(GLOB_RECURSE PUBLIC_HEADERS CONFIGURE_DEPENDS "src/*.hpp")
file(GLOB_RECURSE PRIVATE_SOURCES CONFIGURE_DEPENDS "src/*.cpp")

add_executable( repro )

target_sources(
	repro
	PUBLIC ${PUBLIC_HEADERS}
	PRIVATE ${PRIVATE_SOURCES} # CHECK THIS
)

target_include_directories(
	repro
	PUBLIC "include/"
	PRIVATE "src/"
)

target_compile_features( repro PUBLIC cxx_std_23 )
