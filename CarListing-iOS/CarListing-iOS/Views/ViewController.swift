//
//  ViewController.swift
//  CarListing-iOS
//
//  Created by Jaimin Patel on 2021-05-26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var carListingTableView: UITableView!
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private var viewModel: CarListingViewModel = CarListingViewModel(serviceProvider: ServiceProvider<CarListingService>())
    private var carListings: [CarListing] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        carListingTableView.dataSource = self
        carListingTableView.delegate = self
        activityIndicator.startAnimating()
        viewModel.viewReady { result, error in
            if let error = error {
                print(error)
                //TODO: Handle error scenario
            }
            
            if let result = result {
                if result.count > 0 {
                    self.carListings = result
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.carListingTableView.reloadData()
                        self.carListingTableView.isHidden = false
                    }
                } else {
                    //TODO: Handle empty result scenario
                }
            }
        }
    }
    
    private func setupView() {
        view.addSubview(carListingTableView)
        view.addSubview(activityIndicator)
        
        carListingTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        carListingTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        carListingTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        carListingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "carListingCell") as? CarListingCell else {
            fatalError("Cell Could not be created")
        }
        let carListing = carListings[indexPath.row]
        cell.configure(withCarListing: carListing)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

