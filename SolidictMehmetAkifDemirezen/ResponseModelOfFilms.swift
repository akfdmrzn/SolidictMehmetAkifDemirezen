//
//  ResponseModelOfFilms.swift
//  SolidictMehmetAkifDemirezen
//
//  Created by akif demirezen on 28/12/2017.
//  Copyright © 2017 demirezenOrganization. All rights reserved.
//

import UIKit




class ResponseModelOfFilms: NSObject {

    var banners : [Banner] = []
    var movies : [Movies] = []
    var success : Bool = false
    var message : String = ""
    
    struct Banner {
        var id : Int = 0
        var name : String = ""
        var url : String = ""
    }
    struct Movies {
        var id : Int = 0
        var name : String = ""
        var description : String = ""
        var url : String = ""
        var releaseDate : String = ""
        var rate : Double = 0.0
        var isFav : Bool = false
    }
}
