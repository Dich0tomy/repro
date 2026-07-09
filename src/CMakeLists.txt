add_executable(main main.cpp)

target_compile_features(main PUBLIC cxx_std_23)
target_link_libraries(main PRIVATE fmt portaudio_static)
