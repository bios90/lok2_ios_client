import UIKit
import SwiftGifOrigin

class VcSplash:BaseViewController
{
    
    let img :UIImageView =
    {
        let img = UIImageView()
        img.loadGif(name: MyImage.img_splash.rawValue)
        img.loadGif(asset: MyImage.img_splash.rawValue)
        return img
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(img)
        img.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        runActionWithDelay(milliseconds: 4000, action:
            {
                self.navigationController?.popViewController(animated: true)
        })
        .disposed(by: dispose_bag)
    }
}
