//
//  RegistrationViewController.swift
//  LoginDemoProject
//
//  Created by Sumit Prajapat on 07/03/24.
//

import UIKit
import RealmSwift


class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordWarningLabel.text = Constants.passwordFormatWarning
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: Constants.detailsNotFilledWarning)
            return
        }
        
        guard isValidEmail(email) else {
            showAlert(title: "Error", message: Constants.emailFormatWarning)
            return
        }
        
        guard isValidPassword(password) else {
            showAlert(title: "Password Format Error", message: Constants.passwordFormatWarning)
            return
        }
        
        let realm = try! Realm()
        guard realm.objects(Registration.self).filter("email = %@", email).first == nil else {
            showAlert(title: "Email Already Registered", message: nil)
            return
        }
        
        // Create a new Registration object and set its properties
        let registration = Registration()
        registration.firstName = firstName
        registration.lastName = lastName
        registration.email = email
        registration.password = password
        
        // Save the registration object to the Realm database
        try! realm.write {
            realm.add(registration)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let descriptionViewController = storyboard.instantiateViewController(withIdentifier: "DescriptionViewController") as? DescriptionViewController {
            descriptionViewController.enteredEmail = email
            descriptionViewController.entryInformation = Constants.registrationStatus
            navigationController?.pushViewController(descriptionViewController, animated: true)
        }
    }

    func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    // Method to verify Email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = Constants.emailFormatConditions
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    // Method to verify password format
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = Constants.passwordFormatConditions
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            registerButtonTapped(registerButton) // Call your registration method here
        default:
            break
        }
        return true
    }
}

