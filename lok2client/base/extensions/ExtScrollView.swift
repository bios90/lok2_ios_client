import UIKit

extension UIScrollView
{
    func resizeContentToFit(offset:CGFloat = 0)
    {
        self.myla()
        
        self.subviews.forEach(
            { view in
                view.myla()
        })
        
        var max_y:CGFloat = 0
        self.subviews.forEach(
            { view in
                view.layoutIfNeeded()
                
                if(view.frame.maxY > max_y)
                {
                    max_y = view.frame.maxY
                }
        })
        
        let content_size = CGSize(width: self.frame.width, height: max_y+offset)
        self.contentSize = content_size
        self.myla()
    }
}
