//
//  RegisterViewModel.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 04.07.24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel {
    var usernameText: String = "" {
        didSet {
            validateUsername()
        }
    }
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
    var confirmPasswordText: String = "" {
        didSet {
            validateConfirmPassword()
        }
    }
    var usernameError: String?
    var emailError: String?
    var passwordError: String?
    var confirmPasswordError: String?
    
    var onUsernameErrorChange: ((String?) -> Void)?
    var onEmailErrorChange: ((String?) -> Void)?
    var onPasswordErrorChange: ((String?) -> Void)?
    var onConfirmPasswordErrorChange: ((String?) -> Void)?
    var onRegistrationSuccess: (() -> Void)?
    var onRegistrationFailure: ((String) -> Void)?

    
    func registerUser() {
        guard validate() else {
            onUsernameErrorChange?(usernameError)
            onEmailErrorChange?(emailError)
            onPasswordErrorChange?(passwordError)
            onConfirmPasswordErrorChange?(confirmPasswordError)
            return
        }
        
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { [weak self] authDataResult, error in
            if let error = error {
                self?.onRegistrationFailure?(error.localizedDescription)
                return
            }
            UserDefaultsManager.hasCompletedOnboarding = true
            self?.saveUser()
        }
    }
    
    private func getRandomProfileImageName() -> String {
        let imageNames = ["cat1", "cat2", "cat3", "cat4", "cat5", "cat6", "cat7", "cat8"]
        return imageNames.randomElement() ?? "profilePhoto"
    }

    private func saveUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let profileImageName = getRandomProfileImageName()
        let db = Firestore.firestore()
        db.collection("Users").document(userId).setData([
            "username": usernameText,
            "email": emailText,
            "profileImage": profileImageName
        ]) { [weak self] error in
            if let error = error {
                self?.onRegistrationFailure?(error.localizedDescription)
            } else {
                self?.onRegistrationSuccess?()
            }
        }
    }
    
    func validate() -> Bool {
        let isValidUsername = validateUsername()
        let isValidEmail = validateEmail()
        let isValidPassword = validatePassword()
        let isValidConfirmPassword = validateConfirmPassword()
        return isValidUsername && isValidEmail && isValidPassword && isValidConfirmPassword
    }
    
    private func validateUsername() -> Bool {
        if usernameText.isEmpty {
            usernameError = "Username cannot be empty"
            onUsernameErrorChange?(usernameError)
            return false
        } else {
            usernameError = nil
            onUsernameErrorChange?(usernameError)
            return true
        }
    }
    
    private func validateEmail() -> Bool {
        if emailText.isEmpty {
            emailError = "Email cannot be empty"
            onEmailErrorChange?(emailError)
            return false
        } else if !emailText.isValidEmail {
            emailError = "Invalid email format"
            onEmailErrorChange?(emailError)
            return false
        } else {
            emailError = nil
            onEmailErrorChange?(emailError)
            return true
        }
    }
    
    private func validatePassword() -> Bool {
        if passwordText.isEmpty {
            passwordError = "Password cannot be empty"
            onPasswordErrorChange?(passwordError)
            return false
        } else if passwordText.count < 8 {
            passwordError = "Password must be at least 8 characters"
            onPasswordErrorChange?(passwordError)
            return false
        } else if !passwordText.isValidPassword {
            passwordError = "Password must contain at least one number and one uppercase and lowercase letter, and specific characters"
            onPasswordErrorChange?(passwordError)
            return false
        } else {
            passwordError = nil
            onPasswordErrorChange?(passwordError)
            return true
        }
    }
    
    private func validateConfirmPassword() -> Bool {
        if confirmPasswordText.isEmpty {
            confirmPasswordError = "Confirm Password cannot be empty"
            onConfirmPasswordErrorChange?(confirmPasswordError)
            return false
        } else if confirmPasswordText != passwordText {
            confirmPasswordError = "Passwords do not match"
            onConfirmPasswordErrorChange?(confirmPasswordError)
            return false
        } else {
            confirmPasswordError = nil
            onConfirmPasswordErrorChange?(confirmPasswordError)
            return true
        }
    }
}

