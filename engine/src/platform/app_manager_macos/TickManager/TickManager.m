#import "TickManager.h"

@implementation TickManager

- (void)startFixedTickLoop {
    [NSThread detachNewThreadSelector:@selector(run60TickPerSecondLoop) toTarget:self withObject:nil];

}

// 나중에 직접 clock register에 접근하는 방식으로 개선하기
// TODO 데이터 정밀도도 고려해야 함
- (void)run60TickPerSecondLoop {
    // Thread Priority 를 높게 지정할 수록 latency 가 줄어듬
    [NSThread setThreadPriority:1.0];
    NSTimeInterval gapSumPerSecond = 0;
    NSTimeInterval prevLoopGapAverage = 0;
    NSDate *fullTime = [NSDate date];
    NSDate *date = [NSDate date];
    while ([[NSThread currentThread] isCancelled] == false) {
        gapSumPerSecond = 0;
        fullTime = [NSDate now];
        for (int step = 0; step < 60; step++) {
            date = [NSDate now];
            // do something
            int a = 5;
            for (int i = 0; i < 30000; i++) {
                a += 1;
            }

            NSTimeInterval sleepTime = (1 / 60.0) + [date timeIntervalSinceNow] - prevLoopGapAverage ;
            NSDate *newDate = [NSDate date];
            [NSThread sleepForTimeInterval:sleepTime];
            gapSumPerSecond += -[newDate timeIntervalSinceNow] - sleepTime;
        }
        NSLog(@"-----Tick loop was done by %f (ms)-----",
              [fullTime timeIntervalSinceNow] * -1000);
        prevLoopGapAverage = gapSumPerSecond / 60.0;
        NSLog(@"-----Gap Average : %f (ms)-----", prevLoopGapAverage);
    }
}

@end