//
//  AddCharityPresenter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 10.04.2023.
//

import Foundation

protocol AddCharityPresentation {
    func confirmAdress(adress: String, completion: @escaping (Result<[Double], Errors>) -> Void) 
    func addCharity(name: String, description: String, qiwiLink: String, adress: [Double], imageData: Data, completion: @escaping (Result<Bool, Errors>) -> Void)
}

protocol AddCharityPresentationManagement: AnyObject {
    
}

final class AddCharityPresenter {
    private var router: AddCharityRoutable
    private weak var view: AddCharityViewable?
    private var interactor: AddCharityBusinessLogic
    
    init(view: AddCharityViewable, router: AddCharityRoutable, interactor: AddCharityBusinessLogic) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

//MARK: AddCharityPresentation
extension AddCharityPresenter: AddCharityPresentation{
    func confirmAdress(adress: String, completion: @escaping (Result<[Double], Errors>) -> Void)  {
        interactor.confirmAdress(adress: adress) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func addCharity(name: String, description: String, qiwiLink: String, adress: [Double], imageData: Data, completion: @escaping (Result<Bool, Errors>) -> Void) {
        interactor.addCharity(name: name, description: description, qiwiLink: qiwiLink, adress: adress, imageData: imageData) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}


//MARK: AddCharityPresentationManagement
extension AddCharityPresenter: AddCharityPresentationManagement {
    
    
    
}
