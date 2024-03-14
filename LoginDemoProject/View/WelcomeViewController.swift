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
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.02441048995, green: 0.01944379136, blue: 0.06603208929, alpha: 1)
           // .systemIndigo
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5464712977, green: 0.8229803443, blue: 0.9043354988, alpha: 1)]
        navigationItem.title = "Welcome"
        navigationItem.backButtonTitle = ""
        // Do any additional setup after loading the view.
    }
}
