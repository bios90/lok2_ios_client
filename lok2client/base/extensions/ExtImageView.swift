import UIKit
import Nuke

extension UIImageView
{
    func setImageColor(color: UIColor)
    {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    func loadImageMy(image:UIImage)
    {
        let image_provider = UIImageProvider(image: image)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: .provider(image_provider),options:
            [
                .transition(.fade(0.3))
        ])
    }
    
    func loadImageMy(url_str:String,action_load_finished:(()->Void)? = nil)
    {
        self.kf.indicatorType = .activity
        if let url = URL(string: url_str)
        {
            self.kf.setImage(with: url,options:
                [
                    .transition(.fade(0.3))
                ],completionHandler:
                { _ in

                    action_load_finished?()
            })
        }
    }
    
    func loadImageSimple(url:String,action_load_finished:(()->Void)? = nil)
    {
        if let url = NSURL(string: url)
        {
            let request = NSURLRequest(url: url as URL)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
            {
                response, data, error  in
                if let imageData = data as Data?
                {
                    self.image = UIImage(data: imageData)
                    action_load_finished?()
                }
            }
        }
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat)
    {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}


