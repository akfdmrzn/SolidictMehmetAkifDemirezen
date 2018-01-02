//
//  ViewController.swift
//  SolidictMehmetAkifDemirezen
//
//  Created by akif demirezen on 28/12/2017.
//  Copyright © 2017 demirezenOrganization. All rights reserved.
//

import UIKit
import TextFieldEffects
import LTMorphingLabel

class LoginVC: BaseController {

    @IBOutlet weak var labelOfTitle: LTMorphingLabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var btnLogin: CustomButton!
    @IBOutlet weak var textPassword: HoshiTextField!
    @IBOutlet weak var textUsername: HoshiTextField!
 
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let gradientOne = UIColor(red: 181/255, green: 181/255, blue: 181/255, alpha: 1).cgColor
    let gradientTwo = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1).cgColor
    let gradientThree = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1).cgColor
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.labelOfTitle.morphingEffect = .burn
        self.labelOfTitle.text = "SOLIDICT"
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientTwo, gradientThree])
        gradientSet.append([gradientThree, gradientOne])
        
        
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        self.imageview.layer.addSublayer(gradient)
        
        animateGradient()
        
        
        
        
    }
    
    func animateGradient() {
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 3.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = kCAFillModeForwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
    }
    
    
    
    @IBAction func btnActLogin(_ sender: Any) {
        if textUsername.text == "solidict" && textPassword.text == "123"{
            self.performSegue(withIdentifier: "segueGoToMainPage", sender: nil)
            
        }
        else{
            showAlert("Yanlış Kullanıcı Adı Veya Şifre Girdiniz")
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
extension LoginVC: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if !flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
        
    }
}
