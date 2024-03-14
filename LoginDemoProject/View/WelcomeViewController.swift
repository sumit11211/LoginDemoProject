//
//  WelcomeViewController.swift
//  LoginDemoProject
//
//  Created by Sumit Prajapat on 07/03/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    
    override func viewDidLoad() {
        navigationItem.backButtonTitle = ""
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
