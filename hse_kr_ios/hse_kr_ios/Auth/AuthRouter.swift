//
//  AuthRouter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 31.03.2023.
//

import UIKit

protocol AuthRoutable {
    func route(to: AuthRouter.Target)
}

final class AuthRouter {
    enum Target {
        case registration
    }
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AuthRouter: AuthRoutable {
    func route(to: Target) {
        switch to {
        case .registration:
            let vc = RegistrationViewController()
            RegistrationAssembly(navigationController: navigationController).assembly(viewController: vc)
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    
}
