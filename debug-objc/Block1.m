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
        __weak typeof(self) weakSelf = self;
        _age = 1;
        _name = @"cui";
        self.block = ^{
            __strong typeof(self) strongSelf = weakSelf;
            NSLog(@"%d",strongSelf->_age);
            NSLog(@"%@",strongSelf->_name);
        };
        self.block();
        _age = 2;
        _name = @"kun";
        self.block();
        
    }
    return self;
}

@end
