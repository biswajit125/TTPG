//
//  UIViewController+Extension.swift
//  Whetness
//
//  Created by Bishwajit kumar on 12/12/23.
//  Copyright © 2021 Kamaljeet Punia. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //MARK: - Convert UIViewController's objecto String object
    static var typeName: String {
        return String(describing: self)
    }
    
   
    
    //Navigate using identifier
    
    func moveToNext(_ identifier : String , title : String = ""  ,  storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)){
        let objVC = storyBoard.instantiateViewController(withIdentifier: identifier)
        objVC.title = title
        navigationController?.pushViewController(objVC, animated: false)
    }
    
    func popToBack(){
        navigationController?.popViewController(animated: false)
    }
    
}

extension UITableViewCell{
    static var typeName: String {
        return String(describing: self)
    }
    
}
extension UICollectionViewCell{
    static var typeName: String {
        return String(describing: self)
    }
    
}
