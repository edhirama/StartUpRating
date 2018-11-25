//
//  RatingManager.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 23/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation
import FirebaseFirestore

class RatingManager {
    
    static func getCriterias(completion: @escaping (_ criterias: [Criteria]) -> ()) {
        
        let query = Firestore.firestore().collection(FirestorePaths.root)
        query.addSnapshotListener({ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("error")
                return
            }
            
            let criterias = snapshot.documents.map({ (document) -> Criteria in
                if let criteria = Criteria(dictionary: document.data(), id: document.documentID) {
                    return criteria
                } else {
                    fatalError("Unable to initialize RatingModel")
                }
            })
            completion(criterias)
            
        })
    }
    
}
