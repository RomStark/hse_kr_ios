//
//  StartCheckIDLanWorker.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import Foundation
import FirebaseAuth

protocol StartCheckIDLanWorkable {
    func getID(completion: @escaping (Result<String, Error>) -> Void)
}

final class StartCheckIDLanWorker {
    
}

extension StartCheckIDLanWorker: StartCheckIDLanWorkable {
    func getID(completion: @escaping (Result<String, Error>) -> Void) {
        print("worker")
        Auth.auth().addStateDidChangeListener { auth, user in
            DispatchQueue.main.async {
                print("auth")
                guard let user = user else {
                    completion(.success(""))
                    return
                }
                completion(.success(user.uid))
            }
            
            
        }
    }
    
}
