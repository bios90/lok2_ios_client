import UIKit

enum MyImage:String
{
    case bg_main
    case ei_kei_logo
    case ic_bell
    case ic_user_avatar
    case ic_categ
    case ic_heart
    case ic_search
    case ic_user
    case img_new
    case img_splash
    case img_red_squares
    case ic_arrow_back
    
    func getImage() -> UIImage
    {
        return UIImage(named: self.rawValue)!
    }
}
