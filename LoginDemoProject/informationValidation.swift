//
//  informationValidation.swift
//  LoginDemoProject
//
//  Created by Sumit Prajapat on 14/03/24.
//

import Foundation

struct Validation {
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = Constants.emailFormatConditions
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = Constants.passwordFormatConditions
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
}
