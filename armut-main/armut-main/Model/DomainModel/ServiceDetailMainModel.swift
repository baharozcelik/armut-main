//
//  ServiceDetailMainModel.swift
//  armut-main
//
//  Created by Bahar on 14.02.2021.
//

import Foundation

protocol ServiceDetailMainModeDelegate: class {
    func getDetailsOnSuccess(serviceDetails: Details)
    func getDetailsOnError()
}

protocol ServiceDetailMainModelProtocol {
    func getDetails(serviceId: String)
}

class ServiceDetailMainModel: ServiceDetailMainModelProtocol {
    
    weak var delegate: ServiceDetailMainModeDelegate?
    
    init(delegate: ServiceDetailMainModeDelegate?){
        self.delegate = delegate
    }
    
    func getDetails(serviceId: String){
        NetworkingManager.getServiceDetails(id: serviceId, onSuccess: { serviceDetails in
            guard let serviceDetails = serviceDetails else { return }
            self.delegate?.getDetailsOnSuccess(serviceDetails: serviceDetails)
        }, onError: {
            self.delegate?.getDetailsOnError()
        })
    }
}
