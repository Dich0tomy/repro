#include <expected>
#include <iostream> // Included to have a valid std:: namespace

using T = std::expected<int, int>;
auto main() -> int {
  //  __cpp_concepts >= 202002L && __cplusplus > 202002L
  // 201907 && 202302
  std::cout << __cpp_concepts << __cplusplus;
}
