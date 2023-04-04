//
//  RegistrationWorker.swift
//  hse_kr_ios
//
//  Created by Al Stark on 04.04.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


protocol RegistrationWorkable {
    func registration(name: String, email: String, password: String, completion: @escaping (Result<String, Errors>) -> Void)
}

final class RegistrationWorker {
    
}

extension RegistrationWorker: RegistrationWorkable {
    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification( completion: { error in
            print(Auth.auth().currentUser?.uid ?? "frverv")
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    func registration(name: String, email: String, password: String, completion: @escaping (Result<String, Errors>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                switch (error as NSError).code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(.failure(.emailExist))
                default:
                    completion(.failure(.unknownError))
                }
            }
            
            guard let result = result else {
                completion(.failure(.unknownError))
                return
            }
            
            let data = ["email": email, "name": name]
            Firestore.firestore().collection("users").document(result.user.uid).setData(data)
            completion(.success(result.user.uid))
            self?.confirmEmail()
        }
    }
}
