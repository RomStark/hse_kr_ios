//
//  UserInfoInteractor.swift
//  hse_kr_ios
//
//  Created by Al Stark on 06.04.2023.
//

import Foundation

protocol UserInfoBusinessLogic {
    func logOut()
    func getUserInfo(completion: @escaping (_ user: User) -> Void)
}
 

final class UserInfoInteractor {
    weak var presenter: UserInfoPresentationManegemant?
    lazy var lanWorker: UserInfoLanWorkable = UserInfoLanWorker()
}

//MARK: UserInfoBusinessLogic
extension UserInfoInteractor: UserInfoBusinessLogic {
    func getUserInfo(completion: @escaping (_ user: User) -> Void) {
        lanWorker.getuserInfo { user in
            completion(user)
        }
    }
    
    func logOut() {
        lanWorker.logOut()
    }
    
    
}
