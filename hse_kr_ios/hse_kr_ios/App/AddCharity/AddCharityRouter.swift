//
//  AddCharityRouter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 10.04.2023.
//

import UIKit

protocol AddCharityRoutable {
    
}

final class AddCharityRouter {
    private var navigationController: UINavigationController?
    
    
    init(navigationController: UINavigationController) {
           self.navigationController = navigationController
       }
}

//MARK: AddCharityRoutable
extension AddCharityRouter: AddCharityRoutable {
    
}
