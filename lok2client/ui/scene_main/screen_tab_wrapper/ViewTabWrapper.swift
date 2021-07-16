import UIKit

class ViewTabWrapper:BaseTabBarController
{
    var vm_tab_wrapper:VmTabWrapper!
    
    let img_red_squares:UIImageView =
    {
        let img = UIImageView()
        img.image = MyImage.img_red_squares.getImage()
        img.layer.zPosition = -1
        return img
    }()
    
    override func viewDidLoad()
    {
        show_navbar = false
        status_bar_style = .default
        self.view.backgroundColor = MyColors.gi.white
        super.viewDidLoad()
        
        self.view.addSubview(img_red_squares)
        
        img_red_squares.snp.makeConstraints(
            { make in
                
                make.width.equalTo(200)
                make.height.equalTo(40)
                make.top.centerX.equalToSuperview()
        })
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        ViewTabWrapper.applyTabsButtonsColors()
    }
    
    static func applyTabsButtonsColors()
    {
        let action =
        {
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: MyColors.gi.gray5], for: .normal)
                
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: MyColors.gi.red], for: .selected)
        }
        
        action()
        runWithDelay(milliseconds: 500, action:
            {
                action()
        })
    }
}
