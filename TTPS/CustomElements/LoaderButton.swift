//
//  LoaderButton.swift
//  Asset Management
//
//  Created by Supriyo Dey on 15/09/23.
//

import Foundation
import UIKit
// 1
class LoaderButton: UIButton {
    // 2
    private var spinner = UIActivityIndicatorView()
    var spinnerColor = UIColor.white
    // 3
    var isLoading = false {
        didSet {
            // whenever `isLoading` state is changed, update the view
            updateView()
        }
    }
    
    private var title = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 4
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        //titleLabel?.font = UIFont(name: "Inter SemiBold", size: 20)//systemFont(ofSize: 20, weight: .semibold) //.systemFont(ofSize: 20)
        // 5
        spinner.hidesWhenStopped = true
        // to change spinner color
        spinner.color = spinnerColor//.white
        // default style
//        spinner.style = .large
        
        // 6
        // add as button subview
        addSubview(spinner)
        // set constraints to always in the middle of button
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // 7
    private func updateView() {
        if isLoading {
            title = currentTitle ?? ""
            setTitle(nil, for: .normal)
            spinner.startAnimating()
            imageView?.alpha = 0
            isEnabled = false
        } else {
            spinner.stopAnimating()
            setTitle(title, for: .normal)
            imageView?.alpha = 0
            isEnabled = true
        }
    }
}
