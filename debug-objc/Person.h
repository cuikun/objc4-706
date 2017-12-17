//
//  Person.h
//  objc
//
//  Created by 蓝布鲁 on 2016/12/29.
//
//

#import <Foundation/Foundation.h>
#import "Dog.h"

@protocol PersonDelegate

-(void)eatfood:(NSString *)food;

@end

@interface Person : NSObject<PersonDelegate>

@property (nonatomic,copy) NSString * name;
@property (nonatomic,strong)Dog * dog;
@property (nonatomic,copy) NSMutableArray * mutableArray;

+(NSString *)species;
-(void)sayHello;

-(void)run;

@end

