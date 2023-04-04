//
//  CharityTableInteractor.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import Foundation


protocol CharityTableBusinessLogic {
    func signOut()
}

final class CharityTableInteractor {
    weak var presenter: CharityTablePresentationMenagement?
    lazy var lanWorker: AppLanWorkable = AppLanWorker()
    
}

//MARK: CharityTableBusinessLogic
extension CharityTableInteractor: CharityTableBusinessLogic {
    func signOut() {
        lanWorker.signOut()
    }
    
    
}
