import UIKit
import RealmSwift
import MessageUI

class LoginViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    let validator = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Login failed", message: Constants.loginDetailsNotFilledWarning)
            return
        }
        
        guard validator.isValidEmail(email) else {
            showAlert(title: "Login failed", message: Constants.emailFormatWarning)
            return
        }
        
        let realm = try! Realm()
        if let registeredUser = realm.objects(Registration.self).filter("email = %@", email).first {
            if registeredUser.password == password {
                // Password is correct, proceed to login
                self.navigateToDescriptionViewController(email: email, entryInformation: Constants.loginStatus)
            } else {
                showAlert(title: "Incorrect Password", message: Constants.incorrectpassword)
            }
        } else {
            showAlert(title: "Register please", message: Constants.userNotFoundWarning) {
                // Navigate to RegistrationViewController
                self.navigateToRegistrationViewController()
            }
        }
    }

    func showAlert(title: String, message: String?, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alertController, animated: true, completion: nil)
    }

    func navigateToDescriptionViewController(email: String, entryInformation: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let descriptionViewController = storyboard.instantiateViewController(withIdentifier: Constants.descriptionViewIdentifier) as? DescriptionViewController {
            descriptionViewController.enteredEmail = email
            descriptionViewController.entryInformation = entryInformation
            navigationController?.pushViewController(descriptionViewController, animated: true)
        }
    }

    func navigateToRegistrationViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let registrationViewController = storyboard.instantiateViewController(withIdentifier: Constants.registrationViewIdentifier) as? RegistrationViewController {
            navigationController?.pushViewController(registrationViewController, animated: true)
        }
    }
}


