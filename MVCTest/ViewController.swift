//
//  ViewController.swift
//  MVCTest
//
//  Created by Joss Manger on 5/30/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myModel:TestModal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myModel = TestModal();
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name.init(rawValue: "incrementOccurred"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        myModel.incrementTaps()
    }
    
    @IBAction func updateUI(){
        print(myModel.taps)
    }
    
}

