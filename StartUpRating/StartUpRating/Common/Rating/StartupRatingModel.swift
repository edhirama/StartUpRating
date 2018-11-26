//
//  RatingModel.swift
//  StartupRating
//
//  Created by Edgar Hirama on 23/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation

struct StartupRatingModel {
    var name: String
    var rating: Double
    var id: String
}

extension StartupRatingModel {
    init?(dictionary: [String : Any], id: String) {
        guard  let name = dictionary["name"] as? String,
            let rating = dictionary["rating"] as? Double
            else { return nil }
        
        self.init(name: name, rating: rating, id: id)
    }
}
