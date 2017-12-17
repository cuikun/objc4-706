//
//  messageFowardingDynamicMethod.h
//  debug-objc
//
//  Created by CKK on 2017/12/17.
//

#import <Foundation/Foundation.h>
/*
1. 动态解析（Dynamic Method Resolution）
 +(BOOL)resolveInstanceMethod:(SEL)sel;
 +(BOOL)resolveClassMethod:(SEL)sel;
 
当我们调用没有实现的方法[obj msg]，系统会则进入resolveInstanceMethod:(SEL)sel顺着继承链往上查找是否有msg的实现。若没找到，则返回NO，告诉系统没有找到该方法的实现。通过动态加载，我们可以实现在类中先声明方法，在运行时添加方法实现。
 
*/
@interface messageFowardingDynamicMethod : NSObject

@end
