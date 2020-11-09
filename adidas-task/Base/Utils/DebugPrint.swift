//
//  DebugPrint.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//  Easier to debug the app with a wrapper like this.
//

import Foundation

public func debugPrint(_ item: Any) {
    #if DEBUG
    print("[\(Date())] \(item)")
    #endif
}

public func debugError(_ item: Any) {
    let newItems = "[❌] -> \(item)"
    debugPrint(newItems)
}

public func debugInfo(_ item: Any) {
    let newItems = "[ℹ️] -> \(item)"
    debugPrint(newItems)
}

public func debugSuccess(_ item: Any) {
    let newItems = "[✅] -> \(item)"
    debugPrint(newItems)
}
