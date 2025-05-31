//
//  AllGuestTVC.swift
//  Event_GuestApp
//
//  Created by Prashant Kumar on 05/05/25.
//

import UIKit

class AllGuestTVC: UITableViewCell {
    
    
    @IBOutlet weak var vwParent: UIView!
    @IBOutlet weak var lblGuestName: UILabel!
    @IBOutlet weak var lblHotel: UILabel!
    @IBOutlet weak var lblRoomNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
          let path = UIBezierPath(roundedRect: vwParent.bounds,
                                  byRoundingCorners: corners,
                                  cornerRadii: CGSize(width: radius, height: radius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          vwParent.layer.mask = mask
        
        
        // Create border layer
        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.frame = vwParent.bounds
        borderLayer.strokeColor = UIColor.black.cgColor // Set border color
        borderLayer.fillColor = UIColor.clear.cgColor // Keep fill transparent
        borderLayer.lineWidth = 2 // Set border thickness

        vwParent.layer.addSublayer(borderLayer)
      }
    
}
