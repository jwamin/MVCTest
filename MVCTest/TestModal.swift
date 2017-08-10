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
    var moc:NSManagedObjectContext!
    var taps:Int!
    var date:NSDate!
    var cdObject:Clicks!
    
    override init() {
        super.init()
        
        let persistentContainer = delegate.persistentContainer
        
        moc = persistentContainer.newBackgroundContext()
        
        initEntity()
        
    }
    
    func incrementTaps(){
        taps! += 1;
        date = NSDate()
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "incrementOccurred"), object: nil)
    }
    
    func commitToCore(){
        var obj:Clicks!
        
        if let objtest = cdObject{
            obj = objtest
        } else {
            obj = NSEntityDescription.insertNewObject(forEntityName: "Clicks", into: moc) as! Clicks
        }
        
        obj.number = Int64(taps);
        obj.date = date
        
        do {
            try moc.save()
            cdObject = obj
        } catch {
            fatalError()
        }
        
    }
    
    func initEntity(){
        print("initialising entity")
        let clicksFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Clicks")
        
        do {
            
            let fetchedclicks = try moc.fetch(clicksFetch) as! [Clicks]
            
            print("number of managed objects in context: \(fetchedclicks.count)")
            
            for thisClick in fetchedclicks{
                
                print(thisClick.number)
                
            }
            
            if let object = fetchedclicks.last {
                
                cdObject = object
                taps = Int(cdObject.number)
                date = cdObject.date
            } else {
                
                taps = 0
                date = NSDate()
            }
            
            NotificationCenter.default.post(name:NSNotification.Name(rawValue: "incrementOccurred"), object: nil)
            
        } catch {
            
            fatalError("Failed to fetch Clicks: \(error)")
            
        }

    }
    
    func clearCore(){
        guard (cdObject) != nil else{
            print("no cdobject")
            return
        }
        
            do {
                moc.delete(cdObject)
                try moc.save()
                cdObject = nil
                initEntity()
            } catch {
            fatalError("Failed to fetch clicks: \(error)")
        }
    }
    
}
