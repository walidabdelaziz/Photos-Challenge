//
//  PhotosVC.swift
//  Photos Task
//
//  Created by Walid Ahmed on 04/04/2023.
//

import UIKit
import RxSwift

class PhotosVC: UIViewController {

    let photosViewModel = PhotosViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var photosTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        bindViewModel()
        photosViewModel.getPhotos()
    }
    func setupUI(){
        title = "Photos"
        navigationItem.setHidesBackButton(true, animated: true)
        setPhotosTableView()
    }
    func setPhotosTableView(){
        photosTV.register(UINib(nibName: "PhotosTVCell", bundle: nil), forCellReuseIdentifier: "PhotosTVCell")
        photosTV.register(UINib(nibName: "AdTVCell", bundle: nil), forCellReuseIdentifier: "AdTVCell")
        photosTV.estimatedRowHeight = UITableView.automaticDimension
        photosTV.rx.setDelegate(self).disposed(by: disposeBag)
    }
    func bindViewModel(){
        photosViewModel.photos
            .bind(to: photosTV.rx.items) { [weak self] tableView, index, photo in
                if photo.isAd == true {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "AdTVCell") ?? UITableViewCell(style: .default, reuseIdentifier: "AdTVCell")
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTVCell", for: IndexPath(row: index, section: 0)) as! PhotosTVCell
                    cell.photo = photo
                    return cell
                }
            }
            .disposed(by: disposeBag)

        
        // show loader
        photosViewModel.isLoading.asObservable()
            .bind { (loading) in
                if loading {
                    Utils.showLoader(self.view)
                }
                else {
                    Utils.hideLoader()
                }
            }.disposed(by: disposeBag)
        
        // show error
        photosViewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        // handle next page trigger
        photosViewModel.bindLoadNextPageTrigger()
            
       // handle selection in tableview
        Observable
            .zip(self.photosTV.rx.itemSelected, self.photosTV.rx.modelSelected(Photos.self))
            .bind { [unowned self] indexPath, model in
                
            }
            .disposed(by: disposeBag)
    }
    
}
extension PhotosVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = photosViewModel.photos.value.count - 1
        if indexPath.row == lastElement {
            photosViewModel.loadNextPageTrigger.onNext(())
        }
    }
}
