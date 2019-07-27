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
class roomsParser{
    static func getRooms() {
        let realm = try! Realm()
//        let oldRooms = realm.objects(roomModel.self)
//        realm.delete(oldRooms)
//        try! realm.write {
//            realm.deleteAll()
//        }
        if let token = UserDefaults.standard.string(forKey: "token"){
            AF.request(APIRouter.getAllRooms(["Authorization" : token])).validate().responseJSON { (response) in
                switch response.result{
                case .success(let results):
                    let rawData = results as! [[String:Any]]
                    
                    
                    for room in rawData{
                        let temp = roomModel()
                        temp.descriptionText = room["description"] as? String
                        temp.image = room["image"] as? String
                        temp.place = room["place"] as? String
                        temp.price = room ["price"] as? String
                        temp.title = room["title"] as? String
                        try! realm.write {
                            realm.add(temp)
                        }
                    }
                case .failure(_):
                    print("")
                }
            }
        }
        
    }
}
//                    for room in rawData{
//                        print(type(of: room))
//                    }
//                    var rooms = [roomClass]()
//                    for object in rawData{
//                        //let tempRoom = object as! [String:Any]
//                        let parsedRoom = Mapper<roomClass>().map(JSON: object)
//                        rooms.append(parsedRoom!)
//                    }
//                    print (rooms[0].descriptionText)
