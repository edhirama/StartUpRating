//
//  RatingModel.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 23/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation

struct RatingModel {
    var name: String
    var rating: Double
    var id: String
}

extension RatingModel {
    init?(dictionary: [String : Any], id: String) {
        guard  let name = dictionary["name"] as? String,
            let rating = dictionary["rating"] as? Double
            else { return nil }
        
        self.init(name: name, rating: rating, id: id)
    }
}
