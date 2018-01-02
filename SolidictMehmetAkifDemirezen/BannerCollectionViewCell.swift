//
//  BannerCollectionViewCell.swift
//  SolidictMehmetAkifDemirezen
//
//  Created by akif demirezen on 29/12/2017.
//  Copyright © 2017 demirezenOrganization. All rights reserved.
//

import UIKit
import Gemini

class BannerCollectionViewCell: GeminiCell {
    @IBOutlet weak var imageViewOfBackground: UIImageView!
    @IBOutlet weak var labelOfBannerName: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
