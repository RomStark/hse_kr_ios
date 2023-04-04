//
//  Extensions.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import Foundation

import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
