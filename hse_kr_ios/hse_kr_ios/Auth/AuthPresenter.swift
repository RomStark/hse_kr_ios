//
//  AuthPresenter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 31.03.2023.
//

import Foundation

protocol AuthPresentable {
    func changeToRegPasswordButtonTapped()
    func signInButtonTapped(email: String, password: String)
    func resetpassword(email: String)
    func confirmEmail()
}

protocol AuthPresentationManagement: AnyObject{
   
}

final class AuthPresenter {
    private weak var view: AuthViewable?
    private var router: AuthRoutable
    private var interactor: AuthBusinessLogic
    
   
    init(view: AuthViewable, router: AuthRoutable, interactor: AuthBusinessLogic) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: AuthPresentable
extension AuthPresenter: AuthPresentable {
    func confirmEmail() {
        interactor.confirmEmail()
    }
    
    func resetpassword(email: String) {
        interactor.resetPassword(email: email)
    }
    
    func signInButtonTapped(email: String, password: String) {
        interactor.signIn(email: email, password: password) {[weak self] result in
            switch result {
            case .failure(let error):
                self?.view?.showAlert(error: error)
            case .success(_):
                print("signIn")
            }
        }
    }
    
   
    
    func changeToRegPasswordButtonTapped() {
        router.route(to: .registration)
    }
    
    
}

//MARK: AuthPresentationManagement
extension AuthPresenter: AuthPresentationManagement {
   
}
