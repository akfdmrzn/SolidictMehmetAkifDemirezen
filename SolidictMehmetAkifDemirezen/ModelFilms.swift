//
//  ModelFilms.swift
//  SolidictMehmetAkifDemirezen
//
//  Created by akif demirezen on 28/12/2017.
//  Copyright © 2017 demirezenOrganization. All rights reserved.
//

import UIKit


protocol  FilmsDelegate : class{
    func dataUpdate(responseModel: ResponseModelOfFilms)
    func getDataSuccessfully(isCorrect: Bool, message : String)
}
class ModelFilms: ConnectionDelegate {
 
    var postConnection = PostConnection()
    var filmsDelegate : FilmsDelegate?
    
    let user = UserModel()
    var responseModel = ResponseModelOfFilms()
    
    init() {
        
        self.postConnection.delegate = self
       
    }
    
    func sendDataToService(){
        
        let data = ["":""
            ] as [String : Any]
        postConnection.makePostConnection(url: "http://misc.solidict.com/movies", postParams: data, httpMethod: .get)
    }
    func getDataFromService(jsonData : AnyObject){
        let json = jsonData as AnyObject
        
        var bannerList = [ResponseModelOfFilms.Banner()]
        var movieList = [ResponseModelOfFilms.Movies()]
        if let message = json["message"] as? String {
            responseModel.message = message
        }
        if true == (json["success"] as? Bool) {
            responseModel.success = true
            if let banners = (json["data"] as AnyObject)["banner"] as? [AnyObject] {
                for banner in banners {
                    var modelBanner = ResponseModelOfFilms.Banner()
                    if let id = banner["id"] as? Int {
                        modelBanner.id = id
                        
                    }
                    if let name = banner["name"] as? String {
                        modelBanner.name = name
                        
                    }
                    if let url = banner["url"] as? String {
                        modelBanner.url = url
                        
                    }
                
                    bannerList.append(modelBanner)
                    
                    
                }
                responseModel.banners = bannerList
                responseModel.banners.removeFirst()
            }
                
            
            if let movies = (json["data"] as AnyObject)["movies"] as? [AnyObject] {
                for movie in movies {
                    var modelMovie = ResponseModelOfFilms.Movies()
                    if let id = movie["id"] as? Int {
                        modelMovie.id = id
                    }
                    if let name = movie["name"] as? String {
                        modelMovie.name = name
                        print(name)
                    }
                    if let url = movie["url"] as? String {
                        modelMovie.url = url
                    }
                    if let description = movie["description"] as? String {
                        modelMovie.description = description
                    }
                    if let releaseDate = movie["relaeseDate"] as? String {
                        modelMovie.releaseDate = releaseDate
                    }
                    if let rate = movie["rate"] as? Double {
                        modelMovie.rate = rate
                    }
                    
                    movieList.append(modelMovie)
                }
                responseModel.movies = movieList
                responseModel.movies.removeFirst()
             }
            
            
            self.filmsDelegate?.dataUpdate(responseModel: responseModel)
            self.filmsDelegate?.getDataSuccessfully(isCorrect: true, message: responseModel.message )
            return
        }
        else {
            self.filmsDelegate?.getDataSuccessfully(isCorrect: false, message: responseModel.message)
        }
    }
    
    func getError(errMessage : String){
        self.filmsDelegate?.getDataSuccessfully(isCorrect: false, message: "Bir Hata Oluştu")
        
    }
    
    
}

