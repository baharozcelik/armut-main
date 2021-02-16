//
//  ServiceDetailViewModel.swift
//  armut-main
//
//  Created by Bahar on 14.02.2021.
//

import Foundation

protocol ServiceDetailViewModelDelegate: class {
    func onDetailsOnSuccess()
    func getDetailsOnError()
    
}

protocol ServiceDetailViewModelProtocol {
    func getImageUrl() -> String
    func getTitleLabel() -> String
    func getProLabel() -> String
    func getAvarageLabel() -> String
    func getCompletedJobsLabel() -> String
    

}

class ServiceDetailViewModel: ServiceDetailViewModelProtocol {
    
    private var mainModel: ServiceDetailMainModel?
    
    private var serviceDetails: Details?
    
    weak var delegate: ServiceDetailViewModelDelegate?
    
    init(delegate: ServiceDetailViewModelDelegate?,
         serviceId: String) {
        self.delegate = delegate
        mainModel = ServiceDetailMainModel(delegate: self)
        mainModel?.getDetails(serviceId: serviceId)
    }
    
    func getImageUrl() -> String {
        guard let imageURL = serviceDetails?.imageURL else { return "" }
        return imageURL
    }
    
    func getTitleLabel() -> String {
        guard let title = serviceDetails?.name else { return "" }
        return title
    }
    
    func getProLabel() -> String {
        guard let pro = serviceDetails?.proCount else { return "" } //
        return "\(pro)"
    }
    func getAvarageLabel() -> String {
        guard let avarage = serviceDetails?.averageRating else { return "" } //
        return "\(avarage)"
    }
    
    func getCompletedJobsLabel() -> String {
        guard let completedJobs = serviceDetails?.completedJobsOnLastMonth else { return ""
            
        }
        return "\(completedJobs)"
    }
    
}

extension ServiceDetailViewModel: ServiceDetailMainModeDelegate {
    func getDetailsOnSuccess(serviceDetails: Details) {
        self.serviceDetails = serviceDetails
        self.delegate?.onDetailsOnSuccess()
    }
    
    func getDetailsOnError() {
        self.delegate?.getDetailsOnError()
    }
}
