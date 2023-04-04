//
//  PhotoDetailsVC.swift
//  Photos Task
//
//  Created by Walid Ahmed on 04/04/2023.
//

import UIKit
import RxSwift
class PhotoDetailsVC: UIViewController {

    let photoDetailsViewModel = PhotoDetailsViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var selectedImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindViewModel()
    }
    func bindViewModel(){
        // handle back action
        cancelBtn.rx.tap
            .bind(onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        // load image
        photoDetailsViewModel.selectedPhoto.asObservable()
            .bind(onNext: {
                (selectedPhoto) in
                self.selectedImg.sd_setImage(with: URL(string: selectedPhoto.downloadURL ?? ""))
                self.setBackgroundColor()
            }).disposed(by: disposeBag)
    }
    func setBackgroundColor(){
        view.backgroundColor = self.selectedImg.image?.getDominantColor()
    }

}
