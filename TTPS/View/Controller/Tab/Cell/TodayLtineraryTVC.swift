//
//  TodayLtineraryTVC.swift
//  Event_Guest
//
//  Created by Bishwajit Kumar on 07/04/25.
//

import UIKit

class TodayLtineraryTVC: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lbldateAndTime: UILabel!
    @IBOutlet weak var lblFemaleDressCode: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblMaleDresscode: UILabel!
    
    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
