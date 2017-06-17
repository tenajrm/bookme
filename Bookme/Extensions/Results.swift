//
//  RealmCastArray.swift
//  Bookme
//
//  Created by Janet Rivas on 6/16/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//


import UIKit
import RealmSwift
//Results Realm casting from Array 

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
