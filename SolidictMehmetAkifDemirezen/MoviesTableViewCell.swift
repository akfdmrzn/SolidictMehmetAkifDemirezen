//
//  MoviesTableViewCell.swift
//  SolidictMehmetAkifDemirezen
//
//  Created by akif demirezen on 29/12/2017.
//  Copyright © 2017 demirezenOrganization. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewOfNewBadge: UIImageView!
    @IBOutlet weak var imageviewOfMovie: UIImageView!
    @IBOutlet weak var labelStatuOfFav: CustomLabel!
    @IBOutlet weak var imageViewOfFav: UIImageView!
    @IBOutlet weak var labelOfReleaseDate: CustomLabel!
    @IBOutlet weak var labelOfMovieName: CustomLabel!
    
    var tapFavText : UIGestureRecognizer?
    var tapFavImage : UIGestureRecognizer?
    let user = UserModel()
    var cellArr : [ResponseModelOfFilms.Movies] = []
    var cellIndx : Int = 0
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
    }
    
    @IBAction func btnImageTap(_ sender: Any) {
        addFavourite(item: cellArr, index: cellIndx)
    }
   
    @IBAction func btnTextTap(_ sender: Any) {
        addFavourite(item: cellArr, index: cellIndx)
        
    }
    func configureWithItem (item : [ResponseModelOfFilms.Movies], index : Int){
        self.imageViewOfNewBadge.isHidden = true
        self.cellArr = item
        self.cellIndx = index
        self.imageViewOfFav.image = #imageLiteral(resourceName: "favori_bos")
         self.labelStatuOfFav.text = "Add To Favourites"
        
        if index == 2 || index == 4 {
         self.imageViewOfNewBadge.isHidden = false
            
        }
        let imageURL = URL(string: item[index].url)
        self.imageviewOfMovie.sd_setImage(with: imageURL)
        self.labelOfMovieName.text = item[index].name
        self.labelOfReleaseDate.text = "Release Date : \(item[index].releaseDate)"
        if user.fav.contains(item[index].id){
        self.imageViewOfFav.image = #imageLiteral(resourceName: "favori_dolu")
        self.labelStatuOfFav.text = "Added To Favourites"
        }
        else{
        self.imageViewOfFav.image = #imageLiteral(resourceName: "favori_bos")
        self.labelStatuOfFav.text = "Add To Favourites"
        }
        
        
    }
    func addFavourite(item : [ResponseModelOfFilms.Movies], index : Int){
        if user.fav.contains(item[index].id){
            let whichIndex = user.fav.index(of: cellArr[cellIndx].id)
            user.fav.remove(at: whichIndex!)
            self.imageViewOfFav.image = #imageLiteral(resourceName: "favori_bos")
            self.labelStatuOfFav.text = "Add To Favourites"
            
        }
        else{
        user.fav.append(cellArr[cellIndx].id)
        self.imageViewOfFav.image = #imageLiteral(resourceName: "favori_dolu")
        self.labelStatuOfFav.text = "Added To Favourites"
        }
    }
    
    
}
