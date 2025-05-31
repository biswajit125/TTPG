//
//  NeedAssistanceTVC.swift
//  Event_Guest
//
//  Created by Bishwajit Kumar on 07/04/25.
//

import UIKit

class NeedAssistanceTVC: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventNumber: UILabel!
    
    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
