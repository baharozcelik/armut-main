//
//  Services.swift
//  armut-main
//
//  Created by Bahar on 12.02.2021.
//

import Foundation
struct Services: Codable {
    let id, serviceID: Int
    let name, longName: String
    let imageURL: String
    let proCount: Int
    let averageRating: Double?
    let completedJobsOnLastMonth: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case name
        case longName = "long_name"
        case imageURL = "image_url"
        case proCount = "pro_count"
        case averageRating = "average_rating"
        case completedJobsOnLastMonth = "completed_jobs_on_last_month"
    }
}
extension Services {
    
    init?(data: Data) {
        
        guard let me = try? JSONDecoder().decode(Services.self, from: data)
            
            else {
                
                return nil
        }
        self = me
    }
}
