//: [Previous](@previous)

import Foundation
import Darwin

var greeting = "Hello, playground"

//: [Next](@next)

//串行队列
let serial = DispatchQueue(label: "serial11",attributes: .init(rawValue:0))
//并发队列
let concurrent = DispatchQueue(label: "concurrent11",attributes: .concurrent)
//主队列
let mainQueue = DispatchQueue.main
//全局队列
let global = DispatchQueue.global()

print(serial.label)
concurrent.label



//error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
//print(1)
//DispatchQueue.main.sync {
//    print(2)
//}
//print(3)

//主队列+异步任务——依次执行（不开启新线程）
//下代码中的print(2)任务会添加到主队列的最后。又由于主线程+异步任务不会开启新线程，以下代码输出1 3 2，顺序固定不变。
print(1)

DispatchQueue.main.async {
    print(2)
}
//sleep(2)
print(3)

//串行队列+同步任务——依次执行
//串行队列
//以下代码不管每个任务休眠时间多长，输出顺序始终为0...10
for i in 0...10 {
    serial.sync {
        sleep(arc4random()%3)//休眠时间随机
        print("serial - sync \(i)")
    }
}


//串行队列+异步任务——开启一个新线程依次执行
//以下代码输出顺序始终为0...10，并且for循环中的Thread.current的输出始终为同一个新线程
print(Thread.current)//主线程
for i in 0...10 {
    serial.async {
        sleep(arc4random()%3)//休眠时间随机
        print("serial - async \(i), \(Thread.current)")//子线程
    }
}

//并发队列+同步任务——依次执行
//以下代码输出顺序始终为0...10,且线程始终为主线程
for i in 0...10 {
    DispatchQueue.global().sync {
        sleep(arc4random()%3)//休眠时间随机
        print("global - sync \(i), \(Thread.current)")//子线程
    }
}

//并发队列+异步任务——开启多个线程并发执行
//以下代码输出顺序随机，且线程信息不同。注意：这里可能不会输出11个不同的线程信息，经过代码测试发现当一个线程的任务执行完成后，如果队列中还有任务，此线程会继续被调度执行后续任务。 将任务数增多，结果更明显。
for i in 0...10 {
    DispatchQueue.global().async {
        sleep(arc4random()%3)//休眠时间随机
        print("global - async \(i), \(Thread.current)")//子线程
    }
}

//并发队列——最大并发数

//GCD并不能无限制的创建线程，如下代码其实最多创建64个子线程，意味着最大并发数为64
//for i in 0...1000 {
//     DispatchQueue.global().async {
//         print("test maxGcdThreads:  \(i), \(Thread.current)")//子线程
//         sleep(10000)
//     }
// }


//GCD 栅栏
//。如果将添加栅栏修改为sync则会阻塞当前线程?
//DispatchQueue.global().sync(flags: .barrier) {
//    print("this is barrier \(Thread.current)")
//}
//print("after barrier \(Thread.current)")

for i in 0...10 {
    DispatchQueue.global().async {
        print("before barrier \(i) \(Thread.current)")
    }
}
DispatchQueue.global().async(flags: .barrier) {
    print("this is barrier")
}
for i in 11...20 {
    DispatchQueue.global().async {
        print("after barrier \(i) \(Thread.current)")

    }
}
