//
//  CriteriaRatings.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 25/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation


struct Criteria {
    var id: String
    var name: String
    var ratings: [StartupRatingModel?]?
}

extension Criteria {
    init?(dictionary: [String : Any], id: String) {
        guard  let name = dictionary["name"] as? String
            else { return nil }
        
        self.init(id: id, name: name, ratings: nil)
    }
}
