//
//  PhotoDetailsViewModel.swift
//  Photos Task
//
//  Created by Walid Ahmed on 04/04/2023.
//

import Foundation
import RxSwift
import RxCocoa

class PhotoDetailsViewModel {
    
    let disposeBag = DisposeBag()
    let selectedPhoto = BehaviorRelay<Photos>(value: Photos())

}
