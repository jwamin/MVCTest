//
//  TestModal.swift
//  MVCTest
//
//  Created by Joss Manger on 5/30/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import UIKit

class TestModal: NSObject {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var taps:Int!
    
    override init() {
        taps=0
        //set value of taps to 0 or the contents of CoreData index var
        
    }
    
    func incrementTaps(){
        taps = taps + 1;
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "incrementOccurred"), object: nil)
    }
    
}
