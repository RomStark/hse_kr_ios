//
//  MapInteractor.swift
//  hse_kr_ios
//
//  Created by Al Stark on 09.04.2023.
//

import Foundation


protocol MapBusinessLogic {
    func getCharityLocations(completion: @escaping (Result<Dictionary<String, [Double]>, Error>) -> Void)
    func getCharityInfo(id: String, completion: @escaping (Result<Charity, Error>) -> Void)
}

final class MapInteractor {
    weak var presenter: MapPresentationManagemant?
    lazy var lanWorker: MapLanWorkable = MapLanWorker()
}


//MARK: MapBusinessLogic
extension MapInteractor: MapBusinessLogic {
    func getCharityInfo(id: String, completion: @escaping (Result<Charity, Error>) -> Void) {
        lanWorker.getCharityInfo(id: id) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    func getCharityLocations(completion: @escaping (Result<Dictionary<String, [Double]>, Error>) -> Void) {
        lanWorker.getCharityLocations { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let charityLocations):
                completion(.success(charityLocations))
            }
        }
    }
}
