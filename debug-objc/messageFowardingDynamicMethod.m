//
//  messageFowardingDynamicMethod.m
//  debug-objc
//
//  Created by CKK on 2017/12/17.
//

#import "messageFowardingDynamicMethod.h"
#import <objc/runtime.h>
@implementation messageFowardingDynamicMethod

void dynamicAddMethod(id self,SEL _cmd)
{
    NSLog(@"不能识别的对象消息：对象-> %@ 消息-> %s",[self class],sel_getName(_cmd));
}
void dynamicAddMethod2(id self,SEL _cmd)
{
    NSLog(@"不能识别的对象消息：对象-> %@ 消息-> %s",self,sel_getName(_cmd));
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        class_addMethod([self class], sel, (IMP)dynamicAddMethod, "v@:");
    });
    return YES;
}
//
//+ (BOOL)resolveClassMethod:(SEL)sel {
//    return NO;
//    /*
//     同时添加类方法和实例方法的 动态添加， 调用没有实现的实例方法时会崩溃，现在没有找到解决方法
//     */
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = object_getClass([self class]);
//        class_addMethod(class, sel, (IMP)dynamicAddMethod2, "v@:");
//    });
//    return YES;
//}


+ (void)doesNotRecognizeSelector:(SEL)sel {
    NSLog(@"不能识别的对象消息：对象-> %@ 消息-> %s",self,sel_getName(_cmd));
}

// Replaced by CF (throws an NSException)
// 不能识别selector时调用
- (void)doesNotRecognizeSelector:(SEL)sel {
    NSLog(@"不能识别的对象消息：对象-> %@ 消息-> %s",[self class],sel_getName(sel));
}


@end
