//
//  SearchPlaceVM.swift
//  GoogleMaps
//
//  Created by Çağrı ÇOLAK on 1.01.2020.
//  Copyright © 2020 MW. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchPlaceVM {
    
    let searchText = BehaviorRelay(value: "")
    
    lazy var placesData: Driver<[PlaceModel]> = {
        return self.searchText.asObservable()
        .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .flatMapLatest(SearchPlaceVM.getPlaceData(searchText: ))
        .asDriver(onErrorJustReturn: [])
    }()
    
    static func getPlaceData(searchText:String) -> Observable<[PlaceModel]>{
        var apiController = APIController()
        let serviceController = ServiceController()
        let request = apiController.findPlace(with: searchText)
        return serviceController.getPlaceData(with: request)
    }
    
    
}
