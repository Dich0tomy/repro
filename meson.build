project('repro', 'cpp')

local_deps = [
  dependency('threads'),

  # Why do I even have to specify glfw3?
  dependency('glfw3'),
  dependency('rmlui')
]

include_dirs = include_directories('src')

sources = files(
  'src/rmlui_backend_glfw_gl3.cpp',
  'src/rmlui_platform_glfw.cpp',
  'src/rmlui_renderer_gl3.cpp',

  'src/main.cpp'
)

executable(
  'repro',
  sources,
  dependencies: [ local_deps ]
)
