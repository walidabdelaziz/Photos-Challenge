//
//  PhotosViewModel.swift
//  Photos Task
//
//  Created by Walid Ahmed on 04/04/2023.
//

import Foundation
import RxSwift
import RxCocoa

class PhotosViewModel {

    let disposeBag = DisposeBag()
    var currentPage = 1
    let photos = BehaviorRelay<[Photos]>(value: [])
    let isSuccess = BehaviorRelay<Bool>(value: false)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<Error>()
    let loadNextPageTrigger = PublishSubject<Void>()

    func getPhotos() {
        guard !isLoading.value else { return }
        self.isLoading.accept(true)

            NetworkManager.shared.request("\(Consts.PHOTOS)?page=\(currentPage)&limit=10") { [weak self] (result: Result<[Photos]>) in
                guard let self = self else { return }
                self.isLoading.accept(false)

                switch result {
                case .success(let response):

                    self.currentPage += 1

                    // insert ad after 5 images
                    let photosWithAds = response.enumerated().flatMap { (index, photo) -> [Photos] in
                        if (index + 1) % 5 == 0 {
                            return [photo, Photos(isAd: true)]
                        } else {
                            return [photo]
                        }
                    }
                    self.photos.accept((self.photos.value) + (photosWithAds))
                    
                    // Save cached photos
                    self.saveCachedPhotos()

                case .failure(let error):
                    // handle error
                    if error == .noInternetConnection{
                        self.photos.accept(PreferenceManager.getCachedPhotos())
                    }else{
                        self.error.onNext(error)
                    }
                }
            }
            
    }
   
    func saveCachedPhotos(){
        let cachedPhotos = Array(self.photos.value.prefix(20))
        PreferenceManager.saveCachedPhotos(cachedPhotos: cachedPhotos)
    }
    func bindLoadNextPageTrigger() {
        loadNextPageTrigger
            .subscribe(onNext: { [weak self] in
                self?.getPhotos()
            }).disposed(by: disposeBag)
    }
}
