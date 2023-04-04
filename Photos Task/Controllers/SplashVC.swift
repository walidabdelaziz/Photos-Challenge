//
//  ViewController.swift
//  Photos Task
//
//  Created by Walid Ahmed on 04/04/2023.
//

import UIKit

class SplashVC: UIViewController {

    var count = 2
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    func setupUI(){
        self.timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.updateUI), userInfo: nil, repeats: true)
        
    }
    @objc func updateUI(){
        
        if count > 0 {
            count -= 1
        }
        else{
            showVC()
            if timer != nil {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    @objc func showVC(){
        let storyboard = UIStoryboard(name: "Photos", bundle: nil)
        let PhotosVC = storyboard.instantiateViewController(withIdentifier: "PhotosVC")
        self.navigationController?.pushViewController(PhotosVC, animated: true)
    }

}
