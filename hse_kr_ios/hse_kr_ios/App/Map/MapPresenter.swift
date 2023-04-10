//
//  MapPresenter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 09.04.2023.
//

import Foundation

protocol MapPresentation {
    func getCharityLocations(completion: @escaping (Result<Dictionary<String, [Double]>, Error>) -> Void)
    func getCharityInfo(id: String, completion: @escaping (Result<Charity, Error>) -> Void)
}

protocol MapPresentationManagemant: AnyObject {
    
}

final class MapPresenter {
    private var router: MapRoutable
    private weak var view: MapViewable?
    private var interactor: MapBusinessLogic
    
    init(view: MapViewable, router: MapRoutable, interactor: MapBusinessLogic) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

//MARK: MapPresentation
extension MapPresenter: MapPresentation {
    func getCharityInfo(id: String, completion: @escaping (Result<Charity, Error>) -> Void) {
        interactor.getCharityInfo(id: id) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    
   
    
    func getCharityLocations(completion: @escaping (Result<Dictionary<String, [Double]>, Error>) -> Void) {
        interactor.getCharityLocations { result in
            switch result {
            case .success(let charityLocations):
                print(charityLocations)
                var rightLocations = Dictionary<String, [Double]>()
                guard let charities = charityLocations as? Dictionary<String, [Double]> else {
                    completion(.success([:]))
                    return
                }
                for i in charities.keys {
                    if charities[i] != [0.0, 0.0] {
                        rightLocations[i] = charities[i]
                    }
                }
                print("presenter")
                print(rightLocations)
                completion(.success(rightLocations))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


//MARK: MapPresentationManagement
extension MapPresenter: MapPresentationManagemant {
    
}
