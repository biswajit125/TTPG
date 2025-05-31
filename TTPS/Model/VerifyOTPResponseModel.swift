//
//  VerifyOTPResponseModel.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 19/04/25.
//

import Foundation


// MARK: - VerifyOTPResponseModel
struct VerifyOTPResponseModel: Codable {
    var data: VerifyOTPResponseData?
    var message: String?
    var status: Int?
    var token: String?
}

// MARK: - DataClass
struct VerifyOTPResponseData: Codable {
    var guestID, firstName, lastName, guestMobile: String?
    var guestEmail: String?
    var hotelName, hotelVenue, roomNumber, partner1: String?
    var partner2, pairedWith: String?
    var events: [EventData]?

    enum CodingKeys: String, CodingKey {
        case guestID = "guestId"
        case firstName, lastName, guestMobile, guestEmail, hotelName, hotelVenue, roomNumber, partner1, partner2, pairedWith, events
    }
}

// MARK: - Event
struct EventData: Codable {
    var eventID, eventName, startDate, duration: String?
    var endDate, eventDescription, company: String?
    var isActive: Bool?
    var program, hotel, flightDetails, imagePath: String?

    enum CodingKeys: String, CodingKey {
        case eventID = "eventId"
        case eventName, startDate, duration, endDate, eventDescription, company, isActive, program, hotel, flightDetails, imagePath
    }
}
