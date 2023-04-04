//
//  StartInteractor.swift
//  hse_kr_ios
//
//  Created by Al Stark on 30.03.2023.
//

import Foundation

protocol StartBusinessLogic {
    // получить id авторизованного аккаунта
    func getID(completion: @escaping (Result<String, Error>) -> Void)
}

final class StartInteractor {
    
    weak var presenter: StartPresentationMenagement?
    lazy var lanWorker: StartCheckIDLanWorkable = StartCheckIDLanWorker()
//    init(presenter: StartPresentationMenagement) {
//        self.presenter = presenter
//    }
   
}

// MARK: StartBusinessLogic
extension StartInteractor : StartBusinessLogic {
    func getID(completion: @escaping (Result<String, Error>) -> Void) {
        print("interactor")
        lanWorker.getID { result in
            switch result {
            case .success(let uid):
                completion(.success(uid))
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    
}
