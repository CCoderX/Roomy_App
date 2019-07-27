//
//  roomCustomCell.swift
//  Roomy_app
//
//  Created by user on 7/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class roomCustomCell: UITableViewCell {

    
    @IBOutlet weak var bathsLabel: UILabel!
    @IBOutlet weak var bedsLabel: UILabel!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var hotelLabel: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func addRoomDataToCell(room : roomClass){
        self.addressLabel.text = room.place
        self.hotelLabel.text = room.place
        self.costLabel.text = String(room.price ?? 0)+"$"
//        self.firstImage.image = room.getImages()[0]
//        self.secondImage.image = room.getImages()[1]
//        self.thirdImage.image = room.getImages()[2]
 //       self.bedsLabel.text = String(room.getNumberOfBeds()) + " beds"
   //     self.bathsLabel.text = String(room.getNumberOfBaths())+" $"
        
    }

}
