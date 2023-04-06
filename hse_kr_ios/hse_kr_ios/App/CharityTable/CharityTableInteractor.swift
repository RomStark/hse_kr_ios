//
//  CharityTableInteractor.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import Foundation


protocol CharityTableBusinessLogic {
    func signOut()
    func getModels(completion: @escaping (Result<[Charity], Error>) -> Void)
}

final class CharityTableInteractor {
    weak var presenter: CharityTablePresentationMenagement?
    lazy var lanWorker: AppLanWorkable = AppLanWorker()
    
}

//MARK: CharityTableBusinessLogic
extension CharityTableInteractor: CharityTableBusinessLogic {
    func getModels(completion: @escaping (Result<[Charity], Error>) -> Void) {
        lanWorker.getCharitydata { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let charities):
//                var doneCharyties = [Charity]()
//                for charity in charities {
//                    self?.lanWorker.uploadImageData(url: charity.photoURL) { data in
//                        var char = charity
//                        char.data = data
//                        doneCharyties.append(char)
//                    }
//                }
                completion(.success(charities))
            }
        }
    }
    
    func signOut() {
        lanWorker.signOut()
    }
    
    
}
