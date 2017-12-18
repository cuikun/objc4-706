//
//  main.m
//  debug-objc
//
//  Created by 蓝布鲁 on 2016/12/29.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"
#import "Block1.h"
#import "messageFowardingDynamicMethod.h"
#import "userdefaultTest.h"




/**
 打印类 cls 的 属性

 @param cls 类
 */
void printPersonIvars(Class cls)
{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList(cls, &count);
    for (unsigned int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * typeEncoding = ivar_getTypeEncoding(ivar);
        ptrdiff_t offset = ivar_getOffset(ivar);
        printf("ivarname:%s,ivartypeEncoding:%s,ivaroffset:%td\n\n",name,typeEncoding,offset);
    }
}

void printPersonMethods(Class cls)
{
    unsigned int count = 0;
    Method * methods = class_copyMethodList(cls, &count);
    for (unsigned int i = 0; i < count; i ++) {
        Method method = methods[i];
        SEL methodName = method_getName(method);
        char * returntype = method_copyReturnType(method);
        struct objc_method_description * description = method_getDescription(method);
        unsigned int NumberOfArguments = method_getNumberOfArguments(method);
        printf("argumentTypes:");
        for (unsigned int m = 0; m < NumberOfArguments; m ++) {
            char * argumentType = method_copyArgumentType(method, m);
            printf("%s ",argumentType);
        }
        const char * typeEncoding = method_getTypeEncoding(method);
        IMP imp = method_getImplementation(method);
        
        printf("methodName:%s,returntype:%s,typeEncoding:%s,imp:%p,NumberOfArguments:%u,description:name->%s,arguments:%s\n\n",sel_getName(methodName),returntype,typeEncoding,imp,NumberOfArguments,sel_getName(description->name),description->types);
    }
}

void printPersonPropertys(Class cls)
{
    unsigned int count = 0;
    objc_property_t * propertys = class_copyPropertyList(cls, &count);
    for (unsigned int i = 0; i < count; i ++) {
        objc_property_t property = propertys[i];
        printf("propertyName:%s,propertyAttributes:%s\n\n",property_getName(property),property_getAttributes(property));
    }
}

void printPersonProtocolList(Class cls)
{
    unsigned int count = 0;
    Protocol * __unsafe_unretained *  protocols= class_copyProtocolList(cls, &count);
    for (unsigned int i = 0; i < count; i ++) {
        Protocol * protocol = protocols[i];
        printf("protocolName:%s,",protocol_getName(protocol));
        unsigned int PropertyListcount = 0;
        objc_property_t * propertys = protocol_copyPropertyList(protocol, &PropertyListcount);
        for (unsigned int j = 0; j < PropertyListcount; j ++) {
            objc_property_t property = propertys[j];
            printf("propertyName:%s,propertyAttributes:%s\n\n",property_getName(property),property_getAttributes(property));
        }
    }
}

Ivar ivarOfClass(Class cls,const char * ivarname)
{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([Person class], &count);
    for (unsigned int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        if (strcmp(name,ivarname) == 0) {
            return ivar;
        }
    }
    return nil;
}

void changeIvarOfinstance(const char * ivarName,id value,Person * person)
{
    Ivar ivar = ivarOfClass([Person class], ivarName);
    
    object_setIvar(person, ivar, value);
}

void changeNumberIvarOfinstance(const char * ivarName,int value,Person * person)
{
    Ivar ivar = ivarOfClass([person class], ivarName);
    CFTypeRef myFooRef = CFBridgingRetain(person);
    int *ivarPtr = (int *)((uint8_t *)myFooRef + ivar_getOffset(ivar));
    *ivarPtr = value;
    CFBridgingRelease(myFooRef);
}

void changeFloatIvarOfinstance(const char * ivarName,float value,Person * person)
{
    Ivar ivar = ivarOfClass([person class], ivarName);
    CFTypeRef myFooRef = CFBridgingRetain(person);
    float *ivarPtr = (float *)((uint8_t *)myFooRef + ivar_getOffset(ivar));
    *ivarPtr = value;
    CFBridgingRelease(myFooRef);
}


void personInstanceTest()
{
    
    
    messageFowardingDynamicMethod *person = [[messageFowardingDynamicMethod alloc] init];

    [person performSelector:@selector(integerValue)];
    
    [messageFowardingDynamicMethod performSelector:@selector(integerValue)];
    
}

void logtest()
{
    extern void instrumentObjcMessageSends(BOOL);
    instrumentObjcMessageSends(YES);
    Dog * dog = [[Dog alloc]init];
    instrumentObjcMessageSends(NO);
    Person * person = [[Person alloc]init];
    dog.name = @"";
    person.name = @"";
}

void blocktest()
{
    __block NSMutableArray *array = [NSMutableArray arrayWithObjects:@1,@2,nil];
    NSLog(@"Array Count:%ld", array.count);//打印Array Count:2
    void (^blk)(void) = ^{
        [array removeObjectAtIndex:0];//Ok
        //            array = [NSMutableArray new];//没有__block修饰，编译失败！
    };
    blk();
    NSLog(@"Array Count:%ld", array.count);//打印Array Count:1
}


void synthesizedynamicTest()
{
    Dog *dog1 = [[Dog alloc]init];
    dog1.name = @"333";
    NSLog(@"dogName:%@",dog1.name);
    
    printPersonIvars([Dog class]);
    printPersonPropertys([Dog class]);
    
}

void blockTest()
{
    Block1 * block = [[Block1 alloc]init];
}

void blockTest1()
{
    NSInteger count = 10;
    NSInteger(^sum)(void)=^{
        return count;
    };
    count = 20;
    NSLog(@"\\n %ld",sum()); //结果：10
    
    __block NSInteger block_count = 10;
    NSInteger(^block_sum)(void)=^{
        return block_count;
    };
    block_count = 20;
    NSLog(@"\\n %ld",block_sum()); //结果：20
    
    NSMutableString *mutable_string = [NSMutableString stringWithString:@"aaa"];
    void(^mutable_append)(void)=^{
        [mutable_string appendString:@"ccc"];
    };
    [mutable_string appendString:@"bbb"];
    mutable_append();
    NSLog(@"\\n %@",mutable_string);  //结果：aaabbbccc
    
    NSString *string = @"aaa";
    NSString*(^append)(void)=^{
        return [string stringByAppendingString:@"ccc"];
    };
    string = @"bbb";
    NSLog(@"\\n %@",append());  //结果：aaaccc
    
    __block NSString *block_string = @"aaa";
    NSString*(^block_append)(void)=^{
        return [block_string stringByAppendingString:@"ccc"];
    };
    block_string = @"bbb";
    NSLog(@"\\n %@",block_append()); //结果: bbbccc
}

void userdefaulttest()
{
    userdefaultTest * test = [[userdefaultTest alloc]init];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
 
//        printPersonIvars();
//        printPersonMethods();
//        printPersonPropertys();
//        printPersonProtocolList();
//        personInstanceTest();
//        logtest();
        synthesizedynamicTest();
//        blockTest();
//        userdefaulttest();
    }
    return 0;
}
