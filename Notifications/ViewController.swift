//
//  ViewController.swift
//  Notifications
//
//  Created by user on 9/28/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let generator = NotificationGenerator()
        generator.displayNotification()
    }


}

