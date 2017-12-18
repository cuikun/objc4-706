//
//  userdefaultTest.m
//  debug-objc
//
//  Created by CKK on 2017/12/17.
//

#import "userdefaultTest.h"

@implementation userdefaultTest

-(instancetype)init
{
    if (self = [super init]) {
        NSMutableArray * array = [NSMutableArray arrayWithArray:@[@1,@2,@3,@4,@5,@6]];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"array"];
        NSMutableArray * array1 = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"array"]];
        [array1 addObject:@7];
    }
    return self;
}



@end
