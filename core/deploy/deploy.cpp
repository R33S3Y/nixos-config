#include <iostream>
#include <string>
#include <cstdio>
#include <memory>
#include <format>
#include <nlohmann/json.hpp>

std::string runCommand(std::string cmd) {
  std::string result;

  FILE* pipe = popen(cmd.c_str(), "r");
  if (!pipe) return "";

  char buffer[256];
  while (fgets(buffer, sizeof(buffer), pipe)) {
    result += buffer;
  }

  pclose(pipe);

  return result;
}
auto getFlakeInputs(std::string flake) {
  std::string cmd = std::format("nix flake show {} --json", flake);

  auto json = nlohmann::json::parse(runCommand(cmd));
}

int main(int argc, char const *argv[]) {

    std::string cmd = std::form"pw-dump -N";
    auto json = nlohmann::json::parse(runCommand(cmd));



    for (int i = 0; i < json.size(); i++) {
        if (json[i]["info"]["props"]["node.description"] == name && json[i]["info"]["props"]["media.class"] == "Audio/" + type) {
            std::cout << json[i]["id"];
            return 0;
        }
    }
    std::cerr << "Nothing found";
    return 0;
}
