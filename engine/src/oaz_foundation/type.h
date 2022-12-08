//
// Created by nomamac2 on 2022/12/07.
//

#ifndef APPLICATION_TYPE_H
#define APPLICATION_TYPE_H

#include <string>

namespace jsontype {
    // deprecated
    struct levelMetaData {
        std::string docType;
        std::string name;
        std::string uuid;
    };

    struct lightActorMetaData {
        std::string name;
        std::string uuid;
    };
}


#endif //APPLICATION_TYPE_H
