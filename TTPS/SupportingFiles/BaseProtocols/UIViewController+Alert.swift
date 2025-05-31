//
//  UIViewController+Alert.swift
//  Asset Management
//
//  Created by Supriyo Dey on 07/09/23.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(withMsg: String) {
        let alert = UIAlertController(title: "", message: withMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func showAlertWithAction(msg: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            completion()
        }))
        self.present(alert, animated: true)
    }
    
}
