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

protocol RoomsView: class{
    func showAlert(title: String, message: String )
    func removeViewController()
    func navigateToRoomDetailViewController()
    func reloadTable()
}
protocol  RoomsPresenter: class {
    func signOut()
    func fetchrooms()
    func initCell(table :UITableView , indexPath : IndexPath) -> UITableViewCell?
    func preformCellSelected(index : IndexPath)
    func fetchRoomsNumber() -> Int
}
class RoomsPresenterImplementation: RoomsPresenter {
    
    weak var view: RoomsView?
    var rooms = [RoomModel]()
    init (view : RoomsView) {
        self.view = view
    }
    
    func fetchRoomsNumber() -> Int {
        if rooms != nil {
            return rooms.count
            print(rooms.count)
        }
        return 0
    }
    
    func preformCellSelected(index: IndexPath) {
        if rooms != nil {
            RoomDetailViewController.room = rooms[index.row]
        }
    }
    
    func fetchrooms() {
        RoomsParser.fetchRooms() {  result , success in
            if true {//success {
                self.rooms = result
                for _ in 0...3 {
                    self.rooms.append(RoomModel())
                }
                print(self.rooms.count)
                self.view?.reloadTable()
            }
            else {
                self.view?.removeViewController()
            }
        }
    }
    
    func initCell(table: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        let cell = table.dequeueReusableCell(withIdentifier: "roomCell") as! RoomCustomCell
        //cell.putValues(initializerRoom: rooms![indexPath.row])
        return cell
    }
    
    
    func signOut() {
        UserDefaults.standard.set("" ,forKey: "token")
        view!.removeViewController()
    }
}

class RoomsViewController: UIViewController , RoomsView {
    
    var presenter : RoomsPresenter?    
    @IBOutlet private weak var roomsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RoomsPresenterImplementation(view: self)
        presenter!.fetchrooms()
    }
    func reloadTable() {
        roomsTableView.reloadData()
    }
    
    func removeViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func navigateToRoomDetailViewController() {
        performSegue(withIdentifier: "roomDetailsSegue", sender: nil)
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        presenter!.signOut()
    }
}
extension RoomsViewController : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter!.initCell(table: tableView, indexPath: indexPath)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //roomsTableView.isHidden = presenter!.fetchRoomsNumber() == 0
        //return presenter!.fetchRoomsNumber()
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //presenter!.preformCellSelected(index: indexPath)
        self.navigateToRoomDetailViewController()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/4
    }
    
}

