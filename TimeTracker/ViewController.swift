//
//  ViewController.swift
//  TimeTracker
//
//  Created by Daniel Tombor on 2018. 08. 04..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit
import Tracker

class BalancedTracker: BalanceTracker {

    typealias Source = Double
    typealias BalanceType = DefaultBalance<Double>

    var items: [Double] = []
    var sources: [Double] = []
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let tracker = BalancedTracker()
        tracker.balance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

