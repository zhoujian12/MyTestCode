# 说明文档

[toc]

# iOS 中__block 关键词的底层实现原理 https://www.jianshu.com/p/404ff9d3cd42

block 不允许修改外部变量的值，因为Block 复制的是栈中指针的内存地址；__block 所起到的作用就是只要观察到该变量被 block 所持有，就将“外部变量”在栈中的内存地址放到了堆中。进而在block内部也可以修改外部变量的值。

a 在定义前是栈区，但只要进入了 block 区域，就变成了堆区。这才是 __block 关键字的真正作用。

Block不允许修改外部变量的值，这里所说的外部变量的值，指的是栈中指针的内存地址。

## 为什么要设计block 不可以修改外部的变量?
Apple这样设计，应该是考虑到了block的特殊性，block也属于“函数”的范畴，变量进入block，实际就是已经改变了作用域。在几个作用域之间进行切换时，如果不加上这样的限制，变量的可维护性将大大降低。又比如我想在block内声明了一个与外部同名的变量，此时是允许呢还是不允许呢？只有加上了这样的限制，这样的情景才能实现。于是栈区变成了红灯区，堆区变成了绿灯区。


## 为什么栈区的结构 不可以修改数据?

 Block默认的是NSGlobalBlock类似于函数，存放在代码段;当block内部使用了外部的变量时，block的存放位置变成了NSMallockBlock（堆）,所以用__block修饰后才可以在block内部直接修改该变量。

## block的内部结构，它是如何捕获外部数据的？

# https://baike.baidu.com/item/%E6%8C%87%E9%92%88/2878304 指针

> 在计算机科学中，指针（Pointer）是编程语言中的一个对象，利用地址，它的值直接指向（points to）存在电脑存储器中另一个地方的值。
> 
> 作个比喻，假设将电脑存储器当成一本书，一张内容记录了某个页码加上行号的便利贴，可以被当成是一个指向特定页面的指针；根据便利粘贴面的页码与行号，翻到那个页面，把那个页面的那一行文字读出来，就相当于是对这个指针进行反参考的动作。
> 
> 
> 在信息工程中指针是一个用来指示一个内存地址的计算机语言的变量或中央处理器(CPU)中寄存器(Register)【用来指向该内存地址所对应的变量或数组】。指针一般出现在比较接近机器语言的语言，如汇编语言或C语言。面向对象的语言如Java一般避免用指针。指针一般指向一个函数或一个变量。在使用一个指针时，一个程序既可以直接使用这个指针所储存的内存地址，又可以使用这个地址里储存的函数的值。

# https://juejin.im/post/5d3171d7f265da1bd26126a0 深入理解iOS的block

1. block的原理是怎样的？本质是什么？
1. __block的作用是什么？有什么使用注意点？
1. block的属性修饰词为什么是copy？使用block有哪些使用注意？
1. block一旦没有进行copy操作，就不会在堆上
1. block在修改NSMutableArray，需不需要添加__block？
2. 为什么

## 什么是block

