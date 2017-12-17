//
//  Person.m
//  objc
//
//  Created by 蓝布鲁 on 2016/12/29.
//
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person
{
    int _age;
    NSString * fatherName;
    float _height;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        NSLog(@"super class:%@",NSStringFromClass([super class]));
//        NSLog(@"self class:%@",NSStringFromClass([self class]));
        
        _age = 3;
        fatherName = @"laocui";
        _height = 1.55;
        
        
//        [self.dog addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

+(NSString *)species{
    NSLog(@"%s --- %d --- %s---%s",__PRETTY_FUNCTION__, __LINE__,__func__,__FUNCTION__);
    return @"Person";
}

-(void)run
{
    NSLog(@"person class run");
}

-(void)sayHello{
    NSLog(@"!!!");
    NSLog(@"%s --- %d --- %s---%s",__PRETTY_FUNCTION__, __LINE__,__func__,__FUNCTION__);
}

-(void)eatfood:(NSString *)food
{
    NSLog(@"eat %@",food);
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"name:%@,age:%d,fatherName:%@,height:%.2fmeter",self.name,_age,fatherName,_height];
}

#pragma mark - getter|setter

-(Dog *)dog
{
    if (!_dog) {
        _dog = [[Dog alloc]init];
    }
    return _dog;
}


void dynamicAddMethod1(id self,SEL _cmd)
{
    NSLog(@"不能识别的对象消息：对象-> %@ 消息-> %s",[self class],sel_getName(_cmd));
}

#pragma mark - message forwarding


+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
//    if (sel == @selector(integerValue)) {
        class_addMethod(self, sel, (IMP)dynamicAddMethod1, "v@:");
        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    return NO;
}


// Replaced by CF (returns an NSMethodSignature)
+ (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
//    _objc_fatal("+[NSObject methodSignatureForSelector:] "
//                "not available without CoreFoundation");
    return nil;
}

// Replaced by CF (returns an NSMethodSignature)
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
//    _objc_fatal("-[NSObject methodSignatureForSelector:] "
//                "not available without CoreFoundation");
    return nil;
}

+ (void)forwardInvocation:(NSInvocation *)invocation {
    [self doesNotRecognizeSelector:(invocation ? [invocation selector] : 0)];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [self doesNotRecognizeSelector:(invocation ? [invocation selector] : 0)];
}

+ (id)forwardingTargetForSelector:(SEL)sel {
    return nil;
}

- (id)forwardingTargetForSelector:(SEL)sel {
    return nil;
}



@end
