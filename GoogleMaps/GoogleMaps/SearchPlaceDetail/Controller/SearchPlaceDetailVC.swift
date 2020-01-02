//
//  SearchPlaceDetailVC.swift
//  GoogleMaps-App
//
//  Created by Çağrı ÇOLAK on 2.01.2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import SnapKit
import RxNuke
import RxSwift
import Nuke

class SearchPlaceDetailVC: UIViewController,Storyboarded {
    weak var placeDetailCoordinator: PlaceDetailCoordinator?
    var placeModel:PlaceModel?
    private var mapVM: MapScreenVM!
    
    private let placeImage = UIImageView()
    private let placeName = UILabel()
    private let placeRate = UILabel()
    private let placeAdress = UILabel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureUI()
        bindUI()
    }
    
    func bindViewModel() {
        guard let placeModelData = placeModel else { return }
        mapVM = MapScreenVM(mapData: placeModelData)
        
        
    }
    
    func bindUI() {
        placeName.text = "Place Name: \(mapVM.markerTitle)"
        placeAdress.text = "Adress: \(mapVM.placeAdress)"
        placeRate.text = mapVM.getPlaceRatingData()
        
        let pipeline = ImagePipeline()
        if let placeImageURL = mapVM.getPlaceImageRequest()?.url {
            pipeline.rx.loadImage(with: placeImageURL).asObservable().take(1)
                .subscribe(onNext: { [weak self] (image) in
                    self?.placeImage.image = image.image
                }).disposed(by: disposeBag)
        }
    }
}

extension SearchPlaceDetailVC {
    func configureUI() {
        let stackView = UIStackView(frame: CGRect.zero)
        
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.snp.makeConstraints { (make) in
            make.leadingMargin.equalToSuperview().inset(20)
            make.trailingMargin.equalToSuperview().inset(20)
            make.topMargin.equalToSuperview().inset(50)
        }
        
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.addArrangedSubview(placeImage)
        placeImage.snp.makeConstraints { (make) in
            make.height.equalTo(300)
        }
        stackView.addArrangedSubview(placeName)
        stackView.addArrangedSubview(placeRate)
        stackView.addArrangedSubview(placeAdress)
        placeAdress.numberOfLines = 0
        placeAdress.lineBreakMode = .byWordWrapping
    }
}
