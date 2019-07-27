//
//  roomModel.swift
//  Roomy_app
//
//  Created by user on 7/26/19.
//  Copyright © 2019 user. All rights reserved.
//
import Realm
import RealmSwift
import Foundation

class roomModel: Object {
    
    @objc dynamic var image: String?, price: String?, title: String?,
    place : String? ,   descriptionText : String?
}
