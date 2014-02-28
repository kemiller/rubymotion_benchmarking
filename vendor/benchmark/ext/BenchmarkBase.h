#import <objc/message.h>

@interface BenchmarkBase : NSObject

+ (void)defineMethod:(NSString *)name value: (NSObject *)val;
- (void)m;
- (double)benchmark: (int) times;
- (double)benchmark_send: (int) times;
- (double)benchmark_ruby: (int) times with_object: (id)o and_selector: (SEL)s;

@end
