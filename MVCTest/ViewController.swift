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
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        myModel = TestModal();
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name.init(rawValue: "incrementOccurred"), object: nil)
        
        self.updateUI()
        
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
        label.text = String(myModel.taps)
    }
    
    func cdSave(){
        print("got gesture")
        myModel.commitToCore()
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        
        switch(sender.state){
        case .began:
            print("long press began")
            break
        case .ended:
            print("long press ended")
            myModel.commitToCore()
            break
        default: break
            
        }
        
    }
    @IBAction func reset(_ sender: Any) {
        myModel.clearCore()
    }
}

