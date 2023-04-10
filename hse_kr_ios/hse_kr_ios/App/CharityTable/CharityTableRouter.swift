//
//  CharityTableRouter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import UIKit


protocol CharityTableRoutable {
    func route(to: CharityTableRouter.Target)
}

final class CharityTableRouter {
    private var navigationController: UINavigationController?
    
    enum Target {
        case addCharity
    }
    init(navigationController: UINavigationController) {
           self.navigationController = navigationController
       }
}

//MARK: CharityTableRoutable
extension CharityTableRouter: CharityTableRoutable {
    func route(to: Target) {
        switch to {
        case .addCharity:
            guard let navigationController = navigationController else {return}
            let addCharityVC = AddCharityViewController()
            AddCharityAssembly(navigationController: navigationController).assembly(viewController: addCharityVC)
            navigationController.pushViewController(addCharityVC, animated: true)
        }
    }
    
  
    
}
