//
//  LoginViewModel.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 04.07.24.
//

import UIKit
import FirebaseAuth

class LoginViewModel {
    private var valiDateEmail: Bool = false
    private var valiDatePassword: Bool = false
    
    var emailText: String = "" {
        didSet {
            validateEmail()
        }
    }
    var passwordText: String = "" {
        didSet {
            validatePassword()
        }
    }
    
    var emailError: String? {
        didSet {
            onEmailErrorChange?(emailError)
        }
    }
    
    var passwordError: String? {
        didSet {
            onPasswordErrorChange?(passwordError)
        }
    }
    var onEmailErrorChange: ((String?) -> Void)?
    var onPasswordErrorChange: ((String?) -> Void)?
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    func loginUser() {
        guard validate() else {
            onEmailErrorChange?(emailError)
            onPasswordErrorChange?(passwordError)
            return
        }
        
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { [weak self] authDataResult, error in
            if let error = error {
                self?.onLoginFailure?(error.localizedDescription)
                return
            }
            UserDefaultsManager.hasCompletedOnboarding = true
            self?.onLoginSuccess?()
        }
    }
    
    func validate() -> Bool {
        return valiDateEmail && valiDatePassword
    }
    
    private func validateEmail() {
        if emailText.isEmpty {
            emailError = "Email cannot be empty"
            valiDateEmail = false
        } else if !emailText.isValidEmail {
            emailError = "Invalid email format"
            valiDateEmail = false
        } else {
            emailError = nil
            valiDateEmail = true
        }
    }
    
    private func validatePassword() {
        if passwordText.isEmpty {
            passwordError = "Password cannot be empty"
            valiDatePassword = false
        } else if passwordText.count < 8 {
            passwordError = "Password must be at least 8 characters"
            valiDatePassword = false
        } else if !passwordText.isValidPassword {
            passwordError = "Password must contain at least one number and one uppercase and lowercase letter, and specific characters"
            valiDatePassword = false
        } else {
            passwordError = nil
            valiDatePassword = true
        }
    }
}




