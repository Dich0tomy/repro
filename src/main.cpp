#include <fmt/format.h>

#include <portaudio.h>

auto init_portaudio() -> bool {
  auto const pa_init_result = Pa_Initialize();
  auto const pa_init_error_text = Pa_GetErrorText(pa_init_result);
  auto const pa_init_successful = (pa_init_result == paNoError);

  fmt::println("PortAudio initialization result: {} {}", pa_init_result, pa_init_error_text);

  if (not pa_init_successful) {
    fmt::println(
			stderr,
			"Failed to initialize portaudio. Input and audio playback "
			"won't be available.\n"
			"Error: {}",
			pa_init_error_text
		);
    return false;
  }

  auto num_devices = Pa_GetDeviceCount();
  if (num_devices < 0) {
    fmt::println(stderr, "PortAudio returned an error: {}.", Pa_GetErrorText(pa_init_result));
    return false;
  } else if (num_devices == 0) {
    fmt::println(stderr, "PortAudio hadn't found any feasible devices. The " "repl audio feature will be disabled.");
    return false;
  }

  for (auto i = 0; i < num_devices; i++) {
    auto const device_info = Pa_GetDeviceInfo(i);
    fmt::println("Found audio device: [{}] {}", i, device_info->name);
  }

  return true;
}

auto main() -> int {
  init_portaudio();

  PaStream *stream = nullptr;
  Pa_Initialize();
  Pa_OpenDefaultStream(
		&stream,
		0, // either 1 0 / 0 1
		1,
		paInt16, // sample format
		24000,
		960,
		nullptr,
		nullptr
	);
}
