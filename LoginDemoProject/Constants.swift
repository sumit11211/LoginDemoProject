//
//  Constant.swift
//  LoginDemoProject
//
//  Created by Sumit Prajapat on 11/03/24.
//

import Foundation
struct Constants {
    
    static let passwordFormatWarning = "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character."
    
    static let detailsNotFilledWarning =  "Please fill in all the details."
    
    static let emailFormatWarning = "Please enter a valid email address."
    
    static let incorrectpassword =  "Enter the correct password."
    
    static let userNotFoundWarning = "User not found"
    
    static let loginDetailsNotFilledWarning = "Please enter your email and password"
    
    static let descriptionViewIdentifier = "DescriptionViewController"
    
    static let registrationViewIdentifier = "RegistrationViewController"
    
    static let loginStatus =  "Logged in successfully"
    
    static let registrationStatus = "Registration successful!"
    
    static let emailFormatConditions = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    static let passwordFormatConditions = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,}+$"
    
    
}
