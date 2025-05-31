//
//  GuestDetailsResponseModel.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 19/04/25.
//

import Foundation



// MARK: - GuestDetailsResponseModel
struct GuestDetailsResponseModel: Codable {
    var data: GuestDetailsResponseData?
    var message: String?
    var status: Int?
    var token: String?
}
// MARK: - DataClass
struct GuestDetailsResponseData: Codable {
    var guestID, firstName, lastName, guestMobile,hotelContactNumber: String?
    var guestEmail, hotelName, hotelVenue, roomNumber: String?
    var partner1, partner2, pairedWith: String?
    var events: [GuestDetailsData]?
    enum CodingKeys: String, CodingKey {
        case guestID = "guestId"
        case firstName, lastName, guestMobile, guestEmail, hotelName, hotelVenue, roomNumber, partner1, partner2, pairedWith, events,hotelContactNumber
    }
}

// MARK: - Event
struct GuestDetailsData: Codable {
    var eventID, eventName, startDate, duration: String?
    var endDate, eventDescription, company: String?
    var isActive: Bool?
    var program, hotel, flightDetails,eventCoordinatorName, eventCoordinatorMobile, imagePath: String?

    enum CodingKeys: String, CodingKey {
        case eventID = "eventId"
        case eventName, startDate, duration, endDate, eventDescription, company, isActive, program, hotel, flightDetails, imagePath,eventCoordinatorName, eventCoordinatorMobile
    }
}
