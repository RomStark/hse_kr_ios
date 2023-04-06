//
//  CharityTableInteractor.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import Foundation


protocol CharityTableBusinessLogic {
    func getModels(completion: @escaping (Result<[Charity], Error>) -> Void)
    
}

final class CharityTableInteractor {
    weak var presenter: CharityTablePresentationMenagement?
    lazy var lanWorker: AppLanWorkable = AppLanWorker()
    
}

//MARK: CharityTableBusinessLogic
extension CharityTableInteractor: CharityTableBusinessLogic {
    func getModels(completion: @escaping (Result<[Charity], Error>) -> Void) {
        lanWorker.getCharitydata { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let charities):
                completion(.success(charities))
            }
        }
    }
    
    
    
}
