import UIKit

class BaseTabBarController:UITabBarController
{
    var show_navbar = false
    var status_bar_style:UIStatusBarStyle = .lightContent
    
    func preloadAllControllers()
    {
        if let viewControllers = self.viewControllers
        {
            for viewController in viewControllers
            {
                let _ = viewController.view
            }
        }
    }
}

//MARK: -Lifecycle
extension BaseTabBarController
{
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(!show_navbar, animated: animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(!show_navbar, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        status_bar_style
    }
}
