//
//  AllGuestVC.swift
//  Event_GuestApp
//
//  Created by Prashant Kumar on 05/05/25.
//

import UIKit

class AllGuestVC: UIViewController {
    
    
    @IBOutlet weak var tblVw: UITableView!
    
    var flightHostResponseModel : FlightHostResponseModel?
    var token : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.register(UINib(nibName: "AllGuestTVC", bundle: nil), forCellReuseIdentifier: "AllGuestTVC")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let token = UserDefaultsManager.shared.getValue(forKey: .token) as? String {
            print("token: \(token)")
            self.token = token
           
        } else {
            print("token not found")
        }
        flight_host(token: token)
        
    }
    
    
    
    func flight_host(token: String) {
        WebServiceCalls.shared.anyMethodApiCall(endPoint: "flight/host", method: "GET", body: [:],token: token) { msg, status, data in
            DispatchQueue.main.async {
                //self.btnSubmit.isLoading = false
                //                self.removeLoader(loader: loader) {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(FlightHostResponseModel.self, from: data)
                        //                        DispatchQueue.main.async {
                        
                        DispatchQueue.main.async {
                            self.flightHostResponseModel = decodedData
                            self.tblVw.reloadData()
                        }
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

extension AllGuestVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Adding 1 for the header row
        return (flightHostResponseModel?.data?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGuestTVC", for: indexPath) as! AllGuestTVC
        
        if indexPath.row == 0 {
            // Header row styling
            cell.vwParent.backgroundColor = UIColor(named: "app_Color_Skin")
            cell.roundCorners(corners: [.topLeft, .topRight], radius: 4)
            cell.lblGuestName.text = "Guest Name"
            cell.lblHotel.text = "Hotel"
            cell.lblRoomNumber.text = "Room No."
        } else {
            // Safely fetch guest data (adjust index for 0-based array)
            cell.vwParent.backgroundColor = .white
            let guestIndex = indexPath.row - 1
            
            if let guestData = flightHostResponseModel?.data, guestIndex < guestData.count {
                let guest = guestData[guestIndex]
                cell.lblGuestName.text = guest.firstName ?? "NA"
                cell.lblHotel.text = guest.hotelName ?? "-"
                cell.lblRoomNumber.text = guest.roomNumber ?? "-"
            } else {
                // Fallback in case of unexpected error
                cell.lblGuestName.text = "N/A"
                cell.lblHotel.text = "-"
                cell.lblRoomNumber.text = "-"
            }
        }

        // Apply bottom corner styling to the last cell
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 4)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection (Modify as needed)
        // let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MehendiCeremonyVC") as! MehendiCeremonyVC
        // self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
