//
//  MapLanWorker.swift
//  hse_kr_ios
//
//  Created by Al Stark on 10.04.2023.
//

import Foundation
import FirebaseFirestore
import MapKit

protocol MapLanWorkable {
    func getCharityLocations(completion: @escaping (Result<[String: [Double]], Error>) -> Void)
    func getCharityInfo(id: String, completion: @escaping (Result<Charity, Error>) -> Void)
}

final class MapLanWorker {
    private let db = Firestore.firestore()
}

//MARK: MapLanWorkable
extension MapLanWorker: MapLanWorkable {
    func getCharityInfo(id: String, completion: @escaping (Result<Charity, Error>) -> Void) {
//        db.collection("charities").document(id).getDocument { document, error in
//            if let error = error {
//                completion(.failure(error))
//            }
//            if let document = document {
//                let data = document.data()
//                let charity = Charity(
//                    creatorID: data["creatorid"] as? String ?? "creatorID",
//                    name: data["name"] as? String ?? "name",
//                    description: data["description"] as? String ?? "description",
//                    photoURL: data["photourl"] as? String,
//                    latitude: data["latitude"] as? Double,
//                    longitude: data["longitude"] as? Double,
//                    art: data["art"] as? Bool ?? false,
//                    children: data["children"] as? Bool ?? false,
//                    education: data["education"] as? Bool ?? false,
//                    healthcare: data["healthcare"]as? Bool ?? false,
//                    poverty: data["poverty"] as? Bool ?? false,
//                    scienceResearch: data["science&research"] as? Bool ?? false,
//                    qiwiURL: data["qiwiurl"] as? String
//                )
//                completion(.success(charity))
//            } else {
//                completion(.failure(error))
//            }
//        }
//        db.collection("charities").document(id).getDocument { (document, error) in
//
//
//
//        }
    }
    func getCharityLocations(completion: @escaping (Result<[String: [Double]], Error>) -> Void) {
        db.collection("charitylocations").getDocuments { query, error in
            if let error = error {
                completion(.failure(error))
            }
            var charitiesList = [String: [Double]]()
            guard let docs = query?.documents else {
                completion(.success([:]))
                return
            }
            
            for doc in docs {
                
                let data = doc.data()
//                print(doc.documentID)
                guard let location = data["l"] else {continue}
//                print(location.append(12.44))
                guard let k = location as? [Double] else {continue}
                
                charitiesList[doc.documentID] = k
                
                
                
            }
            print(charitiesList)
            completion(.success(charitiesList))
        }
        
    }
}

