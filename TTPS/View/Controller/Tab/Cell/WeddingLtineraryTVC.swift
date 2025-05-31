//
//  WeddingLtineraryTVC.swift
//  Event_Guest
//
//  Created by Bishwajit Kumar on 07/04/25.
//

import UIKit

class WeddingLtineraryTVC: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var imgLine: UIImageView!
    @IBOutlet weak var lblCeremony: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
