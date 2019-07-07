//
//  ViewController.swift
//  IOSSensorPedometer
//
//  Created by Fauzi Fauzi on 07/07/19.
//  Copyright © 2019 Fauzi. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CMPedometer.isStepCountingAvailable() {
            let calendar = Calendar.current
            pedometer.queryPedometerData(from: calendar.startOfDay(for: Date()), to: Date()) { (data, error) in
                print(data!)
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        if CMPedometer.isStepCountingAvailable() && CMPedometer.isDistanceAvailable()
{
            pedometer.startUpdates(from: Date()) { (data, error) in
                print(data!.distance!.stringValue)

                //            pedometer.queryPedometerData(from: Date(), to: Date()) { (data, error) in
                //                print(data!)
                DispatchQueue.main.async {
                    self.stepCountLabel.text = String.init(format: "Step Counter: \(data!.numberOfSteps.stringValue)")
                    self.distanceLabel.text = String.init(format: "Distance: %.2f M", (data?.distance!.floatValue)!)

                }
            }
        }
    }

    @IBAction func stopAction(_ sender: UIButton) {
        pedometer.stopUpdates()
        
    }

}

