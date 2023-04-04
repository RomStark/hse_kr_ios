//
//  StartAssembly.swift
//  hse_kr_ios
//
//  Created by Al Stark on 02.04.2023.
//

import UIKit

final class StartAssembly {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension StartAssembly: Assemblying {
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? StartViewController else { return }
        
        let router = StartRouter(navigationController: navigationController)
        let interactor = StartInteractor()
        
        let presenter = StartPresenter(view: vc,
                                       router: router,
                                       interactor: interactor)
        vc.presenter = presenter
        interactor.presenter = presenter
    }
    
    
}
