//
//  ServiceController.swift
//  GoogleMaps
//
//  Created by Çağrı ÇOLAK on 30.12.2019.
//  Copyright © 2019 MW. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

struct ServiceController {
    func getPlaceData<T: Decodable>(with requestObject:URLRequest) -> Observable<[T]> {
        return Observable<[T]>.create { observer in
            let jsonDecoder = JSONDecoder()
                Alamofire.request(requestObject).responseData { (response: DataResponse<Data>) in
                    guard let responseData = response.value else {
                        fatalError("responseModel failed")
                    }
                    do {
                        let responseModel = try jsonDecoder.decode(T.self, from: responseData)
                        observer.onNext([responseModel])
                        observer.onCompleted()
                    }catch {
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
