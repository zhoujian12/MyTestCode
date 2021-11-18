//
//  ThreadSafeTools.swift
//  ZJSwiftDemo
//
//  Created by ZhouJian09 on 2021/11/10Wednesday.
//

import Foundation

class ThreadSafeTools{
    var title = "init"
    
    let queue = DispatchQueue(label: "zj_rw_queue",attributes: .concurrent)
    
//    let queue = DispatchQueue(label: "zj_rw_queue",attributes: .init(rawValue: 0))

    
    func safeAsyncRead() -> String {
        var re = ""
        queue.async {
            re = self.title
        }
        return re
    }
    
    func safeSyncRead() -> String {
        var re = ""
        queue.sync {
            re = self.title
        }
        return re
    }
    
    func safeAsyncWrite(_ t: String)  {
        queue.async(flags: .barrier) { [weak self] in
            self?.title = t
        }
    }
}
