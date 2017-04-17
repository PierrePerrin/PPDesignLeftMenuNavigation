//
//  PPMenuContainerViewController.swift
//  PPLeftMenuNavigation
//
//  Created by Pierre Perrin on 06/04/2017.
//  Copyright © 2017 PierrePerrin. All rights reserved.
//

import UIKit

public protocol PPLeftMenuDatasource {

    func numberOfItem() -> Int
    func itemForRow(row : Int) -> PPLeftMenuItem
    func didSelectRow(atIndex index: Int, item : PPLeftMenuItem)
    var menuHeaderView : UIView? {get}
    var menuFooterView : UIView? {get}
    
}

open class PPMenuContainerViewController: UIViewController {

    var transitionTime = 0.3
    
    internal var internalContainerView : UIView!
    internal var interalContentViewController : UIViewController!
    
    internal var  leftMenuViewController : PPLeftMenuViewController?
    
    var tapGesture : UITapGestureRecognizer!
   
    var blurTransitionView : UIVisualEffectView!
    open var blurEffect : UIVisualEffect! = UIBlurEffect(style: UIBlurEffectStyle.light)
    
    open var backgroundBlurEffect : UIVisualEffect! = UIBlurEffect(style: UIBlurEffectStyle.dark)
    var backgroundBlurView : UIVisualEffectView!
    open var addBlurToBackground : Bool = false{
        didSet{
            
            if addBlurToBackground {
                if self.backgroundBlurView != nil && self.backgroundBlurView.superview == nil {
                     self.view.insertSubview(backgroundBlurView, aboveSubview: self.backgroundImageView)
                }
            }
            else{
                self.backgroundBlurView.removeFromSuperview()
            }
            
        }
    }
    
    var backgroundImageView : UIImageView!
    open var backgroundImage : UIImage!{
        didSet{
            if self.backgroundImageView != nil{
                self.backgroundImageView.image = backgroundImage
            }
        }
    }
    
    open var contentViewController : UIViewController!{
        set{
            if self.interalContentViewController == nil{
                self.interalContentViewController = newValue
            }
            
            if self.isViewLoaded{
                self.setContentViewController(viewController: contentViewController)
            }
        }
        get{
            return self.interalContentViewController
        }
    }
    
    override open func loadView() {
        super.loadView()
        
        self.prepareContainerView()
        self.addBlurTransitionView()
        self.prepareLeftMenuViewController()
        self.addBackground()
        self.addShadow()
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.setContentViewController(viewController:interalContentViewController)
        self.addGestureRecognizer()
    }
    
    public var datasource : PPLeftMenuDatasource!{
        didSet{
            
            self.leftMenuViewController?.datasource = self.datasource
        }
    }

    public func reloadLeftMenuDatas(animated:Bool = false){
        
        if let leftMenuVc = self.leftMenuViewController{
            UIView.transition(with: leftMenuVc.tableView, duration:animated ? transitionTime : 0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                leftMenuVc.tableView.reloadData()
            }, completion: nil)
        }
    }

    func addBackground(){
        
        self.backgroundImage = self.backgroundImage == nil ? UIImage.init(named: "backGround.jpg", in: PPBundle, compatibleWith: nil) : self.backgroundImage
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = backgroundImage
        imageView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        imageView.contentMode = .scaleAspectFill
        self.view.insertSubview(imageView, at: 0)
        self.backgroundImageView = imageView
        
        self.backgroundBlurView = UIVisualEffectView(effect: nil)
        self.backgroundBlurView.frame = self.view.bounds
        self.backgroundBlurView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        let value =  self.addBlurToBackground
        self.addBlurToBackground = value
    }
    
    func addShadow(){
        
        self.internalContainerView.layer.shadowColor = UIColor.black.cgColor
        self.internalContainerView.layer.shadowOffset = CGSize.zero
        self.internalContainerView.layer.shadowRadius = 7
        self.internalContainerView.layer.shadowOpacity = 0.1
    }
    
    //MARK: Menu Tansformations
    
    var scaleTransform : CGAffineTransform{
        return CGAffineTransform(scaleX: 0.85, y: 0.85)
    }
    
    var translationTransform : CGAffineTransform{
        return CGAffineTransform(translationX: 200, y: 0)
    }
    
    var textTranslationTransform : CGAffineTransform{
        return CGAffineTransform(translationX: -30, y: 0)
    }
    
    var containerTransform : CGAffineTransform{
        return scaleTransform.concatenating(translationTransform)
    }
    
    //self.isViewLoadedavoid crash before internalContainerView loads
    open var isMenuOpened : Bool{
        return self.isViewLoaded && !self.internalContainerView.transform.isIdentity
    }
}


