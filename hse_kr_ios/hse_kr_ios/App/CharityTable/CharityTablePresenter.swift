//
//  CharityTablePresenter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import Foundation


protocol CharityTablePresentation {
    func signOut()
    func getCharityModels(completion: @escaping (Result<[Charity], Error>) -> Void)
}

protocol CharityTablePresentationMenagement: AnyObject {
    
}

final class CharityTablePresenter {
    
    private var router: CharityTableRoutable
    private weak var view: CharityTableViewable?
    private var interactor: CharityTableBusinessLogic
    
    init(view: CharityTableViewable, router: CharityTableRoutable, interactor: CharityTableBusinessLogic) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

//MARK: CharityTablePresentation
extension CharityTablePresenter: CharityTablePresentation {
    func getCharityModels(completion: @escaping (Result<[Charity], Error>) -> Void) {
        interactor.getModels { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let charity):
                completion(.success(charity))
            }
        }
    }
    
    func signOut() {
        interactor.signOut()
    }
    
    
}

//MARK: CharityTablePresentationMenagement
extension CharityTablePresenter: CharityTablePresentationMenagement {
    
}
