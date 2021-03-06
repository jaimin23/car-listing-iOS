//
//  CarListingViewModel.swift
//  CarListing-iOS
//
//  Created by Jaimin Patel on 2021-05-27.
//

import Foundation

class CarListingViewModel {
    
    private var serviceProvider: ServiceProvider<CarListingService>
    
    init(serviceProvider: ServiceProvider<CarListingService>) {
        self.serviceProvider = serviceProvider
    }
    
    func viewReady(completion: @escaping ([CarListing]?, APIServiceError?) -> Void) {
        serviceProvider.load(service: .getCarListings, decodeType: CarListingResult.self) { result in
            switch result {
            case .success(let result):
                completion(result.listings, nil)
            case .failure(let error):
                print(error)
                completion(nil, error)
            case .empty:
                completion([], nil)
            }
        }
    }
}
