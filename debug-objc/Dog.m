//
//  Dog.m
//  debug-objc
//
//  Created by CKK on 2017/12/4.
//

#import "Dog.h"

@implementation Dog

@synthesize name = _name;

-(void)setName:(NSString *)name
{
//    if (_name != name) {
//        _name = name;
//    }
//    _name = name;
}
-(NSString *)name
{
    return @"";//_name;
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [timer invalidate];
    }];
}

@end
