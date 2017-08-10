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
    
    var timer:Timer?
    
    @IBOutlet weak var timerLabel: UILabel!
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
        //notify model
        myModel.incrementTaps()
    }
    
    @IBAction func updateUI(){
        //notified by model to update UI
        print(myModel.taps, myModel.date)
        label.layer.opacity = 0.0
        label.layer.transform = CATransform3DMakeScale(8, 8, 8)
        label.text = String(myModel.taps)
        UIView.animate(withDuration: 0.25, animations: {
            self.label.layer.opacity = 1.0
            self.label.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }, completion: {
            complete in
            self.myModel.commitToCore()
            self.updateTimer()
        })

    }
    
    func cdSave(){
        print("got gesture")
        myModel.commitToCore()
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> NSString {
        
        let ti = NSInteger(interval)
        
        let ms = Int((interval.truncatingRemainder(dividingBy: 1) * 1000))
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
    }
    
    func updateTimer(){
        
        if let mytimer = timer {
            print("timer not nil")
            mytimer.invalidate()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.0, repeats: true, block: {
            timer in
            let timesince = Date().timeIntervalSince(self.myModel.date as Date)
            
            self.timerLabel.text = String(self.stringFromTimeInterval(interval: timesince))
        })
        
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        
        switch(sender.state){
        case .began:
            print("long press began")
            self.view.layer.backgroundColor = UIColor.green.cgColor
            break
        case .ended:
            print("long press ended")
            
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layer.backgroundColor = UIColor.white.cgColor
            }, completion: {
            complete in
               self.myModel.commitToCore()
            })
            
            break
        default: break
            
        }
        
    }
    @IBAction func reset(_ sender: Any) {
        myModel.clearCore()
    }
}

