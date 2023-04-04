//
//  PhotosVC.swift
//  Photos Task
//
//  Created by Walid Ahmed on 04/04/2023.
//

import UIKit

class PhotosVC: UIViewController {

    @IBOutlet weak var photosTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Photos"
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
}
