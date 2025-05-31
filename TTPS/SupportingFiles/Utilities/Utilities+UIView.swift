//
//  Utilities+UIView.swift
//  RonTaxi_Customer
//
//  Created by Ajay Kumar on 03/09/19.
//  Copyright © 2019 TG. All rights reserved.
//
import UIKit
import Foundation


extension UIView {
    
    // Shadow Toggle
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue {
                self.addShadowOnView()
            } else {
                self.layer.shadowOpacity = 0
            }
        }
    }
    
    // Corner Radius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Ensure masksToBounds is managed correctly
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    // Border Width
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    // Border Color
    @IBInspectable var borderColor: UIColor? {
        get {
            if let cgColor = self.layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    // Shadow Color
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let cgColor = self.layer.shadowColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    // Shadow Opacity
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    // Shadow Offset
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    // Shadow Radius
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    // Background Gradient
    @IBInspectable var gradientStartColor: UIColor? {
        get {
            return nil // Not retrievable directly
        }
        set {
            updateGradientLayer(startColor: newValue, endColor: nil)
        }
    }
    
    @IBInspectable var gradientEndColor: UIColor? {
        get {
            return nil // Not retrievable directly
        }
        set {
            updateGradientLayer(startColor: nil, endColor: newValue)
        }
    }
    
    // Add Shadow
    func addShadowOnView(shadowColor: CGColor = UIColor.black.cgColor,
                         shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                         shadowOpacity: Float = 0.4,
                         shadowRadius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
    
    // Add Gradient Layer
    private func updateGradientLayer(startColor: UIColor?, endColor: UIColor?) {
        guard let startColor = startColor, let endColor = endColor else { return }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
