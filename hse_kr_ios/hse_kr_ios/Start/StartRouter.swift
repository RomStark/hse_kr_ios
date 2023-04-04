//
//  StartRouter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 30.03.2023.
//

import UIKit


protocol StartRoutable {
    func route(to: StartRouter.Target)
}

final class StartRouter {
    private var navigationController: UINavigationController?
    enum Target {
        case auth
        case charityTable
    }
    
    init(navigationController: UINavigationController) {
           self.navigationController = navigationController
       }
}

// MARK: StartRoutable
extension StartRouter: StartRoutable {
    func route(to: Target) {
        guard let navigationController = navigationController else { return }
        switch to {
        case .auth:
            print("route to auth")
            let view = AuthViewController()
            AuthAssembly(navigationController: navigationController).assembly(viewController: view)
            navigationController.pushViewController(view, animated: true)
        case .charityTable:
            print("route to table")
        }
    }
    
    
}
