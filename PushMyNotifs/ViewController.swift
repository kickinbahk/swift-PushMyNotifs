//
//  ViewController.swift
//  PushMyNotifs
//
//  Created by Josiah Mory on 6/27/17.
//  Copyright © 2017 kickinbahk Productions. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    Messaging.messaging().subscribe(toTopic: "/topics/news")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

