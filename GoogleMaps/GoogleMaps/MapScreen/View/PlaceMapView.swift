//
//  PlaceMapView.swift
//  GoogleMaps-App
//
//  Created by Çağrı ÇOLAK on 2.01.2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceMapView: GMSMapView {
    
    var mapVM: MapScreenVM! {
        didSet {
            let marker = GMSMarker(position: self.mapVM.center)
            marker.title = self.mapVM.markerTitle
            marker.map = self
            
            let circle = GMSCircle()
            circle.radius = 1000
            circle.position = self.mapVM.center
            circle.fillColor = UIColor.blue.withAlphaComponent(0.3)
            circle.strokeColor = UIColor.white.withAlphaComponent(0.8)
            circle.strokeWidth = 4
            circle.map = self
            
            let camera = GMSCameraPosition.camera(withLatitude: self.mapVM.center.latitude, longitude: self.mapVM.center.longitude, zoom: 14, bearing: 30, viewingAngle: 0)
            self.camera = camera
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
