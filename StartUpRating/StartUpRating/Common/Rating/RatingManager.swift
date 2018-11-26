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
    
    static func getTopPitchRatings(completion: @escaping (_ ratings: [StartupRatingModel]) -> ()) {
    
        getRatings(path: FirestorePaths.pitchRatings) { (ratings) in
            completion(ratings)
        }
    }
    
    static func getTopProposalRatings(completion: @escaping (_ ratings: [StartupRatingModel]) -> ()) {
        getRatings(path: FirestorePaths.proposalRatings) { (ratings) in
            completion(ratings)
        }
    }
    
    static func getTopDevelopmentRatings(completion: @escaping (_ ratings: [StartupRatingModel]) -> ()) {
        getRatings(path: FirestorePaths.developmentRatings) { (ratings) in
            completion(ratings)
        }
    }
    
    static func getRatings(path: String, completion: @escaping (_ ratings: [StartupRatingModel]) -> ()) {
        let query = Firestore.firestore().collection(path).limit(to: 3).order(by: "rating", descending: true)
        query.addSnapshotListener({ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("error")
                return
            }
            
            let topRatings = snapshot.documents.map({ (document) -> StartupRatingModel in
                if let rating = StartupRatingModel(dictionary: document.data(), id: document.documentID) {
                    return rating
                } else {
                    fatalError("Unable to initialize RatingModel")
                }
            })
            completion(topRatings)
            
        })
    }
    
    
}
