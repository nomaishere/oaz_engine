//
// Created by nomamac2 on 2022/11/25.
//

#ifndef APPLICATION_UNIFIED_STATE_GROUP_H
#define APPLICATION_UNIFIED_STATE_GROUP_H

#include <cstdint>
#include "../config.h"


// state에는 getter가 없도록

// M1 Max 10 Core
// L1: 192(inst)+128KB(stateList)(8 performance core) 128(inst)+64(stateList)(2 efficient core)
// L2: 24MB(per core) 4MB(eff core)
// L3: 48MB


// singleState는 하나의 Actor에 귀속됨. 즉 다른 Actor에서 볼수 없음
// UnifiedStateGroup은 다수의 Actor에서 값을 보고 변경할 수 있음

// UnifiedStateGroup은 원소들의 데이터 타입이 같은 State

// DynamicStateGroup은 원소들의 데이터 타입이 달라도 됨

// 한 Level에는 uint16_t가 저장할 수 있는 최대 크기(65,535)만큼 Actor가 존재할 수 있음
// 각 Actor는 생성 시에 고유한 ID를 부여받음.


namespace oaz {

    template<typename T>
    class UnifiedStateGroup {
        T *stateList;
        uint32_t capacity;

    public:
        explicit UnifiedStateGroup(uint32_t capacity = MAX_ACTOR_PER_LEVEL) : stateList(new T[capacity]),
                                                                              capacity(capacity) {}

        void updateSingleState(T data, uint16_t actorID);

        ~UnifiedStateGroup();
    };

}

#endif //APPLICATION_UNIFIED_STATE_GROUP_H
