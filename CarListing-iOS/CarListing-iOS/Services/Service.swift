//
//  Service.swift
//  CarListing-iOS
//
//  Created by Jaimin Patel on 2021-05-27.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Service {
    var baseURL: String { get }
    var endpointPath: String { get }
    var parameters: [String: String]? { get }
    var requestType: RequestType { get }
}

extension Service {
    /**
    Build proper URL based on the information found in service and according to the type of request
    */
   private var url: URL? {
       var urlComponents = URLComponents(string: baseURL)
       urlComponents?.path = endpointPath
       switch requestType {
       case .get:
        if let parameters = parameters {
               urlComponents?.queryItems = parameters.map({ item in
                   URLQueryItem(name: item.key, value: item.value)
               })
           }
       default: break
       }
       
       return urlComponents?.url
   }
   
   /**
    create urlRequest based on the information found in protocol
    */
   public var urlRequest: URLRequest {
       guard let url = self.url else {
           fatalError("Error occured while creating URL")
       }
       
       var request = URLRequest(url: url)
       request.httpMethod = requestType.rawValue
       
       return request
   }
}
