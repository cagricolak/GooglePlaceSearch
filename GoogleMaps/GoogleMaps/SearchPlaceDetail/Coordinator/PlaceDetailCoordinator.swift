//
//  PlaceDetailCoordinator.swift
//  GoogleMaps-App
//
//  Created by Çağrı ÇOLAK on 2.01.2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit

class PlaceDetailCoordinator: BaseCoordinator {
    var childControllers = [BaseCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(with data:PlaceModel)  {
        let placeDetail = SearchPlaceDetailVC.instantiate()
        placeDetail.placeDetailCoordinator = self
        placeDetail.placeModel = data
        navigationController.pushViewController(placeDetail, animated: true)
    }
}
