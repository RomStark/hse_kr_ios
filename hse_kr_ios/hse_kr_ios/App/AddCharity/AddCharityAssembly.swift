//
//  AddCharityAssembly.swift
//  hse_kr_ios
//
//  Created by Al Stark on 10.04.2023.
//

import UIKit

final class AddCharityAssembly {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AddCharityAssembly: Assemblying {
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? AddCharityViewController else { return }
        
        let router = AddCharityRouter(navigationController: navigationController)
        let interactor = AddCharityInteractor()
        
        let presenter = AddCharityPresenter(view: vc,
                                       router: router,
                                       interactor: interactor)
        vc.presenter = presenter
        interactor.presenter = presenter
    }
    
    
}
