//
//  ReservaionModel.swift
//  Bookme
//
//  Created by Janet Rivas on 6/11/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import RealmSwift


// Reservation model
class ReservationModel: Object {
    
    //Date no optional
    dynamic var name = ""
    dynamic var email = ""
    dynamic var specialRequest = ""
    dynamic var phoneNumber : Int = 0
    dynamic var reservationDate = Date()
    dynamic var isFull = false
    dynamic var isExpired = false
    dynamic var isCancelled = false
    // just by default
    dynamic var guessNumber = 1
    
    override static func indexedProperties() -> [String] {
        return ["email", "name" ]
    }
    
    /*override static func primaryKey() -> String? {
        return "phoneNumber"
    }*/
    
    //TODO adding device model mapping object
    
}

