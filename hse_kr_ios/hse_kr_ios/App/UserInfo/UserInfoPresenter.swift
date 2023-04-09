//
//  UserInfoPresenter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 06.04.2023.
//

import Foundation


protocol UserInfoPresentation {
    func logOut()
    func getUserInfo(completion: @escaping (_ user: User) -> Void)
}

protocol UserInfoPresentationManegemant: AnyObject {
    
}

final class UserInfoPresenter {
    private var router: UserInfoRoutable
    private weak var view: UserInfoViewable?
    private var interactor: UserInfoBusinessLogic
    
    init(view: UserInfoViewable, router: UserInfoRoutable, interactor: UserInfoBusinessLogic) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

//MARK: UserInfoPresentation
extension UserInfoPresenter: UserInfoPresentation {
    func getUserInfo(completion: @escaping (_ user: User) -> Void) {
        interactor.getUserInfo { user in
            completion(user)
        }
        
    }
    
    
    func logOut() {
        interactor.logOut()
    }
    
    
}

//MARK: UserInfoPresentationManegemant
extension UserInfoPresenter: UserInfoPresentationManegemant {
    
}
