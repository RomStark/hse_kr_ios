//
//  UserInfoRouter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 06.04.2023.
//

import UIKit


protocol UserInfoRoutable {
    func route(to: UserInfoRouter.Target)
}

final class UserInfoRouter {
    private var navigationController: UINavigationController?
    enum Target {
        case auth
        case charityTable
    }
    
    init(navigationController: UINavigationController) {
           self.navigationController = navigationController
       }
}

//MARK: UserInfoRoutable
extension UserInfoRouter: UserInfoRoutable {
    func route(to: Target) {
        
    }
    
    
}
