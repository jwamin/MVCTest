//
//  TestModal.swift
//  MVCTest
//
//  Created by Joss Manger on 5/30/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class TestModal: NSObject {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var moc:NSManagedObjectContext
    var taps:Int!
    
    override init() {
        
        let persistentContainer = delegate.persistentContainer
        
        moc = persistentContainer.newBackgroundContext()
        let clicksFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Clicks")
        
        do {
            let fetchedclicks = try moc.fetch(clicksFetch) as! [Clicks]
            if let sometaps = fetchedclicks.last?.number {
              taps = Int(sometaps)
            } else {
                taps = 0
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        
        //set value of taps to 0 or the contents of CoreData index var
        
    }
    
    func incrementTaps(){
        taps = taps + 1;
        
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "incrementOccurred"), object: nil)
    }
    
    func commitToCore(){
        
        let clickobject = NSEntityDescription.insertNewObject(forEntityName: "Clicks", into: moc) as! Clicks
        clickobject.number = Int64(taps)
        print(clickobject)
        do {
            try moc.save()
        } catch {
            fatalError()
        }
    }
    
}
