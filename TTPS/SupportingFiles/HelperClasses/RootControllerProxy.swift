//
//  RootControllerProxy.swift
//  Colorblind
//
//  Created by itechnolabs on 21/09/22.
//

import UIKit
class RootControllerProxy{
    static let shared = RootControllerProxy()
    
    // MARK: - CLASS LIFE CYCLE
    private init() {
        
    }
    
    func setRoot(_ identifier : String , _ storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil) ){
        UIApplication.shared.removeCustomStatusBar()
        let story = storyBoard
        let vc = story.instantiateViewController(withIdentifier: "\(identifier)")
        let navVC = UINavigationController(rootViewController: vc)
        navVC.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = navVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
//    func gotoHome() {
//        UIApplication.shared.removeCustomStatusBar()
//        let vc = StoryBoard.tabBar.instantiateViewController(withIdentifier: "CustomCardTabBarController") as! CustomCardTabBarController
//        let navVC = UINavigationController(rootViewController: vc)
//        navVC.isNavigationBarHidden = true
//        UIApplication.shared.windows.first?.rootViewController = navVC
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }

    
}
