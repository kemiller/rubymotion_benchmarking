#import "BenchmarkBase.h"
#import <objc/runtime.h>

@implementation BenchmarkBase

+ (void)defineMethod:(NSString *)name value: (NSObject *)val;
{
  IMP imp = imp_implementationWithBlock(^id(BenchmarkBase * base) {
    return val;
  });
  class_addMethod([self class], NSSelectorFromString(name), imp, "@@:");
}

- (void)m;
{
  return;
}

- (double)benchmark: (int)times;
{ 
  NSDate *start = [NSDate date];
    
  for (int c = 0; c < times; c++) {
    [self m];
  }

  return [[NSDate date] timeIntervalSinceDate:start];
}

- (double)benchmark_send: (int) times;
{ 
  NSDate *start = [NSDate date];
    
  for (int c = 0; c < times; c++) {
    objc_msgSend(self, @selector(m));
  }

  return [[NSDate date] timeIntervalSinceDate:start];
}

- (double)benchmark_ruby: (int) times with_object: (id)o and_selector: (SEL)s;
{ 
  NSDate *start = [NSDate date];
    
  for (int c = 0; c < times; c++) {
    objc_msgSend(o, s);
  }

  return [[NSDate date] timeIntervalSinceDate:start];
}

@end
