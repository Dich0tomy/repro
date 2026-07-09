#include <fmt/format.h>
#include <dire/all.hpp>

int main() {
  fmt::print(
  	"Some other: {}\nConfig path: {}",
		dire::user::picture_dir()->string(),
		dire::project::config_local_dir(
			dire::project::name("me", "dich0tomy", "blanket")
		)->string()
	);
}
