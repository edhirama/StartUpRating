//
//  StartupsListPresenter.swift
//  StartupRating
//
//  Created by Edgar Hirama on 21/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation
import Apollo

protocol StartupListView : class {
    func refreshStartupListView()
    func showLoadingView(_ show: Bool)
    func showErrorView(_ show: Bool)
}

protocol StartupListCellView {
    func displayName(name: String)
    func displaySegment(segment: String)
    func displayImage(image: UIImage)
}

protocol StartupListPresenter {
    var router: StartupsListRouter { get }
    var numberOfStartups: Int { get }
    func viewDidLoad()
    func refresh()
    func configure(cell: StartupListCellView, forRow row: Int)
    func didSelect(row: Int)
}

class StartupListPresenterImplementation: StartupListPresenter {
    
    fileprivate weak var view: StartupListView?
    var numberOfStartups: Int {
        return startups?.count ?? 0
    }
    
    func viewDidLoad() {
        loadStartups()
    }
    
    func refresh() {
        loadStartups()
    }
    
    func loadStartups() {
        self.view?.showLoadingView(true)
        let apolloClient = ApolloClient.init(url: URL(string: URLConstants.apollo)!)
        apolloClient.fetch(query: GetAllStartupsQuery()) { [weak self] (result, error) in
            guard let startups = result?.data?.allStartups else {
                self?.showErrorView(true)
                return
            }
            
            if error == nil {
                self?.startups = startups.map({ (startup) -> StartupDetails? in
                    return startup?.fragments.startupDetails
                })
                self?.setView()
            } else {
                self?.showErrorView(true)
            }
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
    weak private var startupView: StartupListView?
    internal let router: StartupsListRouter
    
    init(view: StartupListView, router: StartupsListRouter) {
        self.view = view
        self.router = router
    }
    
    func setView() {
        self.view?.refreshStartupListView()
        self.view?.showLoadingView(false)
        self.view?.showErrorView(false)
    }
    
    func showErrorView(_ show: Bool) {
        self.view?.showErrorView(show)
    }
}
