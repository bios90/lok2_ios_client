import UIKit

extension UIBarButtonItem
{
    func setFont(font:UIFont)
    {
        let attr = [ NSAttributedString.Key.font: font ]
        self.setTitleTextAttributes(attr, for: .normal)
        self.setTitleTextAttributes(attr, for: .disabled)
        self.setTitleTextAttributes(attr, for: .selected)
    }
}
