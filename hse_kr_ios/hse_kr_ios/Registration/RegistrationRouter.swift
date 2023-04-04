//
//  RegistrationRouter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import UIKit

protocol RegistrationRoutable {
    func route(to: RegistrationRouter.Target)
}

final class RegistrationRouter {
    enum Target {
        case some
    }
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}


//MARK: RegistrationRoutable
extension RegistrationRouter: RegistrationRoutable {
    func route(to: Target) {
        
    }
    
    
}
