//
//  MainViewModel.swift
//  armut-main
//
//  Created by Bahar on 14.02.2021.
//

import Foundation

protocol MainViewModelDelegate: class {
    func getHomeOnSuccess()
    func getHomeListOnError()
}


protocol MainViewModelProtocol {
    func getOtherlist() -> [Service]
    func getTrending() -> [Service]
    func getPosts() -> [Post]
    func getHomeList()
}

class MainViewModel: MainViewModelProtocol {
    
    private var mainModel: MainDomainModel?
    
    weak var delegate: MainViewModelDelegate?
    
    private var homeList: Home?
    
    init(delegate: MainViewModelDelegate?) {
        self.delegate = delegate
        mainModel = MainDomainModel(delegate: self)
        mainModel?.getHomeList()
    }
    
    func getOtherlist() -> [Service] {
        guard let otherList = homeList?.other else { return [] }
        return otherList
    }
    
    func getTrending() -> [Service] {
        guard let trendingList = homeList?.trending else { return [] }
        return trendingList
    }
    
    func getPosts() -> [Post] {
        guard let postsList = homeList?.posts else { return [] }
        return postsList
    }
    
    func getHomeList() {
        mainModel?.getHomeList()
    }
}

extension MainViewModel: MainDomainModelDelegate {
    func getHomeListOnSuccess(home: Home) {
        homeList = home
        delegate?.getHomeOnSuccess()
    }
    
    func getHomeListOnError() {
        delegate?.getHomeListOnError()

    }
}

