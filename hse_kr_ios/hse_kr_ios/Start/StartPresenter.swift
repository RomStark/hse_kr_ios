//
//  StartPresenter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 30.03.2023.
//

import Foundation

//Протокол передачи UI эвентов слою презентации
protocol StartPresentation {
    func readyForLoadAndRoute()
}

protocol StartPresentationMenagement: AnyObject {
    
}

// Слой presentation для модуля Start
final class StartPresenter {
    
    private var router: StartRoutable
    private weak var view: StartViewable?
    private var interactor: StartBusinessLogic
    
    init(view: StartViewable, router: StartRoutable, interactor: StartBusinessLogic) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: StartPresentation
extension StartPresenter: StartPresentation {
    func readyForLoadAndRoute() {
        print("presenter")
        interactor.getID { [weak self] result in
            switch result {
            case .success(let uid):
                if uid == "" {
                    self?.router.route(to: .auth)
                }
            case .failure( _):
                print("error")
            }
        }
    }
    
    
}

//  MARK: StartPresentationMenagement
extension StartPresenter: StartPresentationMenagement {
    
}
