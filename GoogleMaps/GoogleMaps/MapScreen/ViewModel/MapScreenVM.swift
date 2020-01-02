//
//  MapScreenVM.swift
//  GoogleMaps-App
//
//  Created by Çağrı ÇOLAK on 2.01.2020.
//  Copyright © 2020 MW. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

class MapScreenVM {
    
    var mapData:PlaceModel?
    
    init(mapData:PlaceModel) {
        self.mapData = mapData
    }
    
    var center:CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    var markerTitle:String {
        return mapData?.candidates.first?.name ?? ""
    }
    
    var cameraPosition:GMSCameraPosition {
        let camera = GMSCameraPosition.camera(withLatitude: center.latitude, longitude: center.longitude, zoom: 14, bearing: 30, viewingAngle: 0)
        return camera
    }
    
    var latitude:Double {
        return mapData?.candidates.first?.geometry.location.latitude ?? 0.0
    }
    
    var longitude:Double {
        return mapData?.candidates.first?.geometry.location.longitude ?? 0.0
    }
    
    var placeID:String {
        return mapData?.candidates.first?.place_id ?? ""
    }
    
    var imageReferance:String? {
        return mapData?.candidates.first?.photos.first?.photo_reference ?? nil
    }
    
    var placeAdress:String {
        return mapData?.candidates.first?.formatted_address ?? ""
    }
    
    private var placeRating:Double? {
        return mapData?.candidates.first?.rating ?? nil
    }
    
    func getPlaceRatingData() -> String {
        var ratingStars = ""
        if let placeRating = self.placeRating {
            for _ in 0..<Int(placeRating) {
                ratingStars.append("⭐️")
            }
            return "Rating: \(ratingStars)(\(Int(placeRating))/5)"
        }else {
            return "Don't have any rating data"
        }
        
    }
    
    func getPlaceImageRequest() -> URLRequest? {
        var apiController = APIController()
        if let imgRef = self.imageReferance {
            return apiController.getPlaceImage(with: imgRef)
        }
        return nil
    }
    
}
