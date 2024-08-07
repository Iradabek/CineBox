//
//  ProfileViewModel.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 19.07.24.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class ProfileViewModel {
    var userEmail: String = ""
    var username: String = ""
    var profileImageName: String = ""
    
    var onUserDataFetch: (() -> Void)?
    
    init() {
        fetchUserData()
    }
    
    private func fetchUserData() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document(currentUser.uid)
        
        userRef.getDocument { [weak self] document, error in
            if let document = document, document.exists {
                let data = document.data()
                self?.userEmail = data?["email"] as? String ?? ""
                self?.username = data?["username"] as? String ?? ""
                self?.profileImageName = data?["profileImage"] as? String ?? "profilePhoto"
                self?.onUserDataFetch?()
            } else {
                print("Document does not exist: \(error?.localizedDescription ?? "")")
            }
        }
    }
}

