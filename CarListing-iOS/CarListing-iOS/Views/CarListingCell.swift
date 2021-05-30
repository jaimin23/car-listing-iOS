//
//  CarListingCell.swift
//  CarListing-iOS
//
//  Created by Jaimin Patel on 2021-05-27.
//

import UIKit

class CarListingCell: UITableViewCell {
    
    @IBOutlet weak var carInfoLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carInfoHStack: UIStackView!
    @IBOutlet weak var dealerPhoneNumber: UITextView!
    
    func configure(withCarListing carListing: CarListing) {

        var carYearMakeModel = ""
        if let year = carListing.carYear {
            carYearMakeModel += String(year)
        }
        if let model = carListing.carModel {
            carYearMakeModel += " \(model)"
        }
        if let make = carListing.carMake {
            carYearMakeModel += " \(make)"
        }
        carInfoLabel.text = carYearMakeModel
        setupCarInfoHStack(with: carListing.carPrice,
                           mileage: carListing.carMileage,
                           city: carListing.dealer?.city,
                           state: carListing.dealer?.state)

        dealerPhoneNumber.text = carListing.dealer?.phoneNumber

        if let imgURL =  carListing.carImages?.medium?[0],
           let url = URL(string: imgURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.carImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    private func setupCarInfoHStack(with price: Double?, mileage: Int?, city: String?, state: String?) {
        carInfoHStack.removeAllArrangedSubviews()
        if let price = price {
            carInfoHStack.addArrangedSubview(configureLabel(with: "$ \(String(price))"))
        }
        
        if let mileage = mileage {
            carInfoHStack.addArrangedSubview(configureLabel(with: "\(String(mileage)) Mi"))
        }
        
        var cityState = ""
        if let city = city {
            cityState += city
        }
        
        if let state = state {
            cityState += ", \(state)"
        }
        carInfoHStack.addArrangedSubview(configureLabel(with: cityState))
    }
    
    private func configureLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        label.numberOfLines = 0
        return label
    }
}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
