#include <pqxx/pqxx>

auto main() -> int {
  auto x = pqxx::connection("psql://asdasdasdk9191");
  (void)x;
}
