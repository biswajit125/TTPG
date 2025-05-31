//
//  LtineraryVC.swift
//  Event_Guest
//
//  Created by Bishwajit Kumar on 07/04/25.
//

import UIKit

class LtineraryVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var vwWedding: UIView!
    @IBOutlet weak var vwToday: UIView!
    @IBOutlet weak var lblWedding: UILabel!
    @IBOutlet weak var lblToday: UILabel!
    @IBOutlet weak var imgLtinerary: UIImageView!
    @IBOutlet weak var contHeightImg: NSLayoutConstraint!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var contTopDate: NSLayoutConstraint!
    @IBOutlet weak var contBottomDate: NSLayoutConstraint!
    @IBOutlet weak var contImage: NSLayoutConstraint!
    
    // MARK: - Properties
    var isShowingFriendlies = false
    var eventId : String = ""
    var guestId : String = ""
    var token : String = ""
    var eventResponseModel: EventResponseModel? = nil
    var eventTodayResponseModel : EventTodayResponseModel? = nil
    var eventDate : String = ""
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        vwWedding.backgroundColor = AppColor.app_ColorWhiteTrans
        lblWedding.textColor = AppColor.app_ColorDrakBlue
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.showsHorizontalScrollIndicator = false
        tblVw.showsVerticalScrollIndicator = false
        
        tblVw.register(UINib(nibName: "WeddingLtineraryTVC", bundle: nil), forCellReuseIdentifier: "WeddingLtineraryTVC")
        tblVw.register(UINib(nibName: "TodayLtineraryTVC", bundle: nil), forCellReuseIdentifier: "TodayLtineraryTVC")
   
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
        if let token = UserDefaultsManager.shared.getValue(forKey: .token) as? String {
            print("token: \(token)")
            self.token = token
           
        } else {
            print("token not found")
        }
        
        if isShowingFriendlies {
           
            self.imgLtinerary.isHidden = false
            self.contHeightImg.constant = 0
            self.lblDate.isHidden = false
            self.contTopDate.constant = 30
            self.contBottomDate.constant = 30
            self.contImage.constant = 10
            get_event_today(eventId: eventId, token: token)
            tblVw.reloadData()
        }else {
            self.vwWedding.borderColor = AppColor.app_ColorLightblue
            self.vwWedding.borderWidth = 1.0
            self.imgLtinerary.isHidden = true
            self.contHeightImg.constant = 0
            self.lblDate.isHidden = true
            self.contTopDate.constant = 0
            self.contBottomDate.constant = 0
            self.contImage.constant = 0
            get_event(eventId: eventId, token: token)
            tblVw.reloadData()
           
        }
        
        
       
    }
    
    // MARK: - Actions
    @IBAction func actionPlayType(_ sender: UIButton) {
        let buttonTag = sender.tag
        print("buttonTag::", buttonTag)
        if buttonTag == 1 {
            isShowingFriendlies = true
            self.imgLtinerary.isHidden = false
            self.contHeightImg.constant = 0
            self.lblDate.isHidden = false
            self.contTopDate.constant = 30
            self.contBottomDate.constant = 30
            self.contImage.constant = 10
            vwToday.backgroundColor = AppColor.app_ColorWhiteTrans
            vwWedding.backgroundColor = .clear
            
            self.vwToday.borderColor = AppColor.app_ColorLightblue
            self.vwToday.borderWidth = 1.0
            self.vwWedding.borderColor = .clear
            self.vwWedding.borderWidth = 0.0
            // lblToday.font = UIFont(name: AppFont.bold.rawValue, size: 12)
            // lblWedding.font = UIFont(name: AppFont.regular.rawValue, size: 12)
            lblToday.textColor = AppColor.app_ColorDrakBlue
            lblWedding.textColor = .black
           get_event_today(eventId: eventId, token: token)
        } else {
            isShowingFriendlies = false
            self.imgLtinerary.isHidden = true
            self.contHeightImg.constant = 0
            self.lblDate.isHidden = true
            self.contTopDate.constant = 0
            self.contBottomDate.constant = 30
            self.contImage.constant = 0
            vwWedding.backgroundColor = AppColor.app_ColorWhiteTrans
            //lblWedding.font = UIFont(name: AppFont.bold.rawValue, size: 12)
            //lblToday.font = UIFont(name: AppFont.regular.rawValue, size: 12)
            vwToday.backgroundColor = .clear
            self.vwWedding.borderColor = AppColor.app_ColorLightblue
            self.vwWedding.borderWidth = 1.0
            self.vwToday.borderColor = .clear
            self.vwToday.borderWidth = 0.0
            
            lblWedding.textColor = AppColor.app_ColorDrakBlue
            lblToday.textColor = .black
            get_event(eventId: eventId, token: token)
        }
        tblVw.reloadData()
    }
    
    
    
    func get_event(eventId: String,token:String) {
        WebServiceCalls.shared.anyMethodApiCall(endPoint: "hotel/event/\(eventId)", method: "GET", body: [:],token: token) { msg, status, data in
            DispatchQueue.main.async {
                //self.btnSubmit.isLoading = false
                //                self.removeLoader(loader: loader) {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(EventResponseModel.self, from: data)
                      
                        
                        DispatchQueue.main.async {
                            self.eventResponseModel = decodedData
                            self.tblVw.reloadData()
                        }
                        
                        //                        DispatchQueue.main.async {
                        DispatchQueue.main.async {
                            if status == 1 {
                              
                                
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
    
    
    func get_event_today(eventId: String,token:String) {
        WebServiceCalls.shared.anyMethodApiCall(endPoint: "hotel/event/\(eventId)/today", method: "GET", body: [:],token: token) { msg, status, data in
            DispatchQueue.main.async {
                //self.btnSubmit.isLoading = false
                //                self.removeLoader(loader: loader) {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(EventTodayResponseModel.self, from: data)
                        //                        DispatchQueue.main.async {
                        
                        DispatchQueue.main.async {
                            self.eventTodayResponseModel = decodedData
                            
                            self.tblVw.reloadData()
                            self.lblDate.text = self.eventDate
                        }
                      
                       // self.lblDate.text = decodedData.eventTodayResponseModel?.data?.programs. ?? ""
                        DispatchQueue.main.async {
                            if status == 1 {
                              
                                
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
}
// MARK: - UITableView
extension LtineraryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowingFriendlies {
            let count = eventTodayResponseModel?.data?.programs?.count ?? 0
            return count
        } else {
            let count = eventResponseModel?.data?.programs?.count ?? 0
            return count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isShowingFriendlies {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayLtineraryTVC", for: indexPath) as! TodayLtineraryTVC
            if let programs = eventTodayResponseModel?.data?.programs, indexPath.row < programs.count {
                     self.eventDate = "\(programs[indexPath.row].startDate ?? "")"
                 } else {
                     self.eventDate = "" // Handle gracefully if the index is out of bounds
                 }
            cell.lblEvent.text = eventTodayResponseModel?.data?.programs?[indexPath.row].functionName ?? ""
            cell.lbldateAndTime.text = "\(eventTodayResponseModel?.data?.programs?[indexPath.row].startTime ?? "") - \(eventTodayResponseModel?.data?.programs?[indexPath.row].endTime ?? "")"
            cell.lblFemaleDressCode.text = eventTodayResponseModel?.data?.programs?[indexPath.row].dressCDFemale ?? "-"//"\(eventTodayResponseModel?.data?.programs?[indexPath.row].dressCDMale ?? "-") & \(eventTodayResponseModel?.data?.programs?[indexPath.row].dressCDFemale ?? "-")"
            cell.lblMaleDresscode.text = eventTodayResponseModel?.data?.programs?[indexPath.row].dressCDMale ?? "-"
            cell.lblLocation.text = eventTodayResponseModel?.data?.programs?[indexPath.row].venue ?? ""
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeddingLtineraryTVC", for: indexPath) as! WeddingLtineraryTVC
            let date = eventResponseModel?.data?.programs?[indexPath.row].date ?? ""
            print("date::",date)
            cell.lblDate.text = "\(eventResponseModel?.data?.programs?[indexPath.row].day ?? "") - \(eventResponseModel?.data?.programs?[indexPath.row].date ?? "")"
            cell.lblCeremony.text = eventResponseModel?.data?.programs?[indexPath.row].functionName ?? ""
            cell.lblTime.text = "\(eventResponseModel?.data?.programs?[indexPath.row].startTime ?? "") - \(eventResponseModel?.data?.programs?[indexPath.row].endTime ?? "")"
            cell.lblLocation.text = eventResponseModel?.data?.programs?[indexPath.row].venue ?? ""
            let totalRows = tableView.numberOfRows(inSection: indexPath.section)
            if indexPath.row == totalRows - 1 {
                cell.imgLine.isHidden = true // Hide for last row
            } else {
                cell.imgLine.isHidden = false // Show for others
             
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextvc = self.storyboard?.instantiateViewController(withIdentifier: "MehendiCeremonyVC") as! MehendiCeremonyVC
        
        if isShowingFriendlies {
            nextvc.functionName = eventTodayResponseModel?.data?.programs?[indexPath.row].functionName ?? ""
            nextvc.date = eventTodayResponseModel?.data?.programs?[indexPath.row].startDate ?? ""
            nextvc.time = "\(eventTodayResponseModel?.data?.programs?[indexPath.row].startTime ?? "") - \(eventTodayResponseModel?.data?.programs?[indexPath.row].endTime ?? "")"
           // nextvc.dressCode = "\(eventTodayResponseModel?.data?.programs?[indexPath.row].dressCDMale ?? "-") & \(eventTodayResponseModel?.data?.programs?[indexPath.row].dressCDFemale ?? "-")"
            nextvc.femaledressCode = eventTodayResponseModel?.data?.programs?[indexPath.row].dressCDFemale ?? "NA"
            nextvc.maledressCode = eventTodayResponseModel?.data?.programs?[indexPath.row].dressCDMale ?? "NA"
            nextvc.notes = eventTodayResponseModel?.data?.programs?[indexPath.row].remarks ?? ""
            nextvc.location = eventTodayResponseModel?.data?.programs?[indexPath.row].remarks ?? ""
            
        } else {
            nextvc.functionName = eventResponseModel?.data?.programs?[indexPath.row].functionName ?? ""
            nextvc.date = eventResponseModel?.data?.programs?[indexPath.row].date ?? ""
            nextvc.time = "\(eventResponseModel?.data?.programs?[indexPath.row].startTime ?? "") - \(eventResponseModel?.data?.programs?[indexPath.row].endTime ?? "")"
         //   nextvc.dressCode = "\(eventResponseModel?.data?.programs?[indexPath.row].dressCDMale ?? "-") & \(eventResponseModel?.data?.programs?[indexPath.row].dressCDFemale ?? "-")"
            nextvc.femaledressCode = eventResponseModel?.data?.programs?[indexPath.row].dressCDFemale ?? "NA"
            nextvc.maledressCode = eventResponseModel?.data?.programs?[indexPath.row].dressCDMale ?? "NA"
            nextvc.notes = eventResponseModel?.data?.programs?[indexPath.row].remarks ?? ""
            nextvc.location = eventResponseModel?.data?.programs?[indexPath.row].venue ?? ""
        }
        self.navigationController?.pushViewController(nextvc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220.0
    }
}
