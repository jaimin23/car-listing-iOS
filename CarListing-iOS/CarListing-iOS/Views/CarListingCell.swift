//
//  CarListingCell.swift
//  CarListing-iOS
//
//  Created by Jaimin Patel on 2021-05-27.
//

import UIKit

class CarListingCell: UITableViewCell, UITextViewDelegate {
    
    private lazy var carImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var carInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14.0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var carMileageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cityStateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dealerNumberLabel: UITextView = {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        label.delegate = self
        label.isScrollEnabled = false
        label.isEditable = false
        label.dataDetectorTypes = .phoneNumber
        return label
    }()
    
    private lazy var hStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, carMileageLabel, cityStateLabel])
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 12.0
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var vStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [carImage, carInfoLabel, hStack, dealerNumberLabel])
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 8.0
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0).isActive = true
        vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0).isActive = true
    }
    
    func configure(withCarListing carListing: CarListing) {
        if let url = carListing.carImages?.medium?[0] {
            setImage(withUrl: url)
        }
        carInfoLabel.text = "\(carListing.carYear) \(carListing.carMake) \(carListing.carModel)"
        priceLabel.text = "$\(carListing.carPrice)"
        carMileageLabel.text = "\(carListing.carMileage) Mi"
        cityStateLabel.text = "\(carListing.dealer?.city), \(carListing.dealer?.state)"
        dealerNumberLabel.text = carListing.dealer?.phoneNumber
    }
    
    private func setImage(withUrl url: String) {
        if let url = URL(string: url) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.carImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }

}
