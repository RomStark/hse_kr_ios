//
//  AppLanWorker.swift
//  hse_kr_ios
//
//  Created by Al Stark on 04.04.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol AppLanWorkable {
    func signOut()
    func getCharitydata(completion: @escaping (Result<[Charity], Error>) -> Void)
    func uploadImageData(url: String?, completion: @escaping (Data?) -> Void)
}

final class AppLanWorker {
    
}

extension AppLanWorker: AppLanWorkable {
    func uploadImageData(url: String?, completion: @escaping (Data?) -> Void) {
        guard let urlString = url,
              let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
    }
    func getCharitydata(completion: @escaping (Result<[Charity], Error>) -> Void) {
        Firestore.firestore().collection("charities").getDocuments { query, error in
            if let error = error {
                completion(.failure(error))
            }
            var charitiesList = [Charity]()
            guard let docs = query?.documents else {
                completion(.success([]))
                return
            }
            for doc in docs {
                let data = doc.data()
                //                charitiesList.append(JSONDecoder().decode(Charity.self, from: data))
                let charity = Charity(
                    creatorID: data["creatorid"] as? String ?? "creatorID",
                    name: data["name"] as? String ?? "name",
                    description: data["description"] as? String ?? "description",
                    photoURL: data["photourl"] as? String,
                    latitude: data["latitude"] as? Double,
                    longitude: data["longitude"] as? Double,
                    art: data["art"] as? Bool ?? false,
                    children: data["children"] as? Bool ?? false,
                    education: data["education"] as? Bool ?? false,
                    healthcare: data["healthcare"]as? Bool ?? false,
                    poverty: data["poverty"] as? Bool ?? false,
                    scienceResearch: data["science&research"] as? Bool ?? false,
                    qiwiURL: data["qiwiurl"] as? String
                )
//                self?.uploadImageData(url: charity.photoURL) { data in
//                    charity.data = data
//                }
                charitiesList.append(charity)
            }
            completion(.success(charitiesList))
        }
        
    }
    
    func signOut() {
        do {
            try? Auth.auth().signOut()
        }
    }
    
}
