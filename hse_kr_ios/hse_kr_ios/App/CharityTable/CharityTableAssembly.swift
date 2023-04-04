//
//  CharityTableAssembly.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import UIKit

final class CharityTableAssembly {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CharityTableAssembly: Assemblying {
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? CharityTableViewController else { return }
        
        let router = CharityTableRouter(navigationController: navigationController)
        let interactor = CharityTableInteractor()
        
        let presenter = CharityTablePresenter(view: vc,
                                       router: router,
                                       interactor: interactor)
        vc.presenter = presenter
        interactor.presenter = presenter
    }
    
    
}
