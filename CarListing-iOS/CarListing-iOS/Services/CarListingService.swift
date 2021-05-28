//
//  CarListingService.swift
//  CarListing-iOS
//
//  Created by Jaimin Patel on 2021-05-27.
//

import Foundation

enum CarListingService {
    case getCarListings
}

extension CarListingService: Service {
    var baseURL: String {
        return "https://carfax-for-consumers.firebaseio.com"
    }
    
    var endpointPath: String {
        switch self {
        case .getCarListings:
            return "/assignment.json"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .getCarListings:
            return nil
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .getCarListings:
            return .get
        }
    }
    
    
}

