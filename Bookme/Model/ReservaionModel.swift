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
    dynamic var device = ""
    dynamic var os = ""
    dynamic var manufacturer = ""
    dynamic var createdOn = Date()
    dynamic var id = 0
    dynamic var isCheckedOut = false
    //isRemoteDevice means that this device is comming from the backend and is static data
    dynamic var isRemoteDevice = false
    //isSync means that this device was susccessful sent to the backend and it does not need to Sync
    dynamic var isSync = false
    
    
    //Optional values
    dynamic var lastCheckedOutBy: String? = nil
    dynamic var lastCheckedOutDate: Date? = nil
    
    override static func indexedProperties() -> [String] {
        return ["device"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //Todo adding device model mapping object
    
}

