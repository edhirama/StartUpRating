//
//  StartUpModel.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 21/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation

struct StartUpModel {
    
    let name: String
    let segment: String
    let imageURL: String
    var pitchRatingCount: Int
    var pitchRating: Double
    var proposalRatingCount: Int
    var proposalRating: Double
    var developmentRatingCount: Int
    var developmentRating: Double
    
    
    func getRating(type: RatingType) -> Double {
        switch type {
        case .proposalRating:
            return proposalRating
        case .pitchRating:
            return pitchRating
        case .developmentRating:
            return developmentRating
        }
    }
}

extension StartUpModel {
    init?(dictionary: [String : Any]) {
        guard  let name = dictionary["name"] as? String,
               let segment = dictionary["segment"] as? String,
                let imageURL = dictionary["imageURL"] as? String,
                let pitchRatingCount = dictionary["pitchRatingCount"] as? Int,
                let proposalRatingCount = dictionary["proposalRatingCount"] as? Int,
                let developmentRatingCount = dictionary["developmentRatingCount"] as? Int,
                let pitchRating = dictionary["pitchRating"] as? Double,
                let proposalRating = dictionary["proposalRating"] as? Double,
                let developmentRating = dictionary["developmentRating"] as? Double
            else { return nil }
        self.init(name: name, segment: segment, imageURL: imageURL, pitchRatingCount: pitchRatingCount, pitchRating: pitchRating, proposalRatingCount: proposalRatingCount, proposalRating: proposalRating, developmentRatingCount: developmentRatingCount, developmentRating: developmentRating)
    }
    
}
