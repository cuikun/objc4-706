//
//  Person+addtional.m
//  debug-objc
//
//  Created by CKK on 2017/12/2.
//

#import "Person+addtional.h"
#import <objc/runtime.h>

@implementation Person (addtional)

@dynamic associatedObject;

- (void)setAssociatedObject:(id)object {
    objc_setAssociatedObject(self, @selector(associatedObject), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedObject {
    return objc_getAssociatedObject(self, @selector(associatedObject));
}



@end
