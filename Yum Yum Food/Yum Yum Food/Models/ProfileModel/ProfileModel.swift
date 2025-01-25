//
//  ProfileModel.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 25.01.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileModel {
    private let db = Firestore.firestore()
    
    func fetchUserData(completion: @escaping (String?, String?) -> Void) {
        if let user = Auth.auth().currentUser {
            let userRef = db.collection("users").document(user.uid)
            userRef.getDocument { document, error in
                if let error = error {
                    print("Ошибка получения данных пользователя: \(error.localizedDescription)")
                    completion(nil, nil)
                    return
                }
                
                guard let document = document, document.exists, let data = document.data() else {
                    completion(nil, nil)
                    return
                }
                
                let name = data["name"] as? String ?? "No name"
                let email = data["email"] as? String
                completion(name, email)
            }
        } else {
            completion(nil, nil)
        }
    }
}
