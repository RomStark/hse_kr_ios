//
//  RegistrationInteractor.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import Foundation

protocol RegistrationBusinessLogic {
    func registration(name: String, email: String, password: String, completion: @escaping (Result<String, Errors>) -> Void)
}

final class RegistrationInteractor {
    weak var presenter: RegistrationPresentationManegemant?
    lazy var lanWorker: RegistrationWorkable = RegistrationWorker()
}


//MARK: RegistrationBusinessLogic
extension RegistrationInteractor: RegistrationBusinessLogic {
    func registration(name: String, email: String, password: String, completion: @escaping (Result<String, Errors>) -> Void) {
        if name.isEmpty || email.isEmpty || password.isEmpty || email.contains("@") != true {
            completion(.failure(.wrongLoginPassword))
        } else {
            lanWorker.registration(name: name, email: email, password: password) { result in
                switch result {
                case .success(let id):
                    completion(.success(id))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
    }
}
