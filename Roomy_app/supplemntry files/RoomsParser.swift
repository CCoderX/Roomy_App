//
//  roomsParser.swift
//  Roomy_app
//
//  Created by user on 7/26/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import Realm
import RealmSwift
class RoomsParser{
    static func fetchRooms(handler : @escaping(_ result : [RoomModel] , _ success: Bool)->Void) {
        let realm = try! Realm()
        try! realm.write {
            //            realm.delete(oldRooms)
            realm.deleteAll()
        }
        if let token = UserDefaults.standard.string(forKey: "token") {
            AF.request(APIRouter.getAllRooms(["Authorization" : token])).validate().responseJSON { (response) in
                var result = [RoomModel]()
                switch response.result{
                case .success(let results):
                    let rawData = results as! [[String:Any]]
                    
                    
                    for room in rawData{
                        let temp = RoomModel()
                        temp.descriptionText = room["description"] as? String
                        temp.image = room["image"] as? String
                        temp.place = room["place"] as? String
                        temp.price = room ["price"] as? String
                        temp.title = room["title"] as? String
                        try! realm.write {
                            realm.add(temp)
                        }
                        result.append(temp)
                    }
                    print(result.count)
                    handler(result , true)
                    
                case .failure(_):
                    
                    handler(result, false)
                }
            }
        }
        
    }
    static func addRoom(room: RoomModel) {
        
    }
}
