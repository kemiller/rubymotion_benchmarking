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

@end
