//
//  RankingHeaderView.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 25/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import UIKit

class RankingHeaderView: UITableViewHeaderFooterView, Reusable, NibLoadableView, CriteriaHeaderView {
  
    @IBOutlet weak var nameLabel: UILabel!
    
    func displayCriteria(criteriaName: String) {
        nameLabel.text = criteriaName
    }
    

}
