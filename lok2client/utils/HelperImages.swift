import UIKit
import Kingfisher

class HelperImages
{
    static func getImgPairForTabs(img:UIImage) -> (img_normal:UIImage,img_selected:UIImage)
    {
        let img_normal = get_img_for_tab(img: img, color: MyColors.gi.gray5)
        let img_selected = get_img_for_tab(img: img, color: MyColors.gi.red)
        return (img_normal,img_selected)
    }

    static func get_img_for_tab(img:UIImage,color:UIColor)->UIImage
    {
        var img_scaled_and_colored = img.scaled_to_size(def_tab_bar_icon_size)
        img_scaled_and_colored = img_scaled_and_colored.setColorMy(color)
        return img_scaled_and_colored.withRenderingMode(.alwaysOriginal)
    }
}

enum ImageLoadError:Error
{
    case failed
}

struct UIImageProvider: ImageDataProvider
{
    let cacheKey: String
    let imageData: Data?
    
    init(image: UIImage)
    {
        cacheKey = image.sha256()
        imageData = image.pngData()
    }
    
    func data(handler: @escaping (Result<Data, Error>) -> Void)
    {
        if let data = imageData
        {
            handler(.success(data))
        }
        else
        {
            handler(.failure(ImageLoadError.failed))
        }
    }
}

var def_tab_bar_icon_size = CGSize(
    width: CGFloat(22),
    height: CGFloat(22)
)
