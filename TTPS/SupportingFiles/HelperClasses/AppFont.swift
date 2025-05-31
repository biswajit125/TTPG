//
//  AppFont.swift
//  TimeApp
//
//  Created by Kamaljeet Punia on 09/04/20.
//  Copyright © 2020 Tina. All rights reserved.
//

import Foundation
import UIKit

//MARK: Enumeration
enum AppFont: String {
    
    case regular = "Urbanist-Regular"
    case bold = "Urbanist-Bold"
    case light = "Roboto-Light"
    case medium = "Roboto-Medium"
    case semiBold = "Roboto-SemiBold"
    
    func fontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}

enum AppColor{
    static let appOrange = UIColor(named: "AppOrange")
    static let fontGrey = UIColor(named: "AppFontGrey")
    static let appBlue = UIColor(named: "AppBlue")
    static let shadowGrey = UIColor(named: "ShadowBack")
    static let voilet = UIColor(named: "AppVoilet")
    static let green = UIColor(named: "AppGreen")
    static let backGround = UIColor(named: "AppBlack")
    static let boxGrey = UIColor(named: "BoxGrey")
    static let unselectedText = UIColor(named: "UnselectedBtn")
    
    static let appLightGreen = UIColor(named: "AppLightGreen")
    static let appGreen = UIColor(named: "AppGreen")
    static let appLineSegment = UIColor(named: "AppLineSegment")
    static let appGray = UIColor(named: "AppGray")
    static let appWhite = UIColor(named: "AppWhite")
    
    static let app_Color_Green = UIColor(named: "App_Color_Green")
    static let app_Color_Skin = UIColor(named: "App_Color_Skin")
    static let app_Color_Gray = UIColor(named: "App_Color_Gray")
    static let app_Color_BlackOpacity = UIColor(named: "App_Color_BlackOpacity")
    static let app_Color_PlayerCore = UIColor(named: "App_Color_PlayerCore")
    static let app_Color_Player = UIColor(named: "App_Color_Player")
    static let appHole_Color = UIColor(named: "appHole_Color")
    static let app_Color_Yellow = UIColor(named: "app_Color_Yellow")
    
    static let app_Gray_Color = UIColor(named: "App_Gray_Color")
    
    static let appColor_hdcp = UIColor(named: "AppColor_hdcp")
    static let appColor_Par = UIColor(named: "AppColor_Par")
    static let appColor_hole = UIColor(named: "AppColor_hole")
    
    static let app_ColorWhiteTrans = UIColor(named: "app_ColorWhiteTrans")
    static let app_ColorDrakBlue = UIColor(named: "app_ColorDrakBlue")
    static let app_ColorBlue = UIColor(named: "app_ColorBlue")
    static let app_ColorYellow = UIColor(named: "app_ColorYellow")
    static let app_ColorLightblue = UIColor(named: "app_ColorLightblue")
    
    
}

enum StoryBoard{
    static let main = UIStoryboard(name: "Main", bundle: nil)
    static let tab = UIStoryboard(name: "Tab", bundle: nil)
    static let activity = UIStoryboard(name: "Activity", bundle: nil)
    static let hotels = UIStoryboard(name: "Hotels", bundle: nil)
    static let flight = UIStoryboard(name: "Flight", bundle: nil)
    static let vehicles = UIStoryboard(name: "Vehicles", bundle: nil)
    static let gift = UIStoryboard(name: "Gift", bundle: nil)
}
