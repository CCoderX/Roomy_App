//
//  roomCustomCell.swift
//  Roomy_app
//
//  Created by user on 7/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class RoomCustomCell: UITableViewCell {
    
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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func putValues(initializerRoom: RoomModel) {
        costLabel.text = initializerRoom.price
        addressLabel.text = initializerRoom.place
        firstImage.kf.setImage(
            with: URL(string: initializerRoom.image ?? "https://images.app.goo.gl/HkiGXXzn47c69SzY6"),
            placeholder: UIImage(named: "Logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        hotelLabel.text = initializerRoom.descriptionText
    }
}
