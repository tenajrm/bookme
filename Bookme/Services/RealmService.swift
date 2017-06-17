//
//  RealmService.swift
//  Bookme
//
//  Created by Janet Rivas-Mendoza (Contractor) on 6/16/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class RealmService
{
    static func writeObjects(obj reservation : ReservationModel){
        do {
            let realm = try Realm()
            try? realm.write {
                realm.add(reservation)
            }
        } catch let error as NSError {
            print("Realm : \(error)")
        }
    }
}


