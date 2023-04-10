//
//  CharityStorage.swift
//  hse_kr_ios
//
//  Created by Al Stark on 10.04.2023.
//

import Foundation

final class CharityStorage {
    var charities = [String: Charity]()
    static let shared = CharityStorage()
    private init() {
        
    }
}
