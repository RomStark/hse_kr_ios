//
//  AddCharityInteractor.swift
//  hse_kr_ios
//
//  Created by Al Stark on 10.04.2023.
//

import Foundation
import CoreLocation

protocol AddCharityBusinessLogic {
    func confirmAdress(adress: String, completion: @escaping (Result<[Double], Errors>) -> Void)
    func addCharity(name: String, description: String, qiwiLink: String, adress: [Double], completion: @escaping (Result<Bool, Errors>) -> Void)
}

final class AddCharityInteractor {
    weak var presenter: AddCharityPresentationManagement?
    lazy var lanWorker: AddCharityLanWorkable = AddCharityLanWorker()
}

//MARK: AddCharityBusinessLogic
extension AddCharityInteractor: AddCharityBusinessLogic {
    func confirmAdress(adress: String, completion: @escaping (Result<[Double], Errors>) -> Void)  {
        if adress == "" {
            completion(.failure(.adressNotSpecified))
        } else {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(adress) { (placemarks, error) in
                if error != nil {
                    completion(.failure(.adressNotExist))
                }
                if placemarks != nil {
                    if let placemark = placemarks?.first {
                        guard let coordinate = placemark.location?.coordinate else {
                            completion(.failure(.adressNotExist))
                            return
                            
                        }
                        completion(.success([coordinate.latitude, coordinate.longitude]))
                    }
                }
                
            }
        }
    }
    func addCharity(name: String, description: String, qiwiLink: String, adress: [Double], completion: @escaping (Result<Bool, Errors>) -> Void) {

        lanWorker.addCharity(name: name, description: description, qiwiLink: qiwiLink, adress: adress) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
    }
}
