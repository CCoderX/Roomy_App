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
    
    var rooms = [RoomModel]()
    
    @IBOutlet private weak var roomsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RoomsParser.fetchRooms(){result , success in
            if success {
                self.rooms = result
                self.roomsTableView.reloadData()
            }
            else {
                let alert = UIAlertController(title: "Error in downloading rooms", message: "Try again ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (alert) in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        UserDefaults.standard.set("" ,forKey: "token")
        dismiss(animated: true, completion: nil)
    }
}
extension RoomsViewController : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell") as! RoomCustomCell
        cell.putValues(initializerRoom: rooms[indexPath.row]) 
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        roomsTableView.isHidden = rooms.isEmpty
        return rooms.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        RoomDetailViewController.room = rooms[indexPath.row]
        performSegue(withIdentifier: "roomDetailsSegue", sender: nil)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/4
    }
    
}

