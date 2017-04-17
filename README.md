# PPMusicImageShadow

## Synopsis

PPMusicImageShadow is a view that imitates in real time the shadow blurred effect of iOS Music App.

![alt tag](https://github.com/PierrePerrin/PPDesignLeftMenuNavigation/blob/master/Screens/RX0Ntmg15oKo8.gif)
![alt tag](https://github.com/PierrePerrin/PPDesignLeftMenuNavigation/blob/master/Screens/hsGfPRX6aHwYM.gif)

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
To integrate PPDesignLeftMenuNavigation into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.2'
use_frameworks!

target '<Your Target Name>' do
pod 'PPDesignLeftMenuNavigation'
end
```
### Manually

If you prefer  you can clone the project, release the framework or use the swift files directly.

## Code Example


First add a "Main" viewController on your Storyboard as a subclass of PPMenuContainerViewController and as initialviewController. 

![alt tag](https://github.com/PierrePerrin/PPDesignLeftMenuNavigation/blob/master/Screens/Storyboard.jpg)

Then add PPLeftMenuDatasource protocol to your main viewcontroller (The protocol is similar as a UITableViewDelegate protocol, but simpler)

```swift
class MainViewController: PPMenuContainerViewController, PPLeftMenuDatasource {

    var items : [PPLeftMenuItem] = [
    PPLeftMenuItem.init(WithText: "FirstItemTitle", icon: UIImage.init(named: "FirstIcon")),
    PPLeftMenuItem.init(WithText: "SecondItemTitle", icon: UIImage.init(named: "SecondIcon")),
    PPLeftMenuItem.init(WithText: "ThirdItemTitle", icon: UIImage.init(named: "ThirdIcon"))
    ]

    //Here you set 
    override func awakeFromNib() {
        super.awakeFromNib()

        self.datasource = self
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "YourViewControllerIdentifierForYourFirstItem"){
            self.contentViewController = vc
        }
    }

    func numberOfItem() -> Int {
        return items.count
    }

    func itemForRow(row: Int) -> PPLeftMenuItem {
        return items[row].leftMenuItem
    }

    func didSelectRow(atIndex index: Int, item : PPLeftMenuItem) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "viewControllerForSelectedRow"){

            //Here you change the viewcontroller (with a fade animation or a blur transition)
            self.setContentViewController(viewController: vc, animated: true,blurTransition: true)
        }
    }

    //Here you can add a header to the menu view
    var menuHeaderView: UIView?{
        return nil
    }

    //Here you can add a footer to the menu view
    var menuFooterView: UIView?{
        return nil
    }
}
```

### Personalization

Personalize the menu on the awakeFromNib().
```swift
    //change the menu background
    self.backgroundImage 

    //add a background effet on the menu
     self.addBlurToBackground = true
    
    //The blur effect style of menu and transition
    self.blurEffect : UIVisualEffect! = //Your desire effect
    self.backgroundBlurEffect : UIVisualEffect! = //Your desire effect


```
