//
//  MehendiCeremonyVC.swift
//  Event_GuestApp
//
//  Created by Bishwajit Kumar on 28/04/25.
//

import UIKit

class MehendiCeremonyVC: UIViewController {
    
    @IBOutlet weak var lblFunctionName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblFemaleDressCode: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblMaleDressCode: UILabel!
    
    var functionName : String = ""
    var femaledressCode : String = "NA"
    var maledressCode : String = "NA"
    var notes : String = "NA"
    var location : String = ""
    var date : String = ""
    var time : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FinctionName :::",functionName)
        print("femaledressCode :::",femaledressCode)
        print("maledressCode :::",maledressCode)
        print("notes :::",notes)
        print("location :::",location)
        print("date :::",date)
        print("time :::",time)
        
        DispatchQueue.main.async {
            self.lblFunctionName.text = self.functionName
            self.lblFemaleDressCode.text = self.femaledressCode
            self.lblMaleDressCode.text = self.maledressCode
            self.lblNotes.text = self.notes
            self.lblLocation.text = self.location
            self.lblDate.text = self.date
            self.lblTime.text = self.time
        }
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        popToBack()
    }
    
}
