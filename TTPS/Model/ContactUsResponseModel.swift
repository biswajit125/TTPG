//
//  ContactUsResponseModel.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 30/04/25.
//

import Foundation

// MARK: - ContactUsResponseModel
struct ContactUsResponseModel: Codable {
    var data: ContactUsResponseData?
    var message: String?
    var status: Int?
    var token: String?
}

// MARK: - ContactUsResponseData
struct ContactUsResponseData: Codable {
    var hotelDetails: HotelDetails?
    var eventDetails: EventDetails?
}

// MARK: - EventDetails
struct EventDetails: Codable {
    var eventCoordinatorName, eventCoordinatorMobile: String?
}

// MARK: - HotelDetails
struct HotelDetails: Codable {
    var hotelContactNumber, hotelName: String?
}

