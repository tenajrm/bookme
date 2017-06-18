//
//  TimestampHelper.swift
//  Bookme
//
//  Created by Janet Rivas on 6/11/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import Foundation
import UIKit


class TimestampHelper
{
    static func getCurrentTimestamp(timestamp : Date, isSystemformat : Bool) -> String {
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.ReferenceType.system
        if isSystemformat {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        } else {
            formatter.dateFormat = "EEEE dd MMMM yyyy"
        }
        
        let st = formatter.string(from: timestamp)
        return st
        
    }
    
    static func  stringToDate(timestamp : String) -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.ReferenceType.system
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.date(from:timestamp)!
        
    }

    
    
    
    
}
