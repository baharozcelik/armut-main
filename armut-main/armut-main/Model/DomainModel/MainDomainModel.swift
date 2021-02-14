//
//  MainDomainModel.swift
//  armut-main
//
//  Created by Bahar on 13.02.2021.
//

import Foundation

protocol MainDomainModelDelegate: class {
    func getHomeListOnSuccess(home: Home)
    func getHomeListOnError()
}

protocol MainDomainModelProtocol {
    func getHomeList()
}

class MainDomainModel: MainDomainModelProtocol {
    
    weak var delegate: MainDomainModelDelegate?
    
    init(delegate: MainDomainModelDelegate?){
        self.delegate = delegate
    }
    
    func getHomeList(){
        NetworkingManager.getHomeList(onSuccess: { [weak self] home in
            guard let self = self,
                  let home = home else { return }
            
            self.delegate?.getHomeListOnSuccess(home: home)
        }, onError: {
            self.delegate?.getHomeListOnError()
        })
    }
}
