import UIKit

extension UIView
{
    func myla()
    {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func myLaRecursevly()
    {
        self.myla()
        self.subviews.forEach({ $0.myLaRecursevly() })
        self.myla()
    }
    
    func addShadowMin()
    {
        self.layer.shadowColor = MyColors.gi.gray5.withAlphaComponent(0.25).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 12
    }
}

extension UINavigationBar
{
    func removeBottomLine()
    {
        self.setBackgroundImage(UIImage(), for:.default)
        self.shadowImage = UIImage()
        self.layoutIfNeeded()
    }
}
