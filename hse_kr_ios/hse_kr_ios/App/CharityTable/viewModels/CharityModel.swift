//
//  CharityModel.swift
//  hse_kr_ios
//
//  Created by Al Stark on 05.04.2023.
//

import Foundation

struct Charity: Codable {
    let creatorID: String
    let name: String
    let description: String
    let photoURL: String?
    let latitude: Double?
    let longitude: Double?
    let art: Bool
    let children: Bool
    let education: Bool
    let healthcare: Bool
    let poverty: Bool
    let scienceResearch: Bool
    let qiwiURL: String?
    
    init(creatorID: String, name: String, description: String, photoURL: String? = nil, latitude: Double? = nil, longitude: Double? = nil, art: Bool = false, children: Bool = false, education: Bool = false, healthcare: Bool = false, poverty: Bool = false, scienceResearch: Bool = false, qiwiURL: String? = nil) {
        self.creatorID = creatorID
        self.name = name
        self.description = description
        self.photoURL = photoURL
        self.latitude = latitude
        self.longitude = longitude
        self.art = art
        self.children = children
        self.education = education
        self.healthcare = healthcare
        self.poverty = poverty
        self.scienceResearch = scienceResearch
        self.qiwiURL = qiwiURL
    }
}
