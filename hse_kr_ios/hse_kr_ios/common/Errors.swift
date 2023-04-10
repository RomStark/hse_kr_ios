//
//  Errors.swift
//  hse_kr_ios
//
//  Created by Al Stark on 04.04.2023.
//

import Foundation

enum Errors: Error {
    case emailExist
    case emailNotExist
    case unknownError
    case emailNotVerified
    case wrongPassword
    case wrongLoginPassword
    case adressNotExist
    case nameNotExist
    case descriptionNotExist
    case adressNotSpecified
}
