#import "TickManager.h"

@implementation TickManager

- (void)startTickLoop {
    [NSThread detachNewThreadSelector:@selector(runTickLoop) toTarget:self withObject:nil];

}

// 나중에 직접 clock register에 접근하는 방식으로 개선하기
- (void)runTickLoop {
    NSLog(@"tickthread is working!");
// Thread Priority 를 높게 설정할수록 오차가 준다.
    [ NSThread setThreadPriority:1.0];
    double gapSumPerSecond = 0;
    double tickPerSecond = 60;
    double prevSecondGapAverage = 0;
    while ([[NSThread currentThread] isCancelled] == false) {
        gapSumPerSecond = 0;
        NSDate *fullTime = [NSDate date];
        for (int step = 0; step < tickPerSecond; step++) {
            NSDate *date = [NSDate date];

// do something
            int a = 5;
            for (int i = 0; i < 30000; i++) {
                a += 1;
            }

            NSTimeInterval sleepTime = (1 / tickPerSecond) + [date timeIntervalSinceNow] - (prevSecondGapAverage / 1000);
//NSLog(@"Predicted Sleep Time(ms): : %f", sleepTime * 1000); // average is 9.99ms
            NSDate *newDate = [NSDate date];
            [NSThread sleepForTimeInterval:sleepTime];
            double actualSleepTime = [newDate timeIntervalSinceNow] * -1000 ;
            gapSumPerSecond += actualSleepTime - (sleepTime * 1000);
//NSLog(@"Actual Sleep Time(ms): %f", gapSumPerSecond); // average is 12.77 ms. Why?
        }
        NSLog(@"-----Tick loop was done by %f (ms)-----",
              [fullTime timeIntervalSinceNow] * -1000); // average is 1200ms(1.2s).
        prevSecondGapAverage = gapSumPerSecond / tickPerSecond;
        NSLog(@"-----Gap Average : %f (ms)-----", prevSecondGapAverage);
    }
}

@end