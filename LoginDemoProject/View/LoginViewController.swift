import UIKit
import RealmSwift
import MessageUI

class LoginViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            let alertController = UIAlertController(title: "Login failed", message: Constants.loginDetailsNotFilledWarning, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        
        if isValidEmail(email) {
            let realm = try! Realm()
            // Query the Realm database to check if a user with the entered email exists
            let registeredUser = realm.objects(Registration.self)
                .filter("email = %@", email)
                .first
            
            if let user = registeredUser {
                // User with the entered email exists, check if the password matches
                if user.password == password {
                    // Password is correct, proceed to login
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let descriptionViewController = storyboard.instantiateViewController(withIdentifier: Constants.descriptionViewIdentifier) as? DescriptionViewController {
                        descriptionViewController.enteredEmail = email
                        descriptionViewController.entryInformation = Constants.loginStatus
                        navigationController?.pushViewController(descriptionViewController, animated: true)
                    }
                } else {
                    // Password is incorrect, show notification "Incorrect Password"
                    let alertController = UIAlertController(title: "Incorrect Password", message: Constants.incorrectpassword, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController, animated: true, completion: nil)
                }
            } else {
                // User is not registered, show notification "Register first" and navigate to RegistrationViewController
                let alertController = UIAlertController(title: "Register please", message: Constants.userNotFoundWarning, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    // Navigate to RegistrationViewController
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let registrationViewController = storyboard.instantiateViewController(withIdentifier: Constants.registrationViewIdentifier) as? RegistrationViewController {
                        self.navigationController?.pushViewController(registrationViewController, animated: true)
                    }
                }))
                present(alertController, animated: true, completion: nil)
            }
        } else {
            // Invalid email format, show an error message
            let alertController = UIAlertController(title: "Login failed", message: Constants.emailFormatWarning, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            loginButtonTapped(loginButton)
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Method to verify email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = Constants.emailFormatConditions
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}



