//
//  EventByGuestResponseModel.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 30/04/25.
//

import Foundation


// MARK: - EventByGuestResponseModel
struct EventByGuestResponseModel: Codable {
    var data: EventByGuestResponseData?
    var message: String?
    var status: Int?
    var token: String?
}

// MARK: - EventByGuestResponse
struct EventByGuestResponseData: Codable {
    var guestID, firstName, lastName, guestMobile: String?
    var guestEmail: String?
    var hotelName, hotelContactNumber, hotelVenue, roomNumber: String?
    var partner1, partner2, pairedWith: String?
    var events: [EventGuest]?

    enum CodingKeys: String, CodingKey {
        case guestID = "guestId"
        case firstName, lastName, guestMobile, guestEmail, hotelName, hotelContactNumber, hotelVenue, roomNumber, partner1, partner2, pairedWith, events
    }
}

// MARK: - Event
struct EventGuest: Codable {
    var eventID, eventName, startDate, duration: String?
    var endDate, eventDescription, company: String?
    var isActive: Bool?
    var program, hotel, flightDetails: String?
    var imagePath, eventCoordinatorName, eventCoordinatorMobile: String?

    enum CodingKeys: String, CodingKey {
        case eventID = "eventId"
        case eventName, startDate, duration, endDate, eventDescription, company, isActive, program, hotel, flightDetails, imagePath, eventCoordinatorName, eventCoordinatorMobile
    }
}
