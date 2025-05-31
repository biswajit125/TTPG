//
//  NavigationProtocol.swift
//  Shepherd Cares
//
//  Created by itechnolabs on 26/04/22.
//


import UIKit

struct BarButton {
    var image: UIImage?
    var title: String?
    var action: Selector?
}

protocol NavigationProtocol {
}

extension NavigationProtocol where Self: UIViewController {
    
    func customizeNavigationBar(title: String? = nil, backButton: Bool, bgColor: UIColor = UIColor(named: "DarkBlue4")!, clearStatusBarColor: Bool? = nil, separator: Bool = true) {
    
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.setNavBar(isHidden: false, clearStatusBarColor: clearStatusBarColor)
        self.addCustomNavigationView(title, backButton: backButton, bgColor: bgColor, separator: separator)
    }
    
    private func addCustomNavigationView(_ text: String?, backButton: Bool, bgColor: UIColor, separator: Bool) {
        let navigationView = self.getCustomNavigationView(text ?? "", bgColor: bgColor)
        self.navigationItem.setHidesBackButton(true, animated: true)
        if backButton {
            let customBackButton = self.getBackButton()
            navigationView.addSubview(customBackButton)
            customBackButton.center.y = navigationView.center.y
        }
        if separator {
            let separatorView = self.getSeparator()
            separatorView.frame.origin.y = navigationView.frame.maxY - 1
            navigationView.addSubview(separatorView)
        }
        navigationView.tag = 9911
        self.navigationController?.navigationBar.addSubview(navigationView)
    }
    
    private func getSeparator() -> UIView {
        let width = UIScreen.main.bounds.width
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 1))
        separator.backgroundColor = UIColor(named: "DarkBlue11")
        return separator
    }
    
    private func getCustomNavigationView(_ text: String, bgColor: UIColor) -> UIView {
        let font = AppFont.medium.fontWithSize(18)
        let width = text.width(withConstrainedHeight: 22, font: font)
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 35))
        titleLabel.textAlignment = .center
        titleLabel.font = font
        titleLabel.textColor = .white
        titleLabel.text = text
        let screenWidth = UIScreen.main.bounds.size.width
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        titleView.backgroundColor = bgColor
        titleView.addSubview(titleLabel)
        titleLabel.center = titleView.center
        return titleView
    }
    
    private func getBackButton() -> UIButton {
        let backButton = UIButton(frame: CGRect(x: 12, y: 0, width: 35, height: 35))
        backButton.roundCornerWithWidth()
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
      
        return backButton
    }
    
    func addRightBarButtons(_ buttons: [BarButton]) {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        stackView.axis = .horizontal
        for button in buttons {
            let barButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
            if let action = button.action {
                barButton.addTarget(self, action: action, for: .touchUpInside)
            }
            
            if let title = button.title {
                barButton.titleLabel?.font = AppFont.medium.fontWithSize(12)
                barButton.setTitleColor(UIColor(named: "LightBlue3"), for: .normal)
                barButton.setTitle(title, for: .normal)
                let width = title.width(withConstrainedHeight: 24, font: AppFont.medium.fontWithSize(12))
//                barButton.frame.size.width = width
                stackView.frame.size.width += width
            }else if let image = button.image {
               
                stackView.frame.size.width += 35
            }
            stackView.addArrangedSubview(barButton)
        }
        
        let screenWidth = UIScreen.main.bounds.size.width
        if let customNavigationView = self.navigationController?.navigationBar.viewWithTag(9911) {
            let stackWidth = stackView.frame.width
            stackView.frame.origin.x = screenWidth - (stackWidth + 20)
            stackView.center.y = customNavigationView.center.y
            customNavigationView.addSubview(stackView)
        }
    }
    
    func addLeftBarButtons(_ buttons: [BarButton]) {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        stackView.axis = .horizontal
        for button in buttons {
            let barButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
            if let action = button.action {
                barButton.addTarget(self, action: action, for: .touchUpInside)
            }
            if let image = button.image {
              
            }
            stackView.frame.size.width += 35
            stackView.addArrangedSubview(barButton)
        }
        
        if let customNavigationView = self.navigationController?.navigationBar.viewWithTag(9911) {
            stackView.frame.origin.x = 20
            stackView.center.y = customNavigationView.center.y
            customNavigationView.addSubview(stackView)
        }
    }
    
    func setNavBar(isHidden: Bool, clearStatusBarColor: Bool? = nil) {
        var clearStatusBar = clearStatusBarColor
        if clearStatusBar == nil {
            clearStatusBar = isHidden
        }
        if clearStatusBar! {
            UIApplication.shared.statusBarUIView?.backgroundColor = UIColor.clear
        }else {
            UIApplication.shared.statusBarUIView?.backgroundColor = UIColor(named: "DarkBlue4")!
        }
        self.navigationController?.navigationBar.isHidden = isHidden
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
}

// MARK: - MENU BUTTONS
extension NavigationProtocol where Self: UIViewController {
    func addMenuButton() {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        stackView.axis = .horizontal
        
        let barButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        barButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
       
        stackView.frame.size.width += 35
        stackView.addArrangedSubview(barButton)
        
        if let customNavigationView = self.navigationController?.navigationBar.viewWithTag(9911) {
            stackView.frame.origin.x = 20
            stackView.center.y = customNavigationView.center.y
            customNavigationView.addSubview(stackView)
        }
    }
    
}

fileprivate extension UIViewController {
    
    @objc func backButtonAction() {
        if self.navigationController?.popViewController(animated: true) == nil {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func menuButtonAction() {
//        if let navVC = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
//            let menuVC = UIStoryboard.loadMenuVC()
//            menuVC.modalPresentationStyle = .overFullScreen
//            navVC.present(menuVC, animated: false, completion: nil)
//        }
    }
}
