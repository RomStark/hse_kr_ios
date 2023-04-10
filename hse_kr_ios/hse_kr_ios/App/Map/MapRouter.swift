//
//  MapRouter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 09.04.2023.
//

import UIKit


protocol MapRoutable {
    func route(to: MapRouter.Target)
}

final class MapRouter {
    private var navigationController: UINavigationController?
    enum Target {
        case some
    }
    
    init(navigationController: UINavigationController) {
           self.navigationController = navigationController
       }
}


//MARK: MapRoutable
extension MapRouter: MapRoutable {
    func route(to: Target) {
        
    }
    
    
}
