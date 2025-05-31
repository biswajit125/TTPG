//
//  VerifyOTPVC.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 09/04/25.
//

import UIKit

class VerifyOTPVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblOTPStatus: UILabel!
    @IBOutlet weak var txtFldOTP: UITextField!
    
    
    var guestMobile : String = ""
    var firstName : String = ""
    var eventID : String = ""
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblOTPStatus.text = "Enter the OTP sent to \(guestMobile)"
    }
    // MARK: - Actions
    @IBAction func actionVerify(_ sender: Any) {
        guard let otp = txtFldOTP.text, !otp.isEmpty else {
            // Show an alert or handle empty OTP
            print("OTP field is empty.")
            return
        }
        validate_otp1(Otp: otp, Phone: guestMobile, firstName: firstName)
    }
    
    func validate_otp1(Otp: String,Phone: String,firstName:String) {
        WebServiceCalls.shared.anyMethodApiCall(endPoint: "auth/validate-otp?guestMobile=\(Phone)&otp=\(Otp)&firstName=\(firstName)", method: "POST", body: [:]) { msg, status, data in
            DispatchQueue.main.async {
                //self.btnSubmit.isLoading = false
                //                self.removeLoader(loader: loader) {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(VerifyOTPResponseModel.self, from: data)
                       
                        if status == 1 {
                           // self.showAlertWithAction(msg: decodedData.message ?? "") {
                                
                                if let events = decodedData.data?.events {
                                    if events.count > 1 {
                                        print("More than one event found.")
                                        let nextvc = self.storyboard?.instantiateViewController(withIdentifier: "SelectEventVC") as! SelectEventVC
                                        
                                        var hh = decodedData.data
                                        
                                       // nextvc.events = decodedData.data ?? VerifyOTPResponseData()
                                        nextvc.guestId = decodedData.data?.guestID ?? ""
                                        
                                        UserDefaultsManager.shared.saveValue(decodedData.data?.guestID ?? "", forKey: .guestId)
                                        if let events = decodedData.data?.events {
                                            for event in events {
                                                if let eventID = event.eventID {
                                                    print("eventID: \(eventID)")
                                                    
                                                    self.eventID = eventID
                                                    UserDefaultsManager.shared.saveValue(self.eventID, forKey: .eventId)
                                                } else {
                                                    print("eventID: N/A")
                                                }
                                            }
                                        } else {
                                            print("No eventID found.")
                                        }
                                        self.navigationController?.pushViewController(nextvc, animated: true)
                                        
                                    } else if events.count == 1 {
                                        print("Only one event found.")
                                      
                                    
                                        UserDefaultsManager.shared.saveValue(decodedData.data?.guestID ?? "", forKey: .guestId)
                                       
                                        if let events = decodedData.data?.events {
                                            for event in events {
                                                if let eventID = event.eventID {
                                                    print("eventID: \(eventID)")
                                                    
                                                    self.eventID = eventID
                                                    UserDefaultsManager.shared.saveValue(self.eventID, forKey: .eventId)
                                                } else {
                                                    print("eventID: N/A")
                                                }
                                            }
                                        } else {
                                            print("No eventID found.")
                                        }
                                        RootControllerProxy.shared.setRoot(RoundedTabbarController.typeName, StoryBoard.tab)
                                       
                                    } else {
                                        print("No eventID found.")
                                    }
                                    
                                }
                           // }
                        } else if status == 2 {
                            self.showAlert(withMsg: decodedData.message ?? "")
                        } else {
                            self.showAlert(withMsg: msg)
                        }
                    } catch {
                        print("on decoding catch", error)
                    }
                }
            }
        }
    }
}
