//
//  LoginVC.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 09/04/25.
//

import UIKit

class LoginVC: UIViewController,AlertProtocol {
    // MARK: - Outlet
    @IBOutlet weak var txtFldFirstName: UITextField!
    @IBOutlet weak var txtFldPhoneNumber: UITextField!
    
    var eventID : String = ""
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        txtFldFirstName.text = "host"//"KD"//"Bishwajit" //"Biru"//"KD"
//        txtFldPhoneNumber.text = "9932547854"//"7545241278"//"9304369747" //"7602155991"//"7545241278"
        
    }
    // MARK: - Action
    @IBAction func actionLogin(_ sender: LoaderButton) {
        // let nextvc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTPVC") as! VerifyOTPVC
        //  self.navigationController?.pushViewController(nextvc, animated: true)
        guard let firstname = txtFldFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines), !firstname.isEmpty else {
            showAlertWithText("Please enter a username.")
            return
        }
        guard let phoneNumber = txtFldPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines), !phoneNumber.isEmpty else {
            showAlertWithText("Please enter a password.")
            return
        }
        sender.isLoading = true
        login(sender, data1: txtFldFirstName.text ?? "", data2: txtFldPhoneNumber.text ?? "")
    }
    

//    func login(_ loaderBtn: LoaderButton, data1: String, data2: String) {
//        //        let body: [String:Any] = [
//        //            "data1" : txtFldFirstName.text ?? "",
//        //            "data2" : txtFldPhoneNumber.text ?? ""
//        //        ]
//        WebServiceCalls.shared.anyMethodApiCall(endPoint: "auth/general-login?data1=\(data1)&data2=\(data2)", method: "POST", body: [:]) { msg, status, data  in
//            DispatchQueue.main.async {
//                loaderBtn.isLoading = false
//                do {
//                    switch status {
//                    case 1 :
//                        print("Sucess")
////                        guard let data = data else { return }
////                        let decoder = JSONDecoder()
////                        let decodeddata = try decoder.decode(LoginResponseModel.self, from: data)
////                        print("token::",decodeddata.data?.token ?? "")
//                        
////                    UserDefaultsManager.shared.saveValue(decodeddata.data?.token ?? "", forKey: .token)
////                        self.get_event_by_guest(token: decodeddata.data?.token ?? "")
//                        
//                    case 2:
//                        guard let data = data else { return }
//                        let decoder = JSONDecoder()
//                        let decodeddata = try decoder.decode(LoginResponseModel.self, from: data)
//                        self.showAlert(withMsg: decodeddata.message ?? "Sorry, we couldn't log you in. Please review your username and password.")
//                    case 3:
//                        self.showAlert(withMsg: "Login Failed. Ensure your internet connection is stable and review your login details.")
//                    default:
//                        print("at default.will never execute")
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }
    
    func login(_ loaderBtn: LoaderButton, data1: String, data2: String) {
        WebServiceCalls.shared.anyMethodApiCall(endPoint: "auth/general-login?data1=\(data1)&data2=\(data2)", method: "POST", body: [:]) { msg, status, data in
            DispatchQueue.main.async {
                loaderBtn.isLoading = false
                do {
                    switch status {
                    case 1:
                        print("Success")
                       //  Uncomment and handle decoded data if needed
                         guard let data = data else { return }
                         let decoder = JSONDecoder()
                         let decodedData = try decoder.decode(LoginResponseModel.self, from: data)
                         print("Token:", decodedData.data?.token ?? "")
                        let roleName = decodedData.data?.roleName ?? ""
                        
                        
                        if roleName == "GUEST"{
                            print("GUEST token",decodedData.data?.token ?? "")
                            UserDefaultsManager.shared.saveValue(decodedData.data?.token ?? "", forKey: .token)
                            self.get_event_by_guest(token: decodedData.data?.token ?? "")
                        }
                        
                        if roleName == "HOST" {
                            print("HOST token",decodedData.data?.token ?? "")
                            UserDefaultsManager.shared.saveValue(decodedData.data?.token ?? "", forKey: .token)
                            UserDefaultsManager.shared.saveValue(decodedData.data?.firstName ?? "", forKey: .username)
                            //self.get_event_by_Host(token: decodedData.data?.token ?? "")
//                            let nextvc = self.storyboard?.instantiateViewController(withIdentifier: "RoundedTabController") as! RoundedTabController
//                            self.navigationController?.pushViewController(nextvc, animated: true)
                            
                            RootControllerProxy.shared.setRoot(RoundedTabController.typeName, StoryBoard.tab)
                        }
                         
                        
                    case 2:
                        guard let data = data else { return }
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(LoginResponseModel.self, from: data)
                        self.showAlert(withMsg: decodedData.message ?? "Sorry, we couldn't log you in. Please review your username and password.")
                    case 3:
                        self.showAlert(withMsg: "Login Failed. Ensure your internet connection is stable and review your login details.")
                        
                    default:
                        print("Unexpected default case; shouldn't be executed.")
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }
    }

    
    
    func get_event_by_guest(token: String) {
        WebServiceCalls.shared.anyMethodApiCall(endPoint: "auth/get-event-by-guest", method: "GET", body: [:],token: token) { msg, status, data in
            DispatchQueue.main.async {
                guard let data = data else {
                    self.showAlert(withMsg: msg)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(GuestDetailsResponseModel.self, from: data)
                    print("decodedData:::",decodedData)
                    
                    if status == 1 {
//                        print(decodedData)
//
//                            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectEventVC") as! SelectEventVC
//                        nextVC.events = decodedData
//                       
//                            self.navigationController?.pushViewController(nextVC, animated: true)
                        
                        
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
                    print("Decoding error:", error.localizedDescription)
                }
            }
        }
    }
    
    
    
    func get_event_by_Host(token: String) {
        WebServiceCalls.shared.anyMethodApiCall(endPoint: "auth/get-event-by-guest", method: "GET", body: [:],token: token) { msg, status, data in
            DispatchQueue.main.async {
                guard let data = data else {
                    self.showAlert(withMsg: msg)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(GuestDetailsResponseModel.self, from: data)
                    print("decodedData:::",decodedData)
                    
                    if status == 1 {
//                        print(decodedData)
//
//                            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectEventVC") as! SelectEventVC
//                        nextVC.events = decodedData
//
//                            self.navigationController?.pushViewController(nextVC, animated: true)
                        
                        
//                        if let events = decodedData.data?.events {
//                            if events.count > 1 {
                              //  print("More than one event found.")
                        let nextvc = self.storyboard?.instantiateViewController(withIdentifier: "RoundedTabController") as! RoundedTabController
                                
                               
                                
                               // nextvc.events = decodedData.data ?? VerifyOTPResponseData()
                                //nextvc.guestId = decodedData.data?.guestID ?? ""
                                
                                UserDefaultsManager.shared.saveValue(decodedData.data?.guestID ?? "", forKey: .guestId)
//                                if let events = decodedData.data?.events {
//                                    for event in events {
//                                        if let eventID = event.eventID {
//                                            print("eventID: \(eventID)")
//                                            
//                                            self.eventID = eventID
//                                            UserDefaultsManager.shared.saveValue(self.eventID, forKey: .eventId)
//                                        } else {
//                                            print("eventID: N/A")
//                                        }
//                                    }
//                                } else {
//                                    print("No eventID found.")
//                                }
                                self.navigationController?.pushViewController(nextvc, animated: true)
                                
                          //  }
//                            else if events.count == 1 {
//                                print("Only one event found.")
//                              
//                            
//                                UserDefaultsManager.shared.saveValue(decodedData.data?.guestID ?? "", forKey: .guestId)
//                               
//                                if let events = decodedData.data?.events {
//                                    for event in events {
//                                        if let eventID = event.eventID {
//                                            print("eventID: \(eventID)")
//                                            
//                                            self.eventID = eventID
//                                            UserDefaultsManager.shared.saveValue(self.eventID, forKey: .eventId)
//                                        } else {
//                                            print("eventID: N/A")
//                                        }
//                                    }
//                                } else {
//                                    print("No eventID found.")
//                                }
//                                RootControllerProxy.shared.setRoot(RoundedTabbarController.typeName, StoryBoard.tab)
//                               
//                            }
//                            else {
//                                print("No eventID found.")
//                            }
                            
                      //  }
                       // }
                    } else if status == 2 {
                        self.showAlert(withMsg: decodedData.message ?? "")
                    } else {
                        self.showAlert(withMsg: msg)
                    }
                    
                } catch {
                    print("Decoding error:", error.localizedDescription)
                }
            }
        }
    }
}

