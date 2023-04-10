//
//  AddCharityLanWorker.swift
//  hse_kr_ios
//
//  Created by Al Stark on 10.04.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore



protocol AddCharityLanWorkable {
    func addCharity(name: String, description: String, qiwiLink: String, adress: [Double], completion: @escaping (Result<Bool, Errors>) -> Void)
}

final class AddCharityLanWorker {
    
}

//MARK: AddCharityLanWorkable
extension AddCharityLanWorker: AddCharityLanWorkable {
    func addCharity(name: String, description: String, qiwiLink: String, adress: [Double], completion: @escaping (Result<Bool, Errors>) -> Void) {
        //        let ref = firestore.collection(myCollection).document()
        //        // ref is a DocumentReference
        //        let id = ref.documentID
        //        // id contains the random ID
        //        ref.setData(...)
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(.failure(.unknownError))
            return
        }
        var data = [String : Any]()
        data = ["name": name, "description": description, "qiwiurl": qiwiLink, "creatorid": userID] as [String : Any]
        let ref =  Firestore.firestore().collection("charities").document()
        let id = ref.documentID
        print(id)
        ref.setData(data)
        if !adress.isEmpty {
            data = ["l": adress]
            let ref =  Firestore.firestore().collection("charitylocations").document(id).setData(data)
        }
        completion(.success(true))
    }
}
