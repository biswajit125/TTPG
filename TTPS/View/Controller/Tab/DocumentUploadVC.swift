//
//  DocumentUploadVC.swift
//  Event_Guest
//
//  Created by Bishwajit Kumar on 08/04/25.
//
import UIKit
import iOSDropDown

class DocumentUploadVC: UIViewController,MediaPickerDelegate {
    // MARK: - Outlets
   
    
    @IBOutlet weak var selectEvent: UITextField!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var btnCross: UIButton!
    
    @IBOutlet weak var lblEventname: UILabel!
    
    var guestId : String = ""
    var eventId : String = ""
    var image: UIImage?
    
    // MARK: - Properties
    var eventArray : String = ""
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        MediaPicker.shared.delegate = self
       // setupDropDown()
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
        getGuestDetails(eventId: eventId,guestId: guestId)
    }
    
    
    private func setupDropDown() {
        imgVw.isHidden = true
       // dropDown.optionArray = eventArray
       // dropDown.placeholder = "Select Event"
        //dropDown.isSearchEnable = true
       // dropDown.arrowSize = 15
        //dropDown.selectedRowColor = .systemGray5
        //dropDown.didSelect { [weak self] (selectedText, index, id) in
          //  print("Selected: \(selectedText) at index: \(index)")
       // }
    }
    
    
    // MARK: - Actions
    @IBAction func actionFileUpload(_ sender: Any) {
        MediaPicker.shared.openActionSheetForImagePicker()
    }
  
    
    @IBAction func actionCross(_ sender: Any) {
       // self.image?.images == ""
        self.imgVw.isHidden = true
        self.btnCross.isHidden = true
    
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        if let guestId = UserDefaultsManager.shared.getValue(forKey: .guestId) as? String {
            print("guestId: \(guestId)")
        } else {
            print("guestId not found")
        }
        if let eventId = UserDefaultsManager.shared.getValue(forKey: .eventId) as? String {
            print("eventId: \(eventId)")
        } else {
            print("guestId not found")
        }
        updateGuestIdProof(guestId: guestId, eventId: eventId)
    }
    
    // MARK: - Image Picker Delegate Methods
    func mediaPicker(_ mediaPicker: MediaPicker, didChooseImage image: UIImage?, imageName: String?) {
        if let selectedImage = image {
            self.image = selectedImage
            self.imgVw.isHidden = false
            self.btnCross.isHidden = false
            self.imgVw.image = selectedImage
            print("image: \(selectedImage)")
            print("imageName: \(imageName ?? "")")
        }
    }
    
//    func getGuestDetails(eventId: String, guestId: String) {
//        WebServiceCalls.shared.anyMethodApiCall(
//            endPoint: "hotel/getGuestDetails?eventId=\(eventId)&guestId=\(guestId)",
//            method: "GET",
//            body: [:]
//        ) { [weak self] msg, status, data in
//            DispatchQueue.main.async {
//                guard let self = self else { return }
//                if let data = data {
//                    do {
//                        let decoder = JSONDecoder()
//                        let decodedData = try decoder.decode(GuestDetailsResponseModel.self, from: data)
//                        if status == 1 {
////                            if let events = decodedData.data?.events {
////                              
////                                self.selectEvent.text = events[<#Int#>].eventName
////                            } else {
////                                print("No events found.")
////                            }
//                            
//                        } else {
//                            self.showAlert(withMsg: decodedData.message ?? msg)
//                        }
//                    } catch {
//                        print("Decoding error:", error)
//                    }
//                }
//            }
//        }
//    }
    
    func getGuestDetails(eventId: String, guestId: String) {
        WebServiceCalls.shared.anyMethodApiCall(
            endPoint: "hotel/getGuestDetails?eventId=\(eventId)&guestId=\(guestId)",
            method: "GET",
            body: [:]
        ) { [weak self] msg, status, data in
            DispatchQueue.main.async {
                guard let self = self else { return }

                guard let data = data else {
                    print("Error: No data received.")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(GuestDetailsResponseModel.self, from: data)
                    
                    if status == 1, let events = decodedData.data?.events, !events.isEmpty {
                        self.selectEvent.text = events.first?.eventName ?? "No event name available"
                        self.lblEventname.text = events.first?.eventName ?? "No event name available"
                    } else {
                        self.showAlert(withMsg: decodedData.message ?? msg)
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }
    }

    
    func updateGuestIdProof(guestId: String, eventId: String) {
        guard let selectedImage = self.image,
              let fileData = selectedImage.jpegData(compressionQuality: 0.5) else {
            self.showAlert(withMsg: "Please select an image to upload.")
            return
        }
        let params: [[String: Any]] = [
            [
                "key": "file",
                "value": fileData,
                "type": "file"
            ]
        ]
        WebServiceCalls.shared.multiPartFileUpload(
            endPoint: "flight/updateGuestIdProof?guestId=\(guestId)&eventId=\(eventId)",
            method: "PUT",
            body: params,
            filename: "guest_id_proof"
        ) { [weak self] msg, status, data in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if status == 1 {
                    self.showAlertWithAction(msg: "Updated successfully.") {
                        
                        self.imgVw.image = nil
                        self.btnCross.isHidden = true
                    }
                } else {
                    self.showAlert(withMsg: msg)
                }
            }
        }
    }
}
