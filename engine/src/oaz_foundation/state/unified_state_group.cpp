//
// Created by nomamac2 on 2022/11/25.
//

#include "unified_state_group.h"


namespace oaz {
    template<typename T>
    void UnifiedStateGroup<T>::updateSingleState(T data, uint16_t actorID) {
        this->stateList[actorID] = data;
    }

    template<typename T>
    UnifiedStateGroup<T>::~UnifiedStateGroup() {
        if (this->stateList) {
            delete[] stateList;
        }
    }
}
