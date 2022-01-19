//
//  HomeViewController.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/29/19.
//  Copyright © 2019 Du. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: BaseViewController {
    
    //MARK:- variables
    var viewModel : HomeViewModel!
    let disposeBag = DisposeBag()
    
    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        bindViews()
        
        bindViewModelData()
        
        // getting data 
        viewModel.getData()
    }
    
    
    func bindViews(){
    
        // set colleciton view delehate to adjust cell width and height
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // handle collection view selections
        collectionView
            .rx
            .itemSelected
            .subscribe(onNext:{[weak self] indexPath in
                self?.viewModel.collectionViewCellSelected(indexPath: indexPath)
            }).disposed(by: disposeBag)
        
    }
    
    func bindViewModelData (){
        
        viewModel.data.asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: "HomeCollectionViewCell",cellType: HomeCollectionViewCell.self)) { row, data, cell in
                cell.data = data
            }.disposed(by: disposeBag)
        
        
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


extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 5) / 2 // compute your cell width
        return CGSize(width: cellWidth, height: 200)
    }
}
