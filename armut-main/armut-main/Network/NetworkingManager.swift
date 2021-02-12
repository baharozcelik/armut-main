//
//  NetworkingManager.swift
//  armut-test
//
//  Created by Bahar on 12.02.2021.
//

import Foundation
import Alamofire

// https://my-json-server.typicode.com/engincancan/case/home

struct ArmutHomeURL{
    static let scheme = "https"
    static let host = "my-json-server.typicode.com"
    static let path = "/engincancan/case/home"
}

struct ArmutDetailURL {
    static let scheme = "https"
    static let host = "my-json-server.typicode.com"
    static let path = "/engincancan/case/service/"
}

class NetworkingManager{
    
    public static func getHomeList(completion : @escaping ((_ home : Home?) -> Void) ){
        var urlComponents = URLComponents()
        
        urlComponents.scheme = ArmutHomeURL.scheme
        urlComponents.host = ArmutHomeURL.host
        urlComponents.path = ArmutHomeURL.path
        
        
        guard let url = urlComponents.url else { return }
        
        AF.request("\(url)",method: .get)
            .validate()
            .responseDecodable(of: Home.self) { response in
                completion(response.value)
            }
    }
    
    public static func getServiceDetails(id: String, completion : @escaping ((_ home : Details?) -> Void) ){
        var urlComponents = URLComponents()
        
        urlComponents.scheme = ArmutDetailURL.scheme
        urlComponents.host = ArmutDetailURL.host
        urlComponents.path = ArmutDetailURL.path
        
        urlComponents.path.append(id)
        
        guard let url = urlComponents.url else { return }
        
        AF.request("\(url)",method: .get)
            .validate()
            .responseDecodable(of: Details.self) { response in
                completion(response.value)
            }
    }
    
}
