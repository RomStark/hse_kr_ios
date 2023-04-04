//
//  AuthInteractor.swift
//  hse_kr_ios
//
//  Created by Al Stark on 31.03.2023.
//

import Foundation

protocol AuthBusinessLogic {
    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Errors>) -> Void)
    func resetPassword(email: String)
    func confirmEmail()
}

final class AuthInteractor {
    weak var presenter: AuthPresentationManagement?
    lazy var lanWorker: AuthLanWorkable = AuthLanWorker()
}


//MARK: AuthBusinessLogic
extension AuthInteractor: AuthBusinessLogic {
    func confirmEmail() {
        lanWorker.confirmEmail()
    }
    
    func resetPassword(email: String) {
        lanWorker.resetPassword(email: email)
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Errors>) -> Void) {
        if email != "" && password != "" && email.contains("@") {
            lanWorker.signIn(email: email, password: password) {result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(_):
                    completion(.success(true))
                }
            }
        } else {
            completion(.failure(.wrongLoginPassword))
        }
    }
}
