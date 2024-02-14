#include <iostream>
#include <expected>

using T = std::expected<int, int>;
int main() {
  // 201907 202302 for clang,
  // 202002 202100 for gcc
  std::cout << __cpp_concepts << " " << __cplusplus << std::endl;
}
