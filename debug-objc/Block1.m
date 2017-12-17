//
//  Block1.m
//  debug-objc
//
//  Created by CKK on 2017/12/16.
//

#import "Block1.h"

@implementation Block1

-(instancetype)init
{
    if (self = [super init]) {
        int * agePointer = &_age;
        _age = 1;
        self.block = ^{
            NSLog(@"%d",*agePointer);
        };
        self.block();
        _age = 2;
        self.block();
        
    }
    return self;
}

@end
