//
//  UserModel.swift
//  KonusarakOgren
//
//  Created by KO on 27.07.2017.
//  Copyright © 2017 KonusarakOgren. All rights reserved.
//

import Foundation


class UserModel: NSObject {
    
    private var _fav : [Int] = []
 
    
    var fav : [Int] {
        get {
            if let fav = UserDefaults.standard.value(forKey: "fav") as? [Int] {
                return fav
            }
            else {
                return []
            }
        }
        set {
            self._fav = newValue
            UserDefaults.standard.set(self._fav, forKey: "fav")
        }
    }
}













