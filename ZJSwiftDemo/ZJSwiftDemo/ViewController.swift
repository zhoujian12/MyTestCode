//
//  ViewController.swift
//  ZJSwiftDemo
//
//  Created by ZhouJian09 on 2021/10/25Monday.
//

import UIKit

enum HistoryType {
    case empty
    case university
    case k12
}

class ViewController: UIViewController {
    var arr: [HistoryType] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//       _ = testAsyncToSync()
//        testArrayOutOFindex()
        testThreadSafe()
    }
    
    func testArrayOutOFindex() {
        self.arr.append(.k12)
        self.arr.insert(.university, at: 0)
        self.arr.removeFirst()
        self.arr.removeFirst()
        print("count: \(self.arr.count)")
        self.arr.removeFirst()
        self.arr.remove(at: 1)
        let s = self.arr[1]
    }

    func testAsyncToSync() -> Bool  {
//        let semaphore = DispatchSemaphore(value: 0)
        var canOpen = false
        var url = URL.init(string: "www.baidu.com")
        url = URL.init(string: UIApplication.openSettingsURLString)
        print("init")
//        let suc = UIApplication.shared.open(url!, options: [:])
//        print("suc :\(suc)")
        if let url: URL = url{
//            DispatchQueue.main.async {
//                sleep(3)
                var canOpen = false
//                semaphore.signal()
                print("canOpen :\(canOpen)")
                UIApplication.shared.open(url, options: [:]) { success in
                    canOpen = success
                    print("success :\(success)")
//                    semaphore.signal()
                }
//            }
                
        }else{
            return true
        }
        print("will wait")
//        semaphore.wait()
        print("end wait")
        print("return canOpen: \(canOpen)")
        return canOpen
    }

    func testThreadSafe() {
        let tools = ThreadSafeTools()
        
        
        
        (1...10).forEach{i in
            DispatchQueue.global().async {
                print("safeAsyncRead -- i:\(i) title:\(tools.safeAsyncRead())")
            }
        }
        (1...10).forEach{i in
//            sleep(1)
            DispatchQueue.global().async {
//                sleep(1)
                print("safeSyncRead -- i:\(i) title:\(tools.safeSyncRead())")
            }
        }
        
        (1...10).forEach{i in
//            sleep(0.1)
            DispatchQueue.global().async {
                print("safeAsyncWrite -- 1 i:\(i) title:\(tools.title)")
                print("safeAsyncWriteBefore -- 1 i:\(i) title:\(tools.safeSyncRead())")
                tools.safeAsyncWrite("change")
                print("safeAsyncWriteAfter -- 2 i:\(i) title:\(tools.title)")

                print("safeAsyncWriteAfter -- 3 i:\(i) title:\(tools.safeSyncRead())")
            }
        }
       
    }

}

