//
//  Service.swift
//  armut-test
//
//  Created by Amer Atia on 12.02.2021.
//

import Foundation

struct Service: Codable {
    let id, serviceID: Int?
    let name, longName: String?
    let imageURL: String?
    let proCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case name
        case longName = "long_name"
        case imageURL = "image_url"
        case proCount = "pro_count"
    }
}
