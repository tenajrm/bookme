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
    
    static func getAllDBObjects() -> [ReservationModel]? {
        
        var allReservations = [ReservationModel]()
        
         do {
            let realm = try! Realm()
            let objects = realm.objects(ReservationModel.self)
             allReservations = objects.toArray(ofType : ReservationModel.self) as [ReservationModel]
         }
        
        return allReservations.count > 0 ? allReservations : nil
        
    }
    
    static func updateObject(updateObjet: ReservationModel, isCancelled : Bool) {
        
        // Get the default Realm
        let realm = try! Realm()
        
        try? realm.write {
            updateObjet.isCancelled = isCancelled
            realm.add(updateObjet, update: true)
        }
        
    }
    
    static func removeObject(phoneCell : ReservationModel) {
        
        // Get the default Realm
        let realm = try! Realm()
        let predicate = "phoneNumber = \(phoneCell.phoneNumber)"
        // Query Realm for Device
        let reservation = realm.objects(ReservationModel.self).filter(predicate)
        print("reservation query : \(reservation)")
        
        try? realm.write {
            realm.delete(reservation)
        }
        
    }
    
    
}


