include(FetchContent)
include(ExternalProject)

block(PROPAGATE PortAudio)
	FetchContent_Declare(
		PortAudio
		GIT_REPOSITORY https://github.com/PortAudio/portaudio.git
		GIT_TAG v19.7.0
		SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/portaudio
	)
	FetchContent_MakeAvailable(PortAudio)
endblock()

block(PROPAGATE fmt)
	FetchContent_Declare(fmt
		GIT_REPOSITORY https://github.com/fmtlib/fmt.git
		GIT_TAG 12.2.0
		SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/fmt
	)
	FetchContent_MakeAvailable(fmt)
endblock()
