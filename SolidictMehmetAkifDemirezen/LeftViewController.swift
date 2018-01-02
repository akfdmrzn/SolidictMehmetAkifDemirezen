//
//  LeftViewController.swift
//  KWDrawerController
//
//  Created by Kawoou on 2017. 2. 10..
//  Copyright © 2017년 Kawoou. All rights reserved.
//

import UIKit
import LTMorphingLabel

class LeftViewController: BaseController {
    
    @IBOutlet weak var tableviewLeftMenu: UITableView!
    
    @IBOutlet weak var labelSolidict: LTMorphingLabel!
    var leftMenuArr  : [String] = ["Çıkış Yap"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelSolidict.morphingEffect = .evaporate
        self.labelSolidict.text = "SOLIDICT"
        
        tableviewLeftMenu?.register(LeftMenuTableViewCell.nib, forCellReuseIdentifier: LeftMenuTableViewCell.identifier)
        tableviewLeftMenu?.delegate = self
        tableviewLeftMenu?.dataSource = self

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension LeftViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableviewLeftMenu.frame.height * 0.1
    }
    
    
}

extension LeftViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: LeftMenuTableViewCell.identifier, for: indexPath) as? LeftMenuTableViewCell {
            cell.labelCellName.text = self.leftMenuArr[indexPath.section]
           return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return leftMenuArr.count
    
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        self.performSegue(withIdentifier: "sequeLogOut", sender: nil)

        
        
    }
    
}
