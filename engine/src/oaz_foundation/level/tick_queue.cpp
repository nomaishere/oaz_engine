//
// Created by nomamac2 on 2022/11/21.
//

#include "tick_queue.h"

namespace oaz {
    TickQueueManager::TickQueueManager() {
        queueIndex = 0;
        for (auto & i : _p60TpsQueue) {
            i = nullptr;
        }
    }

    void TickQueueManager::addFuncTo60TpsQueue(void (*pt)()) {
        this->_p60TpsQueue[queueIndex] = pt;
        queueIndex++;
    }

    // https://www.aristeia.com/Papers/DDJ_Jul_Aug_2004_revised.pdf 해당 논문에 따르면 Double-Check Locking이 결코 Thread-Safe 하지 않음
    // 따라서 Mutex와 Atomic을 도입해서 해결
    TickQueueManager &TickQueueManager::getInstance() {
        TickQueueManager *tmp = pInstance.load();
        if (tmp == nullptr) {
            // lock_guard는 객체 생성시에 lock이 걸리고, 소멸시에 unlock됨
            std::lock_guard<std::mutex> lock(_mutex);
            tmp = pInstance.load();
            if (tmp == nullptr) {
                tmp = new TickQueueManager;
                pInstance.store(tmp);
            }
        }
        return *tmp;
    }

}