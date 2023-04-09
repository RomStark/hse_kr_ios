//
//  UserInfoLanWorker.swift
//  hse_kr_ios
//
//  Created by Al Stark on 06.04.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


protocol UserInfoLanWorkable {
    func logOut()
    func getuserInfo(completion: @escaping (_ user: User) -> Void)
    
}

final class UserInfoLanWorker {
    
}


//MARK: UserInfoLanWorkable
extension UserInfoLanWorker: UserInfoLanWorkable {
    func getuserInfo(completion: @escaping (_ user: User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { document, error in
            if let _ = error {
                return
            }
            guard let document = document else {
                return
            }
            let data = document.data()
            let user = User(name: data?["name"] as? String ?? "", email: data?["email"] as? String ?? "", photoURL: data?["photourl"] as? String)
            completion(user)
        }
    }
    
    
    func logOut() {
        do {
            try? Auth.auth().signOut()
        }
    }
    
    
}
