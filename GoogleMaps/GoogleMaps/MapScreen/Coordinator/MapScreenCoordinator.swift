//
//  MapScreenCoordinator.swift
//  GoogleMaps-App
//
//  Created by Çağrı ÇOLAK on 1.01.2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit

class MapScreenCoordinator: BaseCoordinator {
    var childControllers = [BaseCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(with data:PlaceModel)  {
        let mapVC = MapScreenVC.instantiate()
        mapVC.mapScreenCoordinator = self
        mapVC.placeModel = data
        navigationController.pushViewController(mapVC, animated: true)
    }
}
