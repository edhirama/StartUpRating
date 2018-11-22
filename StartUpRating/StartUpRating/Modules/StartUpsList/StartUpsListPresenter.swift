//
//  StartUpsListPresenter.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 21/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation
import Apollo

protocol StartUpListView : class {
    func refreshStartUpListView()
    func displayStartUpsRetrievalError(title: String, message: String)
}

protocol StartupListCellView {
    func displayName(name: String)
    func displaySegment(segment: String)
    func displayImage(image: UIImage)
}

protocol StartUpListPresenter {
    var router: StartUpsListRouter { get }
    var numberOfStartups: Int { get }
    func viewDidLoad()
    func configure(cell: StartupListCellView, forRow row: Int)
    func didSelect(row: Int)
}

class StartUpListPresenterImplementation: StartUpListPresenter {
    
    fileprivate weak var view: StartUpListView?
    var numberOfStartups: Int {
        return startups?.count ?? 0
    }
    
    func viewDidLoad() {
        let apolloClient = ApolloClient.init(url: URL(string: URLConstants.apollo)!)
        apolloClient.fetch(query: GetAllStartupsQuery()) { [weak self] (result, error) in
            guard let startups = result?.data?.allStartups else {
                self?.setErrorView()
                return
            }
            
            self?.startups = startups.map({ (startup) -> StartupDetails? in
                return startup?.fragments.startupDetails
            })
            self?.setView()
        }
    }
    
    func configure(cell: StartupListCellView, forRow row: Int) {
        if let startup = self.startups?[row] {
            cell.displayName(name: startup.name)
            cell.displaySegment(segment: startup.segment?.name ?? "")
            ImageUtils.load(url: URL(string: startup.imageUrl)!) { (image) in
                    cell.displayImage(image: image)
            }
        } else {
            
        }
        
    }
    
    
    func didSelect(row: Int) {
        if let startup = startups?[row] {
            self.router.presentDetailsView(forStartup: startup)
        }
    }
    
    
    var startups : [StartupDetails?]?
    weak private var startupView: StartUpListView?
    internal let router: StartUpsListRouter
    
    init(view: StartUpListView, router: StartUpsListRouter) {
        self.view = view
        self.router = router
    }
    
    func setView() {
        self.view?.refreshStartUpListView()
    }
    
    func setErrorView() {
        //TODO
    }
}
