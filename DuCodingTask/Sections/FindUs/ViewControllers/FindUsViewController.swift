//
//  FindUsViewController.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/30/19.
//  Copyright © 2019 Du. All rights reserved.
//

import UIKit
import RxSwift
import CoreLocation
import MapKit

class FindUsViewController: BaseViewController {
    
    //MARK:- variables
    var viewModel : FindUsViewModel!
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    
    var currentLocation : CLLocation?
    
    var homePayLoad:HomePayLoad!
    
    
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()

        bindViews()
        
        bindViewModelData()
        
        /// Setup CLLocationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    func bindViews(){
        // handle tableView view selections
        tableView
            .rx
            .itemSelected
            .subscribe(onNext:{[weak self] indexPath in
                self?.viewModel.shopSelectedAtIndex(indexPath: indexPath,currentLocation: self?.currentLocation)
            }).disposed(by: disposeBag)
        
        searchTxt.rx.text.bind(to: viewModel.searchText).disposed(by: disposeBag)

    }
    
    func bindViewModelData (){
        
        // bind list to tabkeView
        viewModel.data.asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: "ShopTableViewCell",cellType: ShopTableViewCell.self)) { row, data, cell in
                cell.data = data
            }.disposed(by: disposeBag)
        
        // bind annotations to mapView
        viewModel.mapAnnotation.subscribe({[weak self] annotation in
            self?.mapView.addAnnotations(annotation.element ?? [])
        }).disposed(by: disposeBag)
        
        // Loading
        viewModel.isLoading.asObservable()
            .skip(1)
            .bind { [weak self] isLoading in
                self?.showLoading(show:isLoading)
            }.disposed(by: disposeBag)
        
        // errors
        viewModel.errorValue.asObservable()
            .skip(1)
            .bind {  [weak self] errorMessage in
                self?.showError(message: errorMessage)
            }.disposed(by: disposeBag)
        
    }
    
}


extension FindUsViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        self.locationManager.stopUpdatingLocation()
        
        if self.currentLocation == nil {
            
            self.currentLocation = location
            
            // set MapView Center Location
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                      latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(coordinateRegion, animated: true)
            
            // get du shops ordered by nearest to current location
            self.viewModel.getNearestShopOrderedBy(currentLocation: location)
        }
        
    }
}
