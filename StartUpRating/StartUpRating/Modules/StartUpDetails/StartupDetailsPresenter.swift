//
//  StartupDetailsPresenter.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 22/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation
import Apollo

protocol StartupDetailsView : class {
    func displayName(name: String)
    func displaySegment(segment: String)
    func displayDescription(description: String)
    func loadImage(image: UIImage)
}

protocol StartupDetailsPresenter {
    func viewDidLoad()
    
}

class StartupDetailsPresenterImplementation : StartupDetailsPresenter {
    
    fileprivate weak var view: StartupDetailsView?
    fileprivate let startup: StartupDetails
    
    init(view: StartupDetailsView, startup: StartupDetails) {
        self.view = view
        self.startup = startup
    }
    
    func viewDidLoad() {
        setupView()
    }
    
    func setupView() {
        self.view?.displayName(name: startup.name)
        self.view?.displaySegment(segment: startup.segment?.name ?? "")
        self.view?.displayDescription(description: startup.description)
        
        ImageUtils.load(url: URL(string: startup.imageUrl)!) { (image) in
            
            self.view?.loadImage(image: image)
        }
    }
    
}
