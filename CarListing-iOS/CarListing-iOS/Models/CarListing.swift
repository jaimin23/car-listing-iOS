//
//  CarListing.swift
//  CarListing-iOS
//
//  Created by Jaimin Patel on 2021-05-26.
//

import Foundation


struct CarListingResult: Codable {
    let listings: [CarListing]?
}

struct CarListing: Codable {
    let id: String?
    let dealer: Dealer?
    let carMake: String?
    let carModel: String?
    let carImages: CarImages?
    let carPrice: Double?
    let carYear: Int?
    let carMileage: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, dealer
        case carMake = "make"
        case carModel = "model"
        case carImages = "images"
        case carPrice = "currentPrice"
        case carYear = "year"
        case carMileage = "mileage"
    }
}

struct Dealer: Codable {
    let city: String?
    let state: String?
    let phoneNumber: String?
    
    private enum CodingKeys: String, CodingKey {
        case city, state
        case phoneNumber = "phone"
    }
}

struct CarImages: Codable {
    let medium: [String]?
}
