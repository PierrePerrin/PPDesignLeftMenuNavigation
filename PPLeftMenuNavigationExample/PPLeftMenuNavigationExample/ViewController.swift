//
//  ViewController.swift
//  PPLeftMenuNavigationExample
//
//  Created by Pierre Perrin on 06/04/2017.
//  Copyright © 2017 PierrePerrin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openMenu(_ sender: Any) {
        
        if let menuContainer = MainViewController.currentContainer{
            
            if !menuContainer.isMenuOpened{
                
                menuContainer.openMenu()
            }else{
                menuContainer.closeMenu()
            }
        }
    }
}

