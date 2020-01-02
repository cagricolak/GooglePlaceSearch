//
//  SearchPlaceCoordinator.swift
//  GoogleMaps-App
//
//  Created by Çağrı ÇOLAK on 1.01.2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit

class SearchPlaceCoordinator: BaseCoordinator {
    var childControllers = [BaseCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateTo()  {
        let searchScreen = SearchVC.instantiate()
        searchScreen.searchVCCoordiantor = self
        navigationController.pushViewController(searchScreen, animated: false)
    }
    
}
