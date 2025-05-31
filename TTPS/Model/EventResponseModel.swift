//
//  EventResponseModel.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 29/04/25.
//

//import Foundation
//
//// MARK: - EventResponseModel
//struct EventResponseModel: Codable {
//    let data: [EventResponseData]?
//    let message: String?
//    let status: Int?
//    let token: String?
//}
//
//// MARK: - EventResponseData
//struct EventResponseData: Codable {
//    let day, date: String?
//    let programs: [Program]?
//}
//
//// MARK: - Program
//struct Program: Codable {
//    let programID, functionName, startDtTime, endDtTime: String?
//    let dressCDMale, dressCDFemale, venue, capacity: String?
//    let parkingCapacity, contactPerson, mobile: String?
//    let isActive: Bool?
//    let company: String?
//    let eventID: Int?
//    let event: String?
//    let imageFilePath, activity: String?
//
//    enum CodingKeys: String, CodingKey {
//        case programID = "programId"
//        case functionName
//        case startDtTime = "start_dt_time"
//        case endDtTime = "end_dt_time"
//        case dressCDMale = "dress_cd_male"
//        case dressCDFemale = "dress_cd_female"
//        case venue, capacity
//        case parkingCapacity = "parking_capacity"
//        case contactPerson = "contact_person"
//        case mobile, isActive, company
//        case eventID = "eventId"
//        case event, imageFilePath, activity
//    }
//}
// MARK: - EventResponseModel
struct EventResponseModel: Codable {
    var data: EventResponseData?
    var message: String?
    var status: Int?
    var token: String?
}

// MARK: - EventResponseData
struct EventResponseData: Codable {
    var programs: [Program]?
}

// MARK: - Program
struct Program: Codable {
    var programID, functionName: String?
    var startDtTime, endDtTime: String?
    var startDate, endDate, startTime, endTime: String?
    var dressCDMale, dressCDFemale, venue, capacity: String?
    var parkingCapacity, contactPerson, mobile: String?
    var isActive: Bool?
    var company: String?
    var eventID: Int?
    var event: String?
    var imageFilePath, remarks, activity: String?
    var day, date: String?

    enum CodingKeys: String, CodingKey {
        case programID = "programId"
        case functionName
        case startDtTime = "start_dt_time"
        case endDtTime = "end_dt_time"
        case startDate = "start_date"
        case endDate = "end_date"
        case startTime = "start_time"
        case endTime = "end_time"
        case dressCDMale = "dress_cd_male"
        case dressCDFemale = "dress_cd_female"
        case venue, capacity
        case parkingCapacity = "parking_capacity"
        case contactPerson = "contact_person"
        case mobile, isActive, company
        case eventID = "eventId"
        case event, imageFilePath, remarks, activity, day, date
    }
}
