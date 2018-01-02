//
//  FilmDetailVC.swift
//  SolidictMehmetAkifDemirezen
//
//  Created by akif demirezen on 28/12/2017.
//  Copyright © 2017 demirezenOrganization. All rights reserved.
//

import UIKit

class FilmDetailVC: UIViewController {
  
    @IBOutlet weak var textViewMovieDescription: UITextView!
    @IBOutlet weak var abelReleaseDate: CustomLabel!
    @IBOutlet weak var labelMovieName: CustomLabel!
    @IBOutlet weak var imageViewOfMovieImage: UIImageView!

    @IBOutlet weak var labelMovieRate: CustomLabel!
    @IBOutlet weak var imageViewOfStatuFav: UIImageView!
    
    var detailOfMovie = ResponseModelOfFilms.Movies()
    let user = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavBar(whichPage: self.detailOfMovie.name)
        
        
        self.abelReleaseDate.text = "Release Date \(self.detailOfMovie.releaseDate)"
        let imageURL = URL(string: self.detailOfMovie.url)
        self.imageViewOfMovieImage.sd_setImage(with: imageURL)
        
        self.labelMovieName.text = self.detailOfMovie.name
        self.labelMovieRate.text = String(self.detailOfMovie.rate)
        self.textViewMovieDescription.text = self.detailOfMovie.description
        self.isFaved()
        
        
        
    }
    func isFaved(){
        if user.fav.contains(self.detailOfMovie.id){
            self.imageViewOfStatuFav.image = #imageLiteral(resourceName: "detayFav")
        }
        else{
            self.imageViewOfStatuFav.image = #imageLiteral(resourceName: "detayNotFaved")
        }
        
    }
   
    func setUpNavBar(whichPage : String){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = whichPage
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
