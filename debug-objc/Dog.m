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
//    _name = name;
}
-(NSString *)name
{
    return @"";//_name;
}

@end
