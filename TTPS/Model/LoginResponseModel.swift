//
//  LoginResponseModel.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 19/04/25.
//

import Foundation

// MARK: - LoginResponseModel
struct LoginResponseModel: Codable {
    var data: LoginResponseData?
    var message: String?
    var status: Int?
    var token: String?
}

// MARK: - LoginResponseData
struct LoginResponseData: Codable {
    var username, firstName, lastName, roleName: String?
    let permissionsWeb, permissionsAndroid: [String]?
    let token: String?
}
