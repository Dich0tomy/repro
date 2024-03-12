cmake_minimum_required( VERSION 3.5 )

project(project)


include(FetchContent)
include(ExternalProject)

FetchContent_Declare(
	wolfssl
	GIT_REPOSITORY https://github.com/wolfssl/wolfssl
	GIT_TAG        v5.6.6-stable
)

FetchContent_GetProperties( wolfssl )
if(NOT wolfssl_POPULATED)
	FetchContent_Populate(wolfssl)

	set(WOLFSSL_EXAMPLES OFF CACHE INTERNAL "(Dont build wolfssl examples)")
	set(WOLFSSL_CRYPT_TESTS OFF CACHE INTERNAL "(Dont build wolfssl tests)")

	add_subdirectory( ${wolfssl_SOURCE_DIR} ${wolfssl_BINARY_DIR} )
endif()

FetchContent_Declare(
	jwt-cpp
	GIT_REPOSITORY https://github.com/Thalhammer/jwt-cpp
	GIT_TAG        v0.7.0
)

FetchContent_GetProperties( jwt-cpp )
if(NOT jwt-cpp_POPULATED)
	FetchContent_Populate(jwt-cpp)

	set(JWT_BUILD_EXAMPLES OFF CACHE INTERNAL "(Dont build examples of jwt)")
	set(JWT_BUILD_TESTS OFF CACHE INTERNAL "(Dont build jwt tests)")
	set(JWT_BUILD_DOCS OFF CACHE INTERNAL "(Dont build jwt docs)")
	set(JWT_SSL_LIBRARY "wolfSSL" CACHE INTERNAL "(Use wolfSSL as cryptographic backend)")

	add_subdirectory( ${jwt-cpp_SOURCE_DIR} ${jwt-cpp_BINARY_DIR} )
endif()
