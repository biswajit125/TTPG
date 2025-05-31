//
//  SelectEventVC.swift
//  Event_Guest
//
//  Created by Bishwajit Kumar on 07/04/25.
//

import UIKit

class SelectEventVC: UIViewController {
    // MARK: - Outlet
    @IBOutlet weak var collVw: UICollectionView!
    @IBOutlet weak var contHeightlbl: NSLayoutConstraint!
    
    
   // var events: VerifyOTPResponseData = VerifyOTPResponseData()
    var events: GuestDetailsResponseModel = GuestDetailsResponseModel()
    var guestId : String = ""
   // var eventId : String = ""
    var eventID : String = ""
    var token : String = ""
    
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collVw.register(UINib(nibName: "SelectEventCVC", bundle: nil), forCellWithReuseIdentifier: "SelectEventCVC")
        collVw.reloadData()
        DispatchQueue.main.async {
            self.updateCollectionHeight()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let token = UserDefaultsManager.shared.getValue(forKey: .token) as? String {
            print("SelectEventVC token: \(token)")
            self.token = token
           
        } else {
            print("SelectEventVC token not found")
        }
        
        
        get_event_by_guest(token: token)
        collVw.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if collVw.numberOfItems(inSection: 0) == 1 {
            let contentHeight = collVw.collectionViewLayout.collectionViewContentSize.height
            collVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            collVw.contentInset = .zero
        }
    }
    
    private func updateCollectionHeight() {
        let itemCount = collVw.numberOfItems(inSection: 0)
        if itemCount > 2 {
            contHeightlbl.constant = 100
        } else {
            contHeightlbl.constant = collVw.collectionViewLayout.collectionViewContentSize.height
        }
        view.layoutIfNeeded()
    }
    // MARK: - Action
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
                   //  self.events = decodedData
                    print("decodedData:::",decodedData)
                    
                    DispatchQueue.main.async {
                        self.events = decodedData
                        self.collVw.reloadData()
                    }
                    
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
                               // self.navigationController?.pushViewController(nextvc, animated: true)
                               // self.collVw.reloadData()
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
}
// MARK: - UICollectionView
extension SelectEventVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.data?.events?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectEventCVC", for: indexPath) as! SelectEventCVC
        cell.lblEventName.text = events.data?.events?[indexPath.row].eventName //events.events?[indexPath.row].eventName//events[indexPath.row].events?[indexPath.row].eventName//events[indexPath.row].eventName ?? ""//event.eventName ?? "Unknown Event"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = StoryBoard.tab.instantiateViewController(withIdentifier: RoundedTabbarController.typeName) as! RoundedTabbarController
        let eventId = events.data?.events?[indexPath.row].eventID ?? ""//events.events?[indexPath.row].eventID ?? ""//events[indexPath.row].events?[indexPath.row].eventID ?? ""//events[indexPath.row].eventID ?? ""
        let guestId = events.data?.guestID ?? ""//events[indexPath.row].guestID ?? ""
        print("eventId::",eventId)
        print("guestId::",guestId)
        UserDefaultsManager.shared.saveValue(eventId, forKey: .eventId)
        UserDefaultsManager.shared.saveValue(guestId, forKey: .guestId)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
