//
//  RoomsViewController.swift
//  Roomy_app
//
//  Created by user on 7/25/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import Realm
import Kingfisher
class RoomsViewController: UIViewController {

    var rooms = [roomModel()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        rooms = Array( realm.objects(roomModel.self))
        print(rooms.count)
        roomsParser.getRooms()
        }
    

    @IBAction func signOutPressed(_ sender: Any) {
        UserDefaults.standard.set("" ,forKey: "token")
        dismiss(animated: true, completion: nil)
    }
}
extension RoomsViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell") as! roomCustomCell
        cell.addressLabel.text = rooms[indexPath.row].descriptionText
        cell.costLabel.text = rooms[indexPath.row].price
        cell.hotelLabel.text = rooms[indexPath.row].place
        cell.addressLabel.text = rooms[indexPath.row].place
        cell.firstImage.kf.setImage(
            with: URL(string: rooms[indexPath.row].image ?? "https://images.app.goo.gl/HkiGXXzn47c69SzY6"),
            placeholder: UIImage(named: "Logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        roomDetailViewController.room = rooms[indexPath.row]
        performSegue(withIdentifier: "roomDetailsSegue", sender: nil)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/4
    }
    
}

