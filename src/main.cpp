#include <memory>

#include <drogon/drogon.h>

#include <controller.hpp>

auto main() -> int {
	drogon::app()
			.registerController(std::make_shared<DebugPathController>())
			.addListener("127.0.0.1", 1234)
			.run();
}
