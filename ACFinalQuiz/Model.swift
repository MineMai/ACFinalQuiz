//
//  Model.swift
//  ACFinalQuiz
//
//  Created by YenShao on 2017/4/28.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase



class DBProvider
{
    private static let _instance = DBProvider()
    static var Instance:DBProvider {
        return _instance
    }
    
    var dbRef:FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var storageRef:FIRStorageReference {
        return FIRStorage.storage().reference()
    }
}



var books = [Books]()


class Books
{
    var name:String
    var imageURL:String
    var place:String
    var phone:String
    var website:String
    var detail:String
    var autoKey:String
    
    init (name:String, imageURL:String, place:String, phone:String, website:String, detail:String, autoKey:String)
    {
        self.name = name
        self.imageURL = imageURL
        self.place = place
        self.phone = phone
        self.website = website
        self.detail = detail
        self.autoKey = autoKey
    }
}

//struct Books
//{
//    var name:String
//    var imageURL:String
//    var place:String
//    var phone:String
//    var website:String
//    var detail:String
//}













