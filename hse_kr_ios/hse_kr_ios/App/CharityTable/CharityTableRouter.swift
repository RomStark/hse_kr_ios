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
        case some
    }
    init(navigationController: UINavigationController) {
           self.navigationController = navigationController
       }
}

//MARK: CharityTableRoutable
extension CharityTableRouter: CharityTableRoutable {
    func route(to: Target) {
        
    }
    
  
    
}
