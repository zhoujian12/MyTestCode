import UIKit

var str = "Hello, playground"

//struct LRUCache<K:AnyObject, V:AnyObject> {
//
//    private let _cache = NSCache<AnyObject, AnyObject>()
//
//    var countLimit:Int {
//        get {
//            return _cache.countLimit
//        }
//        nonmutating set(countLimit) {
//            _cache.countLimit = countLimit
//        }
//    }
//    subscript(key:K!) -> V? {
//        get {
//            let obj:AnyObject? = _cache.object(forKey: key ?? "" as AnyObject)
//            return obj as! V?
//        }
//        nonmutating set(obj) {
//            if(obj == nil) {
//                _cache.removeObject(forKey: key ?? "" as AnyObject)
//            }
//            else {
//                _cache.setObject(obj!, forKey: key as AnyObject)
//            }
//        }
//    }
//}
//
//let cache = LRUCache<NSString, NSString>()
//cache.countLimit = 3
//cache["key1"] = "val1"
//cache["key2"] = "val2"
//cache["key3"] = "val3"
//cache["key4"] = "val4"
//cache["key5"] = "val5"
//let val3 = cache["key3"]
//cache["key6"] = "val6"
//
//print((
//    cache["key1"],
//    cache["key2"],
//    cache["key3"],
//    cache["key4"],
//    cache["key5"],
//    cache["key6"]
//))

class LURCacheObj {
    class CacheNode {
        var prev: CacheNode?
        var next: CacheNode?
        var data: Any?
        var key     = ""
        deinit{
            print("\(self.key) is die")
        }
    }
    private var cacheSize                           = 0
    var nodes :[String: CacheNode]     = [:]
    var currentSize                         = 0
    var firstNode: CacheNode?
    var lastNode: CacheNode?
    
    init(cacheSize :Int){
        self.cacheSize = cacheSize
    }
    func get(key : String) -> Any? {
        let tmpNode = nodes[key]
        move2Head(node: tmpNode)
        return tmpNode?.data
    }
    func put(key: String , anyO: Any){
        var tmpNode = nodes[key]
        if nil == tmpNode {
            if currentSize >= cacheSize {
                removeLast()
            }
            currentSize += 1
            tmpNode = CacheNode()
        }
        tmpNode!.key = key
        tmpNode!.data = anyO
        move2Head(node: tmpNode!)
        nodes[key] = tmpNode
    }
    func remove(key : String) -> CacheNode?{
        let tmpNode = nodes[key]
        if let node = tmpNode {
            if node.prev != nil {
                node.prev?.next = node.next
            }
            if node.next != nil {
                node.next?.prev = node.prev
            }
            if lastNode === tmpNode{
                lastNode = tmpNode?.prev
            }
            
            if firstNode === tmpNode {
                firstNode = tmpNode?.next
            }
            nodes[key] = nil
            currentSize -= 1
        }
        return tmpNode
    }
    //清空缓存
    func clear(){
        firstNode = nil
        lastNode = nil
        nodes.removeAll()
    }
    private func removeLast(){
        if let lastn = lastNode {
            nodes[lastn.key] = nil//从缓存中删除
            currentSize -= 1
            if let lastPre = lastn.prev {
                lastPre.next = nil
            }else{
                firstNode = nil
            }
            lastNode = lastNode?.prev
        }
    }
    
    
    private func move2Head(node: CacheNode?){
        if let n = node {
            if node === firstNode{
                return
            }
            
            if n.prev != nil {
                n.prev?.next = n.next
            }
            
            if n.next != nil{
                n.next?.prev = n.prev
            }
            
            if lastNode === node{
                lastNode  = n.prev
            }
            
            if firstNode != nil {
                n.next = firstNode
                firstNode?.prev = n
            }
            
            firstNode = node
            
            n.prev = nil
            
            if lastNode == nil{
                lastNode  = firstNode
            }
            
        }
    }
    
}

let cacheObj = LURCacheObj.init(cacheSize: 3)
let model1 = LURCacheObj.CacheNode.init()
model1.data = "model1"
model1.key  = "model1"
let model2 = LURCacheObj.CacheNode.init()
model2.data = "model2"
model2.key  = "model2"
let model3 = LURCacheObj.CacheNode.init()
model3.data = "model3"
model3.key  = "model3"
let model4 = LURCacheObj.CacheNode.init()
model4.data = "model4"
model4.key  = "model4"
let model5 = LURCacheObj.CacheNode.init()
model5.data = "model5"
model5.key  = "model5"

func printCacheObj(obj : LURCacheObj){
    print("\n cacheObj firstNode key :\(String(describing: cacheObj.firstNode?.key))")
    print("lastNode :\(String(describing: cacheObj.lastNode?.key))")
    print("nodes:\(cacheObj.nodes.keys)")
    print("currentSize:\(cacheObj.currentSize)")
    print("cacheObj firstNode pre key :\(String(describing: cacheObj.firstNode?.prev?.key))")
    print("cacheObj firstNode next key :\(String(describing: cacheObj.firstNode?.next?.key))")
    print("cacheObj lastNode prev key :\(String(describing: cacheObj.lastNode?.prev?.key))")
    print("cacheObj lastNode next key :\(String(describing: cacheObj.lastNode?.next?.key)) \n\n")
}

cacheObj.put(key: model1.key, anyO: model1.data as Any)
printCacheObj(obj: cacheObj)

cacheObj.put(key: model2.key, anyO: model2.data as Any)
printCacheObj(obj: cacheObj)

cacheObj.put(key: model3.key, anyO: model3.data as Any)
printCacheObj(obj: cacheObj)

cacheObj.get(key: model1.key)
printCacheObj(obj: cacheObj)

cacheObj.put(key: model4.key, anyO: model4.data as Any)
printCacheObj(obj: cacheObj)

cacheObj.put(key: model5.key, anyO: model5.data as Any)
printCacheObj(obj: cacheObj)
