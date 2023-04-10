//
//  MapAssembly.swift
//  hse_kr_ios
//
//  Created by Al Stark on 09.04.2023.
//

import UIKit

final class MapAssembly {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

//MARK: UserInfoAssembly
extension MapAssembly: Assemblying {
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? MapViewController else { return }
        
        let router = MapRouter(navigationController: navigationController)
        let interactor = MapInteractor()
        
        let presenter = MapPresenter(view: vc,
                                       router: router,
                                       interactor: interactor)
        vc.presenter = presenter
        interactor.presenter = presenter
    }
    
    
}



