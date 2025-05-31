//
//  HostGuestSummaryResponseModel.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 05/05/25.
//

import Foundation
// MARK: - HostGuestSummaryResponseModel
struct HostGuestSummaryResponseModel: Codable {
    var data: HostGuestSummaryResponseData?
    var message: String?
    var status: Int?
    var token: String?
}

// MARK: - HostGuestSummaryResponseData
struct HostGuestSummaryResponseData: Codable {
    var totalInvitedGuest, arrivedGuest, notArrivedGuest: Int?
    var checkedInPercentage: Double?
}

