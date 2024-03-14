//
//  DescriptionViewController.swift
//  LoginDemoProject
//
//  Created by Sumit Prajapat on 07/03/24.
//

import UIKit
import RealmSwift

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    
    var enteredEmail : String = ""
    var entryInformation : String = ""
    var user: Registration?
    
    @IBAction func logOutButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        informationLabel.text = entryInformation
        let realm = try! Realm()
        let loggedUser = realm.objects(Registration.self).filter("email = %@", enteredEmail).first
        if loggedUser != nil {
            self.firstNameLabel.text = "\(loggedUser!.firstName)"
            self.lastNameLabel.text = "\(loggedUser!.lastName)"
            self.emailLabel.text = "\(loggedUser!.email)"
        }
        
    }
}
