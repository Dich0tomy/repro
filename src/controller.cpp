#include <utility>

#include <fmt/format.h>

#include <drogon/HttpTypes.h>

#include <controller.hpp>

namespace
{

auto log(drogon::HttpRequestPtr const& req)
{
	fmt::print("Path: [{}] [{}]\n", req->getPath(), req->getPath());
  fmt::print("Method string: [{}]\n", req->methodString());

  auto constexpr method = [](drogon::HttpMethod m) {
    switch(m) {
      case drogon::Get: return "Get";
      case drogon::Post: return "Post";
      case drogon::Head: return "Head";
      case drogon::Put: return "Put";
      case drogon::Delete: return "Delete";
      case drogon::Options: return "Options";
      case drogon::Patch: return "Patch";
      case drogon::Invalid: return "Invalid";
    }
    std::unreachable();
  };

	fmt::print("Method: [{}]\n", method(req->method()));
}

} // namespace detail

auto DebugPathController::path(Request const& req, Callback&& callback) -> void
{
  log(req);
  callback(drogon::HttpResponse::newHttpResponse(drogon::k200OK, drogon::ContentType::CT_APPLICATION_JSON));
}

auto DebugPathController::get(Request const& req, Callback&& callback) const -> void
{
  log(req);

  (void)req;
	fmt::print("GET handler");
  auto json = Json::Value();
  json["msg"] = "get";
  callback(drogon::HttpResponse::newHttpJsonResponse(std::move(json)));
}

auto DebugPathController::post(Request const& req, Callback&& callback) -> void
{
  log(req);

  (void)req;
	fmt::print("POST handler");
  auto json = Json::Value();
  json["msg"] = "post";
  callback(drogon::HttpResponse::newHttpJsonResponse(std::move(json)));
}

auto DebugPathController::patch(Request const& req, Callback&& callback) -> void
{
  log(req);

  (void)req;
	fmt::print("PATCH handler");
  auto json = Json::Value();
  json["msg"] = "patch";
  callback(drogon::HttpResponse::newHttpJsonResponse(std::move(json)));
}
