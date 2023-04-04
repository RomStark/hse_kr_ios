//
//  RegistrationAssembly.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import UIKit

final class RegistrationAssembly {
    private let navigationController: UINavigationController
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension RegistrationAssembly: Assemblying {
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? RegistrationViewController else { return }
                
        let router = RegistrationRouter(navigationController: navigationController)
        let interactor = RegistrationInteractor()
        
        let presenter = RegistrationPresenter(view: vc,
                                           router: router,
                                           interactor: interactor)
        vc.presenter = presenter
        interactor.presenter = presenter
    }
    
    
}