//MARK: ViewControllers Management
extension PPMenuContainerViewController{
    
    //MARK: prepare containerView
    
    func prepareContainerView(){
        
        self.internalContainerView = UIView()
        self.internalContainerView.frame = self.view.bounds
        self.internalContainerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.view.addSubview(self.internalContainerView)
    }
    
    //MARK: prepare leftMenu
    
    func prepareLeftMenuViewController(){
        
        var storyBoard : UIStoryboard?  = PPStr
        if storyBoard == nil{
            storyBoard = UIStoryboard(name: "Main", bundle: nil)
        }
        if let leftMenuVc = storyBoard?.instantiateViewController(withIdentifier: "PPLeftMenuViewController") as? PPLeftMenuViewController{
            
            self.leftMenuViewController = leftMenuVc
            leftMenuVc.datasource = self.datasource
            leftMenuVc.view.frame = self.view.bounds
            leftMenuVc.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            leftMenuVc.view.transform = textTranslationTransform
            self.view.insertSubview(leftMenuVc.view, at: 0)
        }
    }
    
    //MARK: Prepare the viewcontrollers.
    
    open func setContentViewController(viewController : UIViewController, animated : Bool = false, blurTransition : Bool = false){
        
        
        self.addChildViewController(viewController)
        viewController.view.frame = self.internalContainerView.bounds
        viewController.view.alpha = 0.0
        viewController.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.internalContainerView.insertSubview(viewController.view, belowSubview: self.blurTransitionView)
        self.internalContainerView.layoutIfNeeded()
        
        if animated && blurTransition{
            self.makeBlurTransition()
        }
        
        UIView.animate(withDuration: animated ? transitionTime : 0, animations: {
            
            self.closeMenu()
            viewController.view.alpha = 1
            
        }) { (finished) in
            
            if self.interalContentViewController != nil && self.interalContentViewController != viewController{
                self.interalContentViewController.view.removeFromSuperview()
                self.interalContentViewController.removeFromParentViewController()
            }
            self.interalContentViewController = viewController
           
        }
    }
    
    func makeBlurTransition(){
        
       self.blurTransitionView.isHidden = false
        UIView.animate(withDuration: transitionTime/2, animations: {
             self.blurTransitionView.effect = self.blurEffect
        }) { (finished) in
            UIView.animate(withDuration: self.transitionTime/2, animations: {
                 self.blurTransitionView.effect = nil
            }) { (finished) in
                self.blurTransitionView.isHidden = true
            }
        }
    }
}

//MARK: Menu Actions
extension PPMenuContainerViewController{
    
    public func  openMenu(){
        
        self.refreshLeftMenu()
        self.contentViewController.view.clipsToBounds = true
        self.tapGesture.isEnabled = true
        self.contentViewController.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: transitionTime, animations: {
            
            
            self.contentViewController.view.layer.cornerRadius = 3
            self.internalContainerView.transform = self.containerTransform
            self.leftMenuViewController?.view.transform = .identity
            self.backgroundImageView.transform = .identity
            self.backgroundBlurView.effect = self.backgroundBlurEffect
            
        }, completion: nil)
    }
    
    public func  closeMenu(completion : (() -> Void)? = nil){

        UIView.animate(withDuration: transitionTime, animations: {
            
         
            self.contentViewController.view.layer.cornerRadius = 0
            self.internalContainerView.transform = .identity
            self.leftMenuViewController?.view.transform = self.textTranslationTransform
            self.backgroundImageView.transform = self.scaleTransform.inverted()
            self.backgroundBlurView.effect = nil
            
        }, completion: {
            finished in
            
            self.contentViewController.view.isUserInteractionEnabled = true
            self.contentViewController.view.clipsToBounds = false
            self.tapGesture.isEnabled = false
        })
    }
    
    func addGestureRecognizer(){
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.closeMenu))
        self.internalContainerView.addGestureRecognizer(tapGesture)
        self.tapGesture.isEnabled = false
    }
    
    func addBlurTransitionView(){
        
        self.blurTransitionView = UIVisualEffectView(effect: nil)
        self.blurTransitionView.frame = self.internalContainerView.bounds
        self.blurTransitionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.internalContainerView.addSubview(blurTransitionView)
        self.blurTransitionView.isHidden = true
    }
}

//MARK: Header View

extension PPMenuContainerViewController{
    
    func refreshLeftMenu(){
        self.leftMenuViewController?.tableView.reloadData()
    }
}


//MARK: rotation Management (Avoid layout problems)

extension PPMenuContainerViewController{
    
    open override var shouldAutorotate: Bool{
        return !self.isMenuOpened
    }
}
