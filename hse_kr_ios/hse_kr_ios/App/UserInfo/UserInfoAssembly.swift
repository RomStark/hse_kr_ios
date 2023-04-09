//
//  UserInfoAssembly.swift
//  hse_kr_ios
//
//  Created by Al Stark on 06.04.2023.
//

import UIKit


final class UserInfoAssembly {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

//MARK: UserInfoAssembly
extension UserInfoAssembly: Assemblying {
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? UserInfoViewController else { return }
        
        let router = UserInfoRouter(navigationController: navigationController)
        let interactor = UserInfoInteractor()
        
        let presenter = UserInfoPresenter(view: vc,
                                       router: router,
                                       interactor: interactor)
        vc.presenter = presenter
        interactor.presenter = presenter
    }
    
    
}
