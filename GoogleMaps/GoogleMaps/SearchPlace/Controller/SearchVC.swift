//
//  ViewController.swift
//  GoogleMaps
//
//  Created by Çağrı ÇOLAK on 30.12.2019.
//  Copyright © 2019 MW. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchVC: UIViewController, Storyboarded {
    weak var searchVCCoordiantor: SearchPlaceCoordinator?
    
    private var placesTableView: SearchTableView!
    private let searchPlaceVM = SearchPlaceVM()
    private let disposeBag = DisposeBag()
    
    var cellIdentifier: String {
        return placesTableView.cellIdentifier
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchTableView()
        configureSerchbar()
        bindSearchBar()
    }
    
}

extension SearchVC {
    private func configureSearchTableView() {
        placesTableView = SearchTableView(frame: CGRect.zero)
        placesTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(placesTableView)
        placesTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0))
        }
    }
    
    private func configureSerchbar() {
        placesTableView.searchBar.rx.text
            .filter{$0!.count > 2}
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { ($0 ?? "").lowercased() }
            .bind(to: searchPlaceVM.searchText)
            .disposed(by: disposeBag)
    }
    
    private func bindSearchBar() {
        searchPlaceVM.placesData
            .drive(placesTableView.rx.items(cellIdentifier: cellIdentifier)) {index, placeModel,cell in
                if placeModel.candidates.count > 0 {
                    cell.textLabel?.text = placeModel.candidates[index].name
                    cell.detailTextLabel?.text = placeModel.candidates[index].formatted_address
                }else {
                    cell.textLabel?.text = nil
                    cell.detailTextLabel?.text = nil
                }
            }.disposed(by: disposeBag)
        
        placesTableView.rx.modelSelected(PlaceModel.self).bind {[weak self] model in
            let mapCoordinator = MapScreenCoordinator(navigationController: (self?.navigationController)!)
            if model.candidates.count > 0 {
                mapCoordinator.navigate(with: model)
            }
            }.disposed(by: disposeBag)
}
}
