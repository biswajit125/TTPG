//
//  NeedAssistanceVC.swift
//  Event_Guest
//
//  Created by Bishwajit Kumar on 07/04/25.
//

import UIKit

class NeedAssistanceVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tblvw: UITableView!
    
    @IBOutlet weak var lblNodata: UILabel!
    
    var eventId : String = ""
    var guestId : String = ""
    var eventname : String = ""
    var token : String = ""
    
    var responseModel : GuestDetailsResponseModel = GuestDetailsResponseModel()
    
    var contactUsResponseModel : ContactUsResponseModel?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tblvw.register(UINib(nibName: "NeedAssistanceTVC", bundle: nil), forCellReuseIdentifier: "NeedAssistanceTVC")
        tblvw.register(UINib(nibName: "HotelReceptionTVC", bundle: nil), forCellReuseIdentifier: "HotelReceptionTVC")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.lblNodata.isHidden = true
        if let guestId = UserDefaultsManager.shared.getValue(forKey: .guestId) as? String {
            print("guestId: \(guestId)")
            self.guestId = guestId
           
        } else {
            print("guestId not found")
        }
        
        if let eventId = UserDefaultsManager.shared.getValue(forKey: .eventId) as? String {
            print("eventId: \(eventId)")
            self.eventId = eventId
           
        } else {
            print("guestId not found")
        }
        
        if let token = UserDefaultsManager.shared.getValue(forKey: .token) as? String {
            print("token: \(token)")
            self.token = token
           
        } else {
            print("token not found")
        }
        
        
        getContactUs(eventId: eventId, guestId: guestId,token: token)
        tblvw.reloadData()
    }
    // MARK: - Actions
//    func getContactUs(eventId: String, guestId: String,token: String) {
//        WebServiceCalls.shared.anyMethodApiCall(
//            endPoint: "hotel/getContactUs?eventId=\(eventId)&guestId=\(guestId)",
//            method: "GET",
//            body: [:],token: token
//        ) { msg, status, data in
//            // Ensure UI updates happen on the main thread
//            DispatchQueue.main.async {
//                if let data = data {
//                    do {
//                        let decoder = JSONDecoder()
//                        let decodedData = try decoder.decode(ContactUsResponseModel.self, from: data)
//                        print("decodedData::",decodedData)
//                       
//                        
//                        DispatchQueue.main.async {
//                            self.contactUsResponseModel = decodedData
//                            self.tblvw.reloadData()
//                        }
//
//                        if status == 1 {
//                           
//                        } else if status == 2 {
//                            self.showAlert(withMsg: decodedData.message ?? "Unknown Error")
//                        } else {
//                            self.showAlert(withMsg: msg)
//                        }
//                    } catch {
//                        print("Error decoding data: \(error)")
//                    }
//                } else {
//                    print("No data received.")
//                }
//            }
//        }
//    }
    func getContactUs(eventId: String, guestId: String, token: String) {
        WebServiceCalls.shared.anyMethodApiCall(
            endPoint: "hotel/getContactUs?eventId=\(eventId)&guestId=\(guestId)",
            method: "GET",
            body: [:], token: token
        ) { msg, status, data in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(ContactUsResponseModel.self, from: data)
                        print("decodedData::", decodedData)
                        
                        DispatchQueue.main.async {
                            self.contactUsResponseModel = decodedData
                            self.tblvw.reloadData()
                        }
                        
                        if status == 1 {
                            self.tblvw.isHidden = false
                        } else if status == 2 {
                            self.showAlert(withMsg: decodedData.message ?? "Unknown Error")
                        } else if status == 404 { // Hide table view if no data found
                            self.tblvw.isHidden = true
                            //self.showAlert(withMsg: "No data found.")
                            self.lblNodata.isHidden = false
                        } else {
                            self.showAlert(withMsg: msg)
                        }
                    } catch {
                        print("Error decoding data: \(error)")
                    }
                } else {
                    print("No data received.")
                }
            }
        }
    }


}
// MARK: - UITableView
//extension NeedAssistanceVC : UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "NeedAssistanceTVC", for: indexPath) as! NeedAssistanceTVC
//            
//            if contactUsResponseModel.data.eventDetails == nil {
//                
//            }else {
//                cell.lblEventName.text = contactUsResponseModel?.data?.eventDetails?.eventCoordinatorName
//                cell.lblEventNumber.text = contactUsResponseModel?.data?.eventDetails?.eventCoordinatorMobile
//            }
//         
//            return cell
//        }else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "HotelReceptionTVC", for: indexPath) as! HotelReceptionTVC
//            if contactUsResponseModel.data.hotelDetails == nil {
//                
//            }else {
//                cell.lblHotelNumber.text = contactUsResponseModel?.data?.hotelDetails?.hotelContactNumber
//            }
//     
//            return cell
//        }
//   
//    }
//}
extension NeedAssistanceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if contactUsResponseModel?.data?.eventDetails != nil {
            count += 1
        }
        if contactUsResponseModel?.data?.hotelDetails != nil {
            count += 1
        }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let availableSections = [
            contactUsResponseModel?.data?.eventDetails != nil ? "NeedAssistanceTVC" : nil,
            contactUsResponseModel?.data?.hotelDetails != nil ? "HotelReceptionTVC" : nil
        ].compactMap { $0 } // Filter out nil values
        
        let identifier = availableSections[indexPath.row]

        if identifier == "NeedAssistanceTVC" {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NeedAssistanceTVC
            cell.lblEventName.text = contactUsResponseModel?.data?.eventDetails?.eventCoordinatorName
            cell.lblEventNumber.text = contactUsResponseModel?.data?.eventDetails?.eventCoordinatorMobile
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HotelReceptionTVC
            cell.lblHotelNumber.text = contactUsResponseModel?.data?.hotelDetails?.hotelContactNumber
            return cell
        }
    }
}
