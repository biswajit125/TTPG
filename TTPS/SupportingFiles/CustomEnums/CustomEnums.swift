//
//  CustomEnums.swift
//  Colorblind
//
//  Created by itechnolabs on 20/09/22.
//
import UIKit
import Foundation
enum AppVersion : String {
    case appVersion
    
    func version()-> String{
        switch self {
        case .appVersion:
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        }
        
    }
}

enum Titles{
    static let changePass = "Change Password"
    static let helpSupport = "Help & Support"
    static let aboutUs = "About Us"
    static let privacyPolicy = "Privacy Policy"
    static let termsConditions = "Terms & Conditions"
}
