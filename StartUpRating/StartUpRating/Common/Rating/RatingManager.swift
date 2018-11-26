//
//  RatingManager.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 23/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum RatingType: String {
    case proposalRating = "proposalRating"
    case pitchRating = "pitchRating"
    case developmentRating = "developmentRating"
}

class RatingManager {
    
    static var criterias : [String] = ["Proposta", "Apresentação/Pitch", "Desenvolvimento"]
    
    //MARK: Read
    
    static func getTopPitchRatings(completion: @escaping (_ startups: [StartUpModel]) -> ()) {
    
        getRatings(ratingType: .pitchRating) { (startups) in
            completion(startups)
        }
    }
    
    static func getTopProposalRatings(completion: @escaping (_ startups: [StartUpModel]) -> ()) {
        getRatings(ratingType: .proposalRating) { (startups) in
            completion(startups)
        }
    }
    
    static func getTopDevelopmentRatings(completion: @escaping (_ startups: [StartUpModel]) -> ()) {
        getRatings(ratingType: .developmentRating) { (startups) in
            completion(startups)
        }
    }
    
    static func getRatings(ratingType: RatingType, completion: @escaping (_ startups: [StartUpModel]) -> ()) {
        let query = Firestore.firestore().collection(FirestorePaths.root).limit(to: 3).order(by: ratingType.rawValue, descending: true)
        query.addSnapshotListener({ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("error")
                return
            }
            
            let topStartups = snapshot.documents.map({ (document) -> StartUpModel in
                if let startup = StartUpModel(dictionary: document.data()) {
                    return startup
                } else {
                    fatalError("Unable to initialize RatingModel")
                }
            })
            completion(topStartups)
            
        })
    }
    
    static private func documentExists(transaction: Transaction, ratingReference: DocumentReference, completion: (_ exists: Bool, _ existingRating: Double?) -> () ) {
        let document: DocumentSnapshot
        let existingRating: Double?
        do {
            try document = transaction.getDocument(ratingReference)
            existingRating = document.data()?["rating"] as? Double
            completion(true, existingRating)
        } catch _ as NSError {
            completion(false, nil)
        }
    }
    
    //MARK: Write
    
    static func addRating(startup: StartupDetails, ratingType: RatingType, rating: Double) {
        let db = Firestore.firestore()
        let rootReference = db.collection(FirestorePaths.root)
        let startupReference = rootReference.document(startup.name)
        startupReference.getDocument { (document, error) in
            if let document = document, document.exists {
                self.runTransactions(startupName: startup.name, ratingType: ratingType, rating: rating)
            } else {
                rootReference.document(startup.name).setData(["name": startup.name,
                                                               "segment": startup.segment?.name ?? "",
                                                               "imageURL": startup.imageUrl,
                                                               "pitchRatingCount": 0,
                                                               "pitchRating": 0,
                                                               "proposalRatingCount": 0,
                                                               "proposalRating": 0,
                                                               "developmentRatingCount": 0,
                                                               "developmentRating": 0], completion: { (error) in
                                                                if error != nil {
                                                                    print("error creating startup \(startup.name) document")
                                                                } else {
                                                                    self.runTransactions(startupName: startup.name, ratingType: ratingType, rating: rating)
                                                                }
                })
            }
        }
    }
    

    
    static private func runTransactions(startupName: String, ratingType: RatingType, rating: Double) {
        let db = Firestore.firestore()
        let rootReference = db.collection(FirestorePaths.root)
        let startupReference = rootReference.document(startupName)
        
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let startupSnapshot: DocumentSnapshot
            do {
                try startupSnapshot = transaction.getDocument(startupReference)
            } catch  let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            
            let startupModel: StartUpModel
            if let data = startupSnapshot.data(), let startupModelInit = StartUpModel(dictionary: data) {
                startupModel = startupModelInit
            } else {
                print("error retrieving startup data")
                return nil
            }
            
            
            let ratingReference = Firestore.firestore().collection("\(FirestorePaths.root)/\(startupModel.name)/\(ratingType.rawValue)").document(UIDevice.current.identifierForVendor?.uuidString ?? "123")
         
            self.documentExists(transaction: transaction, ratingReference: ratingReference, completion: { (exists, existingRating) in
            
                 transaction.setData(["uuid": UIDevice.current.identifierForVendor?.uuidString ?? "123",
                                     "rating": rating], forDocument: ratingReference)
                
                let currentAverage: Double
                let ratingCount: Int
                switch (ratingType) {
                case .developmentRating:
                    currentAverage = startupModel.developmentRating
                    ratingCount = startupModel.developmentRatingCount
                    break
                case .proposalRating:
                    currentAverage = startupModel.proposalRating
                    ratingCount = startupModel.proposalRatingCount
                    break
                case .pitchRating:
                    currentAverage = startupModel.pitchRating
                    ratingCount = startupModel.pitchRatingCount
                    break
                }
                
                let rating = updateAverageRating(ratingCount: ratingCount, currentAverage: currentAverage, rating: rating, previousRating: existingRating)
                
                transaction.setData(["\(ratingType.rawValue)Count" : rating.ratingCount,
                                     ratingType.rawValue : rating.averageRating],
                                    forDocument: startupReference, merge: true)
          
            })
          
            return nil
        }) { (object, error) in
            if error != nil {
                print("error reading database reference")
            }
        }
    }
    
    static private func updateAverageRating(ratingCount: Int, currentAverage: Double, rating: Double, previousRating: Double? = nil ) -> ( averageRating: Double, ratingCount: Int) {
        if let previousRating = previousRating {
            print(previousRating)
            print(ratingCount)
            print(currentAverage)
            return ((Double(ratingCount) * currentAverage + (rating - previousRating)) / Double (ratingCount), ratingCount)
        } else {
            return ((Double(ratingCount) * currentAverage + rating) / Double(ratingCount + 1), ratingCount + 1)
        }
    }
    

}
