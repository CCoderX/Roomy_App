//
//  roomDetailViewController.swift
//  Roomy_app
//
//  Created by user on 7/27/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class RoomDetailViewController: UIViewController {

    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var roomDetails: UITextView!
    
    static var room : roomModel = roomModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomImage.kf.setImage(
            with: URL(string: RoomDetailViewController.room.image ?? "https://images.app.goo.gl/HkiGXXzn47c69SzY6"),
            placeholder: UIImage(named: "Logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        roomDetails.text = RoomDetailViewController.room.descriptionText
    }

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
