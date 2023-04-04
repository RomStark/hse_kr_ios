//
//  AuthAssembly.swift
//  hse_kr_ios
//
//  Created by Al Stark on 31.03.2023.
//

import UIKit

final class AuthAssembly {
    private let navigationController: UINavigationController
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AuthAssembly: Assemblying {
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? AuthViewController else { return }
                
        let router = AuthRouter(navigationController: navigationController)
        let interactor = AuthInteractor()
        
        let presenter = AuthPresenter(view: vc,
                                           router: router,
                                           interactor: interactor)
        vc.presenter = presenter
        interactor.presenter = presenter
    }
    
    
}
