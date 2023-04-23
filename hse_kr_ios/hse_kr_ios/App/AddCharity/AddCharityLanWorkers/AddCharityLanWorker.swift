//
//  AddCharityLanWorker.swift
//  hse_kr_ios
//
//  Created by Al Stark on 10.04.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage



protocol AddCharityLanWorkable {
    func addCharity(name: String, description: String, qiwiLink: String, adress: [Double], imageData: Data, completion: @escaping (Result<Bool, Errors>) -> Void)
}

final class AddCharityLanWorker {
    
}

//MARK: AddCharityLanWorkable
extension AddCharityLanWorker: AddCharityLanWorkable {
    func addCharity(name: String, description: String, qiwiLink: String, adress: [Double], imageData: Data, completion: @escaping (Result<Bool, Errors>) -> Void) {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(.failure(.unknownError))
            return
        }
        
        let ref =  Firestore.firestore().collection("charities").document()
        let id = ref.documentID
        print(id)
        upload(photo: imageData, charityID: id) { result in
            switch result {
            case .success(let url):
                var data = [String : Any]()
                data = ["name": name, "description": description, "qiwiurl": qiwiLink, "creatorid": userID, "photourl": url.absoluteString] as [String : Any]
                ref.setData(data)
                if !adress.isEmpty {
                    data = ["l": adress]
                    let ref =  Firestore.firestore().collection("charitylocations").document(id).setData(data)
                }
                completion(.success(true))
            case .failure(let error):
                completion(.failure(Errors.unknownError))
            }
        }
        
    }
}

private extension AddCharityLanWorker {
    private func upload(photo: Data, charityID: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let ref = Storage.storage().reference().child("charities\(charityID)")
        ref.putData(photo) { metadata, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let metadata = metadata else {
                completion(.failure(error!))
                return
            }
            ref.downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
    }
}
