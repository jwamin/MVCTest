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
    var cdObject:Clicks!
    
    override init() {
        super.init()
        
        let persistentContainer = delegate.persistentContainer
        
        moc = persistentContainer.newBackgroundContext()
        
        initEntity()

        
    }
    
    func incrementTaps(){
        taps! += 1;
        
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
        
        do {
            try moc.save()
        } catch {
            fatalError()
        }
        
    }
    
    func initEntity(){
        
        let clicksFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Clicks")
        
        do {
            
            let fetchedclicks = try moc.fetch(clicksFetch) as! [Clicks]
            
            for thisClick in fetchedclicks{
                
                print(thisClick.number)
                
            }
            
            if let object = fetchedclicks.last {
                
                cdObject = object
                taps = Int(cdObject.number)
                
            } else {
                
                taps = 0
                
            }
            
            NotificationCenter.default.post(name:NSNotification.Name(rawValue: "incrementOccurred"), object: nil)
            
        } catch {
            
            fatalError("Failed to fetch Clicks: \(error)")
            
        }

    }
    
    func clearCore(){

            moc.delete(cdObject)
            cdObject = nil
            do {
                try moc.save()
                initEntity()
            } catch {
            fatalError("Failed to fetch clicks: \(error)")
        }
    }
    
}
