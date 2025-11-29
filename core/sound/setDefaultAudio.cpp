#include <iostream>
#include <string>
#include <cstdio>
#include <memory>
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

int main(int argc, char const *argv[]) {
    if (argc < 3) {
        std::cerr << "Please input the device type and name";
        return 1;
    }
    std::string type = argv[1];
    if (type != "--sink" && type != "--source") {
        std::cerr << "please chose device type (--sink or --source)";
        return 2;
    }

    type.erase(0, 2);
    type[0] = toupper(type[0]);

    std::string name = argv[2];

    std::string cmd = "pw-dump -N";
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
