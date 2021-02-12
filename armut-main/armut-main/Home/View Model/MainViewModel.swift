//
//  HomeModel.swift
//  Sample Armut App
//
//  Created by BAhar on 12/02/2021.
//  Copyright © 2020 Bahar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let services : PublishSubject<[Services]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<HomeError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    
    public func requestServicesData(){
        
     //   self.loading.onNext(true)
        APIManager.requestData(url: Constants.servicesURL, method: .get, parameters: nil, completion: { (result) in
         //   self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                let services = returnJson.arrayValue.compactMap {
                    
                    return Services(data: try! $0.rawData())
                    
                }
                self.services.onNext(services)
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error.onNext(.internetError("Check your Internet connection."))
                case .authorizationError(let errorJson):
                    self.error.onNext(.serverMessage(errorJson["message"].stringValue))
                default:
                    self.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
        
    
    }
}

