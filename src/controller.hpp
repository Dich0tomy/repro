#pragma once

#include <functional>

#include <drogon/HttpController.h>

using drogon::Post, drogon::Get, drogon::Options, drogon::Patch;

class DebugPathController : public drogon::HttpController<DebugPathController, false>
{
public:

  METHOD_LIST_BEGIN
  ADD_METHOD_TO(DebugPathController::path, "/post", Post);
  ADD_METHOD_TO(DebugPathController::path, "/get", Get);
  ADD_METHOD_TO(DebugPathController::path, "/patch", Patch);

  ADD_METHOD_TO(DebugPathController::get, "/gpp", Get);
  ADD_METHOD_TO(DebugPathController::post, "/gpp", Post);
  ADD_METHOD_TO(DebugPathController::patch, "/gpp", Patch);
  METHOD_LIST_END

  using Request = drogon::HttpRequestPtr;
  using Callback = std::function<void(drogon::HttpResponsePtr const&)>;

  auto get(Request const& req, Callback&& callback) const -> void;

  auto post(Request const& req, Callback&& callback) -> void;

  auto patch(Request const& req, Callback&& callback) -> void;

  auto path(Request const& req, Callback&& callback) -> void;
};
