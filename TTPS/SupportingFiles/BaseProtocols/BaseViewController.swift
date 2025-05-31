//
//  BaseViewController.swift
//  Shepherd Cares
//
//  Created by itechnolabs on 13/05/2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        navigationBarShow(true)
        
    }
    
    func navigationBarShow(_ isTrue:Bool) {
        self.navigationController?.isNavigationBarHidden = isTrue
    }

    

}
