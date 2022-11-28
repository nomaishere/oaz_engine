
#ifndef TICK_QUEUE_H
#define TICK_QUEUE_H

#include <iostream>
#include <mutex>
#include <atomic>


namespace oaz {
    // TickQueueManager 는 Singleton 으로 제작
    class TickQueueManager {
    private:
        uint8_t queueIndex;

        TickQueueManager();
        TickQueueManager(const TickQueueManager&) = delete;
        void operator=(const TickQueueManager&) = delete;

        static std::mutex _mutex;
        static std::atomic<TickQueueManager*> pInstance;

    public:
        static TickQueueManager& getInstance();
        void (*_p60TpsQueue[256])();


        void addFuncTo60TpsQueue(void (*pt)());
    };
}

#endif