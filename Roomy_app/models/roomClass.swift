//
//  File.swift
//  Roomy_app
//
//  Created by user on 7/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
class roomClass: Mappable {
    var image : String?,    price : Int? ,title : String?,
    place : String? ,   descriptionText : String?
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        place     <- map["place"]
        image <- map["image"]
        descriptionText <- map["description"]
        price <- map["price"]
        title <- map["title"]
    }
    
    
  
    
    
    
    
//    init(image: UIImage , price : Int , place : String , address : String , descriptionText : String ) {
//        self.place = place
//        self.image = image
//        self.price = price
//        self.descriptionText = descriptionText
//
//    }
//    func getImage ()-> UIImage{
//    return self.image
//    }
//    func getPlace()-> String {
//         return self.place
//    }
//    func getDesctiption()-> String
//    {
//        return descriptionText
//    }
//    func getPrice()->Int{
//        return price
//    }
}
