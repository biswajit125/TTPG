//
//  FlightHostResponseModel.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 05/05/25.
//

import Foundation


// MARK: - FlightHostResponseModel
struct FlightHostResponseModel: Codable {
    let data: [FlightHostResponseData]?
    let message: String?
    let status: Int?
    let token: String?
}

// MARK: - FlightHostResponseData
struct FlightHostResponseData: Codable {
    let salutation, firstName, lastName, guestMobile: String?
    let guestOf, inviteType, guestRelation: String?
    let flightStatus: String?
    let rsvp: String?
    let guestPairing1: String?
    let guestPairing2: String?
    let isPaired: Bool?
    let pairedWith, roomType, roomNumber, hotelName: String?
    let giftHamperQty: Int?
    let status: String?
}
