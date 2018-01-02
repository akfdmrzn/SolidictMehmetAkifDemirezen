//
//  BaseController.swift
//  KonusarakOgren
//
//  Created by KO on 21.07.2017.
//  Copyright © 2017 KonusarakOgren. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseController: UIViewController {
   
    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    var blurEffectView : UIVisualEffectView?
    var indicator :  NVActivityIndicatorView?
    
        public static var nameCinsiyetArray : [String] = ["Cinsiyet seçiniz","Kadın","Erkek","Belirtmek İstemiyorum"]
        public static var idCinsiyetArray : [Int] = [0,1,2,3]
    
    
        public static var nameİliskiArray : [String] = ["İlişki Durumu Seçiniz","Evli","İlişkisi Yok","Dul","İlişkisi Var","Nişanlı","Sözlü","Ayrılmış","Platonik"]
        public static var idİliskiArray : [Int] = [0,1,2,3,4,5,6,7,8]
   
    
        public static var nameBurcArray : [String] = ["Burcunuzu Seçiniz","Koç","Boğa","İkizler","Yengeç","Aslan","Başak","Terazi","Akrep","Yay","Oğlak","Kova","Balık"]
        public static var idBurcArray : [Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12]

   /* var reachability: Reachability? */
    var subbView : UIView?
  /*   var circcleIndicator: BPCircleActivityIndicator!  */
    
    var isScreenWillMove : Bool = false {
        didSet {
            NotificationCenter.default.addObserver(self, selector: #selector(BaseController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(BaseController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
         }
    }
    
    var objectFrame : CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var keyboardIsShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    /** Show UIAlertController with specific message */
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Bilgi Mesajı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Devam Et", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /** Show UIAlertController with specific message and
     do an action when closed */
    func showAlert(_ message: String,_ handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: "Bilgi Mesajı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Devam Et", style: .cancel, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if isScreenWillMove {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if !keyboardIsShown {
                
                let moveSize = keyboardSize.size.height - (self.view.frame.height - objectFrame.origin.y - objectFrame.size.height ) + 5.0
                
                if keyboardSize.height > (self.view.frame.height - objectFrame.origin.y - objectFrame.size.height) {
               
                //self.view.frame.origin.y -=  moveSize
                    
                    if keyboardSize.height > (moveSize) {
                        self.view.frame.origin.y -=  moveSize
                    }
                    
                    keyboardIsShown = true
                }
                
            }
        }
        
    }
    }
   
    //******
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if keyboardIsShown {
             
                self.view.frame.origin.y = 0.0
                keyboardIsShown = false
            }
        }
        
    }
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    func indicatorShow(status : Bool){
     
        if !status{
            self.blurEffectView?.removeFromSuperview()
            indicator?.stopAnimating()
        }
        else{
            self.blurEffectView =  UIVisualEffectView(effect: self.blurEffect)
            self.blurEffectView?.frame = view.bounds
            self.blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(blurEffectView!)
            
            let color = UIColor(red: 255/255, green: 185/255, blue: 15/255, alpha: 1.0)
            let frame = CGRect(x: (self.view.frame.width/2)*0.7, y: (self.view.frame.height/2)*0.7, width: self.view.frame.width/3, height: self.view.frame.height/3)
             self.indicator =  NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballSpinFadeLoader, color: color, padding: NVActivityIndicatorView.DEFAULT_PADDING )
            
            self.view.addSubview(indicator!)
            indicator?.startAnimating()
        }
    }
    
    
    
    /*
    func indicatorShow(status : Bool){
        
        if !status{
        self.subbView?.removeFromSuperview()
            
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.isNavigationBarHidden = false
            
        }
        else{
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
            
        subbView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        circcleIndicator = BPCircleActivityIndicator(frame: CGRect(x: (self.view.frame.width/2)-7, y: self.view.frame.height/2, width: 50, height: 50))
        self.subbView?.addSubview(circcleIndicator)
        self.view.addSubview(subbView!)
        circcleIndicator.animate()
        }
        
    }

    
       func popError () {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "errorPage") as! ErrorVC
        
        vc.errorDelegate = self
        
        self.addChildViewController(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
    func firebaseScreenName(name: String) {
        Analytics.setScreenName(name, screenClass: classForCoder.description())
    }
    
    func firebaseEvent(name: String, parameters: [String:Any]) {
        Analytics.logEvent(name, parameters: parameters)
    }
*/
    
}
/*
extension BaseController : ErrorDelegate {
    func tryAgain() {
        viewDidLoad()
    }
}
*/