block是一个闭包函数（或指向函数的指针 ？），再加上该函数执行的外部的上下文变量(有时候也称作自由变量）。



```
  变量类型        捕获到block内部    访问方式
  局部变量 auto      √             值传递
  局部变量 static    √             指针传递
  全局变量           ×             直接访问
```

_NSGlobalBlock__ : __NSGlobalBlock : NSBlock : NSObject


```
block类型             环境              内存区域
__NSGlobalBlock__    没有访问auto变量  数据区域.data区
__NSStackBlock__    访问了auto变量    栈区
__NSMallocBlock__  __NSStackBlock__调用了copy 堆区
```

- block本质上也是一个OC对象，它内部也有个isa指针
- block是封装了函数调用以及函数调用环境的OC对象
- block的底层结构如下
- 

## block的copy
前面说了在ARC环境下，编译器会根据情况自动将栈上的block复制到堆上，具体来说比如以下情况

### copy的情况
- block作为函数返回值时
- 将block赋值给__strong指针时
- block作为Cocoa API中方法名含有usingBlock的方法参数时
- block作为GCD API的方法参数时


### MRC下block属性的建议写法

@property (copy, nonatomic) void (^block)(void);

### ARC下block属性的建议写法

@property (strong, nonatomic) void (^block)(void);
@property (copy, nonatomic) void (^block)(void);

## clang转换OC为C++代码编译命令行
终端执行这行指令xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m把main.m生成main.cpp 

支持ARC、指定运行时系统版本，比如 xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-8.0.0 main.m

## 对象类型的auto变量
当 block为__NSMallocBlock__类型时候，block是可以保住对象的生命

## __weak修饰


```
//copy 函数
  void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
  
  //dispose函数
  void (*dispose)(struct __main_block_impl_0*);
```


```
struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  //weak修饰
  YZPerson *__weak weakPerson;
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, YZPerson *__weak _weakPerson, int flags=0) : weakPerson(_weakPerson) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};


static struct __main_block_desc_0 {
  size_t reserved;
  size_t Block_size;
  //copy 函数
  void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
  
  //dispose函数
  void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = {
 0, 
 sizeof(struct __main_block_impl_0),
  __main_block_copy_0,
   __main_block_dispose_0
};


//copy函数内部会调用_Block_object_assign函数
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {

//asssgin会对对象进行强引用或者弱引用
_Block_object_assign((void*)&dst->person, 
(void*)src->person, 
3/*BLOCK_FIELD_IS_OBJECT*/);
}

//dispose函数内部会调用_Block_object_dispose函数
static void __main_block_dispose_0(struct __main_block_impl_0*src) {
_Block_object_dispose((void*)src->person, 
3/*BLOCK_FIELD_IS_OBJECT*/);
}
。
```

无论是MAC还是ARC

- 当block为__NSStackBlock__类型时候，是在栈空间，无论对外面使用的是strong 还是weak 都不会对外面的对象进行强引用
- 当block为__NSMallocBlock__类型时候，是在堆空间，block是内部的_Block_object_assign函数会根据strong或者 weak对外界的对象进行强引用或者弱引用。

> 如果block被拷贝到堆上
> 
> 会调用block内部的copy函数
> copy函数内部会调用_Block_object_assign函数
> _Block_object_assign函数会根据auto变量的修饰符（__strong、__weak、__unsafe_unretained）做出相应的操作，形成强引用（retain）或者弱引用

> 如果block从堆上移除
> 
> 会调用block内部的dispose函数
> dispose函数内部会调用_Block_object_dispose函数
> _Block_object_dispose函数会自动释放引用的auto变量（release）




## __block分析


```
// 结构体 __Block_byref_age_0
struct __Block_byref_age_0 {
    void *__isa; //isa指针
    __Block_byref_age_0 *__forwarding; // 指向自身的指针
    int __flags;
    int __size;
    int age; //使用值
};
```

用的时候，先通过__forwarding找到指针，然后去取出age值。

(age->__forwarding->age));

小结


- __block可以用于解决block内部无法修改auto变量值的问题

- __block不能修饰全局变量、静态变量（static）

- 编译器会将__block变量包装成一个对象

调用的是，从__Block_byref_age_0的指针找到 age所在的内存，然后修改值

-为啥什么不直接用age,而是age->__forwarding->age呢？

这是因为，如果__block变量在栈上，就可以直接访问，但是如果已经拷贝到了堆上，访问的时候，还去访问栈上的，就会出问题，所以，先根据__forwarding找到堆上的地址，然后再取值

# 内存管理问题

### 拷贝
block 从栈上拷贝到堆上时，会同时把__block 变量拷贝到堆上，后续用到此__block 变量的block也拷贝到堆上时强持有此变量即可

## 循环引用

虽然__unsafe_unretained可以解决循环引用，但是最好不要用，因为

__weak：不会产生强引用，指向的对象销毁时，会自动让指针置为nil
__unsafe_unretained：不会产生强引用，不安全，指向的对象销毁时，指针存储的地址值不变


### __block解决循环引用

- block 内部对象置为nil 
- 调用block

### MRC下注意点
如果再MRC下，因为不支持弱指针__weak，所以，只能是__unsafe_unretained或者__block来解决循环引用

# block 内部修改集合类的值
https://juejin.im/post/5a62a16e518825733e608a4d

- __block 修饰的非集合、集合对象都可以赋值
- 没有__block修饰的集合可以修改其中的对象
- 当前类属性没有__block修饰的时候也可以赋值



```
有没有 __block 的区别就是

拷贝值
拷贝指针

NSMutableArray *array = __cself->array1; // bound by copy

__Block_byref_array1_1 *array1 = __cself->array1;  // bound by ref
复制代码只有拷贝指针的才能执行赋值
```
。

## 为什么当前类属性我们可以赋值呢？

因为self.调用了属性的set方法，使用runtime实现消息发送，不过可能会存在内存泄露

## 为什么没有__block的可变集合类我们可以修改其中的对象呢？

我们可以看到 [array1 addObject:@1];编译之后的是


```
((void (*)(id, SEL, ObjectType))(void *)objc_msgSend)((id)array1, sel_registerName("addObject:"), (id)((NSNumber *(*)(Class, SEL, int))(void *)objc_msgSend)(objc_getClass("NSNumber"), sel_registerName("numberWithInt:"), 1));
```

调用的set方法，此处也是消息发送。

