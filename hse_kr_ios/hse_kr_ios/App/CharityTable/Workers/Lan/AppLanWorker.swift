//
//  AppLanWorker.swift
//  hse_kr_ios
//
//  Created by Al Stark on 04.04.2023.
//

import Foundation

import FirebaseAuth

protocol AppLanWorkable {
    func signOut()
}

final class AppLanWorker {
    
}

extension AppLanWorker: AppLanWorkable {
    func signOut() {
        do {
            try? Auth.auth().signOut()
        }
    }
    
}
