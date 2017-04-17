//
//  MainViewController.swift
//  PPLeftMenuNavigationExample
//
//  Created by Pierre Perrin on 06/04/2017.
//  Copyright © 2017 PierrePerrin. All rights reserved.
//

import UIKit
import PPLeftMenuNavigation


class MainViewController: PPMenuContainerViewController, PPLeftMenuDatasource {
    
    static var currentContainer : MainViewController?
    
    var menuItems : [mainLeftMenuItem] = [.home,.profile,.help,.settings,.empty,.logout]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        MainViewController.currentContainer = self
        self.datasource = self
        if let vc = self.viewController(forItem: menuItems.first!){
            self.contentViewController = vc
        }
        // self.backgroundImage = #imageLiteral(resourceName: "home-1")
        self.addBlurToBackground = true
    }
    
    func viewController(forItem item : mainLeftMenuItem) -> UIViewController?{
        
        if let identifier = item.viewControllerIdentifier{
            return UINavigationController.init(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: identifier))
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfItem() -> Int {
        return menuItems.count
    }
    
    func itemForRow(row: Int) -> PPLeftMenuItem {
        return menuItems[row].leftMenuItem
    }
    
    func didSelectRow(atIndex index: Int, item : PPLeftMenuItem) {
        if let vc = self.viewController(forItem: menuItems[index]){
            self.setContentViewController(viewController: vc, animated: true,blurTransition: true)
        }
    }
    
    var menuHeaderView: UIView?{
        return nil
    }
    
    var menuFooterView: UIView?{
        return nil
    }
    
}

enum mainLeftMenuItem{
    
    case home, profile, settings, help , logout, empty
    
    var text : String{
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "My profile"
        case .settings:
            return "Settings"
        case .help:
            return "Need help ?"
        case .logout:
            return "Logout"
        case .empty:
            return ""
        }
    }
    
    var icon : UIImage?{
        
        var imageName = ""
        switch self {
        case .home:
            imageName = "home"
        case .profile:
            imageName = "user"
        case .settings:
            imageName = "settings"
        case .help:
            imageName = "info"
        case .logout:
            imageName = "power"
        case .empty:
            imageName = ""
        }
        return UIImage(named: imageName)
    }
    
    var leftMenuItem : PPLeftMenuItem!{
        
        let menuItem =  PPLeftMenuItem(WithText: self.text, icon: self.icon)
        if self.font != nil{
            menuItem.font = self.font!
        }
        menuItem.textColor = self.textMenuColor
        return menuItem
    }
    
    var font : UIFont?{
        
        if self == .logout{
            return UIFont.systemFont(ofSize: 20, weight: UIFontWeightRegular)
        }
        return nil
    }
    
    var textMenuColor : UIColor{
        
        return UIColor.white
    }
    
    var viewControllerIdentifier : String?{
        
        
        switch self {
        case .home:
            return "HomeViewController"
        case .profile:
            return "ProfileViewController"
        case .settings:
            return "SettingsViewController"
        case .help:
            return "HelpViewController"
        default:
            return nil
        }
        
    }
    
}

