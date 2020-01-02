//
//  MapScreenVC.swift
//  GoogleMaps
//
//  Created by Çağrı ÇOLAK on 1.01.2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import RxSwift
import RxGoogleMaps
import GoogleMaps
import SnapKit

class MapScreenVC: UIViewController, Storyboarded {
    weak var mapScreenCoordinator: MapScreenCoordinator?
    var placeModel:PlaceModel?
    private var mapView: PlaceMapView!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePlaceMapView()
        bindDataToPlaceMapView()
    }
    
    fileprivate func bindDataToPlaceMapView() {
        guard let placeModelData = placeModel else { return }
        let mapVM = MapScreenVM(mapData: placeModelData)
        mapView.mapVM = mapVM
        self.navigationItem.title = mapVM.markerTitle
        mapView.rx.handleTapMarker { [weak self](_) -> (Bool) in
            let placeDetailCoordinator = PlaceDetailCoordinator(navigationController: (self?.navigationController)!)
            placeDetailCoordinator.navigate(with: placeModelData)
            return true
        }
        
    }
    
    
    fileprivate func configurePlaceMapView() {
        mapView = PlaceMapView(frame: CGRect.zero)
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
