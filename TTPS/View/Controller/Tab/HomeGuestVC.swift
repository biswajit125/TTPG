//
//  HomeGuestVC.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 09/04/25.
//

import UIKit

class HomeGuestVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var viwChild: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblRoomnumber: UILabel!
    @IBOutlet weak var lblroomPatner: UILabel!
    @IBOutlet weak var lbleventName: UILabel!
    @IBOutlet weak var btnEvent: UIButton!
    
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var lblHotelName: UILabel!
    
    
    
    var guestDetailsResponseModel : GuestDetailsResponseModel?
    
    
    var eventId : String = ""
    var guestId : String = ""
    var eventname : String = ""
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viwChild.layer.cornerRadius = 20
        viwChild.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        viwChild.layer.masksToBounds = true
        
        
//        if let savedResponse = UserDefaultsManager.shared.getVerifyOTPResponse() {
//            print("guest name: \(savedResponse.data?.firstName ?? "N/A")")
//          
//            
//            if let events = savedResponse.data?.events {
//                for event in events {
//                    if let description = event.eventDescription {
//                        print("eventDescription: \(description)")
//                    } else {
//                        print("eventDescription: N/A")
//                    }
//                }
//            } else {
//                print("No events found.")
//            }
//            
//        }
        
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        
        
        getGuestDetails(eventId: eventId, guestId: guestId)
    }
    
    

    func getGuestDetails(eventId: String,guestId: String) {
        WebServiceCalls.shared.anyMethodApiCall(endPoint: "hotel/getGuestDetails?eventId=\(eventId)&guestId=\(guestId)", method: "GET", body: [:]) { msg, status, data in
            DispatchQueue.main.async {
                //self.btnSubmit.isLoading = false
                //                self.removeLoader(loader: loader) {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(GuestDetailsResponseModel.self, from: data)
                        //                        DispatchQueue.main.async {
                        DispatchQueue.main.async {
                            if status == 1 {
                                if let events = decodedData.data?.events {
                                    if events.count > 1 {
                                        print("More than one event found.")
                                        self.btnEvent.isHidden = false
                                        self.imgEvent.isHidden = false
                                    } else if events.count == 1 {
                                        print("Only one event found.")
                                        self.btnEvent.isHidden = true
                                        self.imgEvent.isHidden = true
                                    } else {
                                        print("No events found.")
                                        self.btnEvent.isHidden = true
                                        self.imgEvent.isHidden = true
                                    }
                                }
                                
                                let gusestId = decodedData.data?.guestID ?? ""
                                print("gusestId::",gusestId)
                                UserDefaultsManager.shared.saveValue(gusestId, forKey: .guestId)
                                self.lblUserName.text = decodedData.data?.firstName ?? ""
                                self.lblLocation.text = decodedData.data?.hotelVenue ?? "Data will be added soon"
                                self.lblRoomnumber.text = "Room No.: \(decodedData.data?.roomNumber ?? "Data will be added soon")"
                                self.lblroomPatner.text = "Room Partner: \(decodedData.data?.partner1 ?? "Data will be added soon"), \(decodedData.data?.partner2 ?? "")"
                                self.lblHotelName.text = decodedData.data?.hotelName ?? "Data will be added soon"
                                
                                if let events = decodedData.data?.events {
                                    for event in events {
                                        if let eventname = event.eventName {
                                            print("eventname: \(eventname)")
                                            
                                            self.eventname = eventname
                                            
                                        } else {
                                            print("eventDescription: N/A")
                                        }
                                    }
                                } else {
                                    print("No events found.")
                                }
                                self.lbleventName.text = self.eventname
                                
                                print("firstName::",decodedData.data?.firstName ?? "")
                                print("location::",decodedData.data?.hotelVenue ?? "")
                                print("roomNumber::",decodedData.data?.roomNumber ?? "")
                                print("partner1::",decodedData.data?.partner1 ?? "")
                                print("partner1::",decodedData.data?.hotelName ?? "")
                                
                            } else if status == 2 {
                                self.showAlert(withMsg: decodedData.message ?? "")
                            } else {
                                self.showAlert(withMsg: msg)
                            }
                        }
                        //                        }
                    } catch {
                        print("on decoding catch", error)
                    }
                }
            }
        }
    }
    // MARK: - Actions
    @IBAction func actionButton(_ sender: UIButton) {
        RootControllerProxy.shared.setRoot(SelectEventVC.typeName, StoryBoard.main)
    }
    @IBAction func actionLogOut(_ sender: UIButton) {
        RootControllerProxy.shared.setRoot(LoginVC.typeName, StoryBoard.main)
    }
}
