//
//  HomeHostVC.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 29/04/25.
//

import UIKit


class HomeHostVC: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var lblUsername: UILabel!
    
    var hostGuestSummaryResponseModel: HostGuestSummaryResponseModel?
    var token : String = ""
    var username : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwTop.layer.cornerRadius = 20
        vwTop.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        vwTop.layer.masksToBounds = true
        

        tblVw.register(UINib(nibName: "HomeTVC", bundle: nil), forCellReuseIdentifier: "HomeTVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let token = UserDefaultsManager.shared.getValue(forKey: .token) as? String {
            print("token: \(token)")
            self.token = token
           
        } else {
            print("token not found")
        }
        
        if let username = UserDefaultsManager.shared.getValue(forKey: .username) as? String {
            print("username: \(username)")
            self.username = username
            self.lblUsername.text = username
           
        } else {
            print("username not found")
        }
        
        host_guest_summary(token: token)
        
    }
    
    @IBAction func actionLogOut(_ sender: Any) {
        RootControllerProxy.shared.setRoot(LoginVC.typeName, StoryBoard.main)
    }
    
    func host_guest_summary(token: String) {
        WebServiceCalls.shared.anyMethodApiCall(endPoint: "flight/host/guest-summary", method: "GET", body: [:],token: token) { msg, status, data in
            DispatchQueue.main.async {
                //self.btnSubmit.isLoading = false
                //                self.removeLoader(loader: loader) {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(HostGuestSummaryResponseModel.self, from: data)
                        //                        DispatchQueue.main.async {
                        print("decodedData::::",decodedData)
                        DispatchQueue.main.async {
                            self.hostGuestSummaryResponseModel = decodedData
                            print("decodedData::::",decodedData)
                            self.tblVw.reloadData()
                        }
                        DispatchQueue.main.async {
                            if status == 1 {
                              //  self.lblUsername.text = decodedData.data?.firstName ?? ""
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

extension HomeHostVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let count = 4
            return count

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVC", for: indexPath) as! HomeTVC
        
        if indexPath.row == 0 {
            cell.img.image = UIImage(named: "ic_GuestInvited")
            cell.lblTitle.text = "Total Invited Guests"
            cell.lblCount.text = String(hostGuestSummaryResponseModel?.data?.totalInvitedGuest ?? 0)
            print("totalInvitedGuest :", hostGuestSummaryResponseModel?.data?.totalInvitedGuest)
            
        }else if indexPath.row == 1 {
            cell.img.image = UIImage(named: "ic_GuestArrived")
            cell.lblTitle.text = "Arrived Guests"
            cell.lblCount.text = String(hostGuestSummaryResponseModel?.data?.arrivedGuest ?? 0)
            
        }else if indexPath.row == 2{
            cell.img.image = UIImage(named: "ic_GuestNotArrived")
            cell.lblTitle.text = "Not Arrived Guests"
            cell.lblCount.text = String(hostGuestSummaryResponseModel?.data?.notArrivedGuest ?? 0)
            
        }else {
            cell.img.image = UIImage(named: "ic_CheckedIn")
            cell.lblTitle.text = "Checked-in Percentage"
//            cell.lblCount.text = String(hostGuestSummaryResponseModel?.data?.checkedInPercentage ?? 0)
            let percentage = hostGuestSummaryResponseModel?.data?.checkedInPercentage ?? 0
            cell.lblCount.text = String(format: "%.2f% %", percentage)
            
        }
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    
}
