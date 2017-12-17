//
//  Block.h
//  debug-objc
//
//  Created by CKK on 2017/12/16.
//

#import <Foundation/Foundation.h>

@interface Block1 : NSObject
{
    int _age;
}
@property (nonatomic,copy) void(^block)();


@end
