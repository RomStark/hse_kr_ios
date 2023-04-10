//
//  CharityClass.swift
//  hse_kr_ios
//
//  Created by Al Stark on 10.04.2023.
//

import Foundation
import MapKit

final class CharityClass: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var id: String = ""
    var name: String = ""
    
//    let creatorID: String
//    let name: String
//    let description: String
//    let photoURL: String?
//    let art: Bool
//    let children: Bool
//    let education: Bool
//    let healthcare: Bool
//    let poverty: Bool
//    let scienceResearch: Bool
//    let qiwiURL: String?
    
    var title: String? {
        return name
    }
    
//    init(id: String, coordinate: CLLocationCoordinate2D, creatorID: String, name: String, description: String, photoURL: String? = nil, art: Bool = false, children: Bool = false, education: Bool = false, healthcare: Bool = false, poverty: Bool = false, scienceResearch: Bool = false, qiwiURL: String? = nil ) {
//        self.creatorID = creatorID
//        self.name = name
//        self.description = description
//        self.photoURL = photoURL
//        self.latitude = latitude
//        self.longitude = longitude
//        self.art = art
//        self.children = children
//        self.education = education
//        self.healthcare = healthcare
//        self.poverty = poverty
//        self.scienceResearch = scienceResearch
//        self.qiwiURL = qiwiURL
//    }
    init(id: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.coordinate = coordinate
    }
    
}
