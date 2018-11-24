//
//  RatingManager.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 23/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct StartupRating {
    var name: String
    var averageRating: Double
    
    var dictionary: [String: Any] {
        return ["name": name,
                "averageRating": averageRating
        ]
    }
}

extension StartupRating {
    init?(dictionary: [String: Any], id: String) {
        guard let name = dictionary["name"] as? String,
            let averageRating = dictionary["averageRating"] as? Double else { return nil }
        
        self.init(name: name, averageRating: averageRating)
    }
}

class RatingManager {
    
    
    static func getTopPitchRatings(completion: @escaping (_ ratings: [RatingModel]) -> ()) {
        
        let query = Firestore.firestore().collection("pitchRatings").limit(to: 3).order(by: "rating", descending: true)
        query.addSnapshotListener({ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("error")
                return
            }
            
            let topRatings = snapshot.documents.map({ (document) -> RatingModel in
                if let rating = RatingModel(dictionary: document.data(), id: document.documentID) {
                    return rating
                } else {
                    fatalError("Unable to initialize RatingModel")
                }
            })
            completion(topRatings)
            
        })
    }
    
    
}
