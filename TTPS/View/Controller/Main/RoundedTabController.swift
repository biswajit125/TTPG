//
//  RoundedTabController.swift
//  Event_GuestApp
//
//  Created by Yagnesh Bagrodia on 07/05/25.
//

import Foundation
import UIKit


//class RoundedTabController: UITabBarController, UITabBarControllerDelegate {
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//    }
//    
//    var tabselect: Int = 0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.delegate = self
//        self.selectedIndex = tabselect
//        setupTabBarAppearance()
//        //handleAPIResponse()
//    }
//    
////    private func handleAPIResponse() {
////        guard let user = AppCache.shared.currentUser?.data else { return }
////
////        let androidMenus = user.permissionsAndroid?.compactMap { $0.menuName } ?? []
////        print("androidMenus:::", androidMenus)
////        let tabPermissions: [(menuName: String, tabIndex: Int)] = [
////            ("Activity", 0),
////            ("Hotel", 1),
////            ("Vehicle", 2),
////            ("Flight", 3),
////            ("Gift-Hamper", 4)
////        ]
////        var indicesToHide = [Int]()
////        for (menuName, tabIndex) in tabPermissions {
////            if !(androidMenus.contains(menuName)) {
////                indicesToHide.append(tabIndex)
////            }
////        }
////        print("Indices to hide: ", indicesToHide)
////        hideTabBarItems(at: indicesToHide)
////    }
//    
//    func hideTabBarItems(at indices: [Int]) {
//        guard var viewControllers = self.viewControllers else { return }
//        let sortedIndices = indices.sorted(by: >)
//        for index in sortedIndices {
//            guard index < viewControllers.count else { continue }
//            viewControllers.remove(at: index)
//        }
//        self.viewControllers = viewControllers
//    }
//
//    private func setupTabBarAppearance() {
//        let tabImages: [(normal: String, selected: String)] = [
//            ("ic_home", "ic_homeS"),
//            ("ic_guest", "ic_guestS")
//        ]
//
//        for (index, images) in tabImages.enumerated() {
//            if let tabBarItem = self.tabBar.items?[index] {
//                tabBarItem.image = UIImage(named: images.normal)?.withRenderingMode(.alwaysOriginal)
//                tabBarItem.selectedImage = UIImage(named: images.selected)?.withRenderingMode(.alwaysOriginal)
//            }
//        }
//
//        // Set font color for unselected and selected states
//        let unselectedAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.lightGray,
//            .font: UIFont.systemFont(ofSize: 12)
//        ]
//
//        let selectedAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.black,
//            .font: UIFont.systemFont(ofSize: 12)
//        ]
//
//        UITabBarItem.appearance().setTitleTextAttributes(unselectedAttributes, for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
//    }
//}



class RoundedTabController: UITabBarController, UITabBarControllerDelegate {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    var tabselect: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = tabselect
        setupTabBarAppearance()
        //handleAPIResponse()
    }
    
//    private func handleAPIResponse() {
//        guard let user = AppCache.shared.currentUser?.data else { return }
//
//        let androidMenus = user.permissionsAndroid?.compactMap { $0.menuName } ?? []
//        print("androidMenus:::", androidMenus)
//        let tabPermissions: [(menuName: String, tabIndex: Int)] = [
//            ("Activity", 0),
//            ("Hotel", 1),
//            ("Vehicle", 2),
//            ("Flight", 3),
//            ("Gift-Hamper", 4)
//        ]
//        var indicesToHide = [Int]()
//        for (menuName, tabIndex) in tabPermissions {
//            if !(androidMenus.contains(menuName)) {
//                indicesToHide.append(tabIndex)
//            }
//        }
//        print("Indices to hide: ", indicesToHide)
//        hideTabBarItems(at: indicesToHide)
//    }
    
    func hideTabBarItems(at indices: [Int]) {
        guard var viewControllers = self.viewControllers else { return }
        let sortedIndices = indices.sorted(by: >)
        for index in sortedIndices {
            guard index < viewControllers.count else { continue }
            viewControllers.remove(at: index)
        }
        self.viewControllers = viewControllers
    }

//    private func setupTabBarAppearance() {
//        let tabImages: [(normal: String, selected: String)] = [
//            ("ic_home", "ic_homeS"),
//            ("ic_calendarTab", "ic_calendarTabS"),
//            ("ic_phoneTab", "ic_phoneTabS"),
//            ("ic_document", "ic_documentS")
//
//        ]
//
//        for (index, images) in tabImages.enumerated() {
//            if let tabBarItem = self.tabBar.items?[index] {
//                tabBarItem.image = UIImage(named: images.normal)?.withRenderingMode(.alwaysOriginal)
//                tabBarItem.selectedImage = UIImage(named: images.selected)?.withRenderingMode(.alwaysOriginal)
//            }
//        }
//
//        // Set font color for unselected and selected states
//        let unselectedAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.lightGray,
//            .font: UIFont.systemFont(ofSize: 12)
//        ]
//
//        let selectedAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.black,
//            .font: UIFont.systemFont(ofSize: 12)
//        ]
//
//        UITabBarItem.appearance().setTitleTextAttributes(unselectedAttributes, for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
//    }
    
    private func setupTabBarAppearance() {
        let tabImages: [(normal: String, selected: String)] = [
            ("ic_home", "ic_homeS"),
            ("ic_guest", "ic_guestS")
        ]

        for (index, images) in tabImages.enumerated() {
            if let tabBarItem = self.tabBar.items?[index] {
                tabBarItem.image = UIImage(named: images.normal)?.withRenderingMode(.alwaysOriginal)
                tabBarItem.selectedImage = UIImage(named: images.selected)?.withRenderingMode(.alwaysOriginal)
            }
        }

        // Set font color for unselected and selected states
        let unselectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 12)
        ]

        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppColor.app_ColorYellow ?? .appColorYellow,
            .font: UIFont.systemFont(ofSize: 12)
        ]

        UITabBarItem.appearance().setTitleTextAttributes(unselectedAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)

        // Set background color to black
        tabBar.barTintColor = AppColor.app_ColorYellow
        tabBar.backgroundColor = AppColor.app_ColorBlue
        tabBar.isTranslucent = false
    }

}



