//
//  AuthLanWorker.swift
//  hse_kr_ios
//
//  Created by Al Stark on 04.04.2023.
//

import Foundation
import FirebaseAuth


protocol AuthLanWorkable {
    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Errors>) -> Void)
    func resetPassword(email: String)
    func confirmEmail()
}

final class AuthLanWorker {
    
}

extension AuthLanWorker: AuthLanWorkable {
    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification( completion: { error in
            print(Auth.auth().currentUser?.uid ?? "frverv")
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Errors>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                switch (error as NSError).code {
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.failure(.emailNotExist))
                case AuthErrorCode.unverifiedEmail.rawValue:
                    completion(.failure(.emailNotVerified))
                case AuthErrorCode.wrongPassword.rawValue:
                    completion(.failure(.wrongPassword))
                default:
                    completion(.failure(.unknownError))
                }
            } else {
                completion(.success(true))
            }
            
        }
    }
}
