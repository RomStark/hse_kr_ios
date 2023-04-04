//
//  RegistrationPresenter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import Foundation


protocol RegistrationPresentable {
    func registration(name: String, email: String, password: String, completion: @escaping (Result<String, Errors>) -> Void)
}

protocol RegistrationPresentationManegemant: AnyObject {
    
}

final class RegistrationPresenter {
    private weak var view: RegistrationViewable?
    private var router: RegistrationRoutable
    private var interactor: RegistrationBusinessLogic
    
   
    init(view: RegistrationViewable, router: RegistrationRoutable, interactor: RegistrationBusinessLogic) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

//MARK: RegistrationPresentation
extension RegistrationPresenter: RegistrationPresentable {
    func registration(name: String, email: String, password: String, completion: @escaping (Result<String, Errors>) -> Void) {
        interactor.registration(name: name, email: email, password: password) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let id):
                completion(.success(id))
            }
        }
    }
    
    
}

//MARK: RegistrationPresentationManegemant
extension RegistrationPresenter: RegistrationPresentationManegemant {
    
}
