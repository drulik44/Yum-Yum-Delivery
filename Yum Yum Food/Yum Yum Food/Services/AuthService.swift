//
//  AuthService.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 28.11.2024.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthService {
    
    func createUser(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            guard let self = self else { return }

            if let error = error {
                print("Ошибка авторизации:", error.localizedDescription)
                completion(.failure(error))
                return
            }

            // Обновить профиль пользователя с именем
            let changeRequest = result?.user.createProfileChangeRequest()
            changeRequest?.displayName = user.name
            changeRequest?.commitChanges { error in
                if let error = error {
                    print("Ошибка обновления профиля: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                
                // Отправить письмо для подтверждения электронной почты (если требуется Firebase)
                result?.user.sendEmailVerification { error in
                    if let error = error {
                        print("Ошибка отправки письма для подтверждения: \(error.localizedDescription)")
                    } else {
                        print("Письмо для подтверждения электронной почты отправлено.")
                    }
                }
                
                self.signOut()
                completion(.success(true))
            }
        }
    }

    func signIn(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            if let error = error {
                print("Ошибка авторизации:", error.localizedDescription)
                completion(.failure(error))
                return
            }

            guard let user = result?.user else {
                completion(.failure(SigInError.invalidUser))
                return
            }

            if !user.isEmailVerified {
                completion(.failure(SigInError.notVerified))
            } else {
                completion(.success(true))
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Ошибка выхода из учетной записи: \(error.localizedDescription)")
        }
    }
}

enum SigInError: Error {
    case invalidUser
    case notVerified
}


