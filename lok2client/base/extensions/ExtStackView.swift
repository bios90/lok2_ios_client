import UIKit

extension UIStackView
{
    func setPaddingTop(offset:Float)
    {
        var insets = self.layoutMargins
        insets.top = CGFloat(offset)
        self.layoutMargins = insets
        self.isLayoutMarginsRelativeArrangement = true
    }
    
    func setPaddingBottom(offset:Float)
    {
        var insets = self.layoutMargins
        insets.bottom = CGFloat(offset)
        self.layoutMargins = insets
        self.isLayoutMarginsRelativeArrangement = true
    }
    
    func removeAllArrangedSubviews()
    {
        self.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
