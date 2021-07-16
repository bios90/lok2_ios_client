import UIKit

class ViewProfile:BaseViewController
{
    var vm_profile:VmProfile!
    var factory_profile:FactoryProfile!
    
    override func viewDidLoad()
    {
        status_bar_style = .default
        super.viewDidLoad()
        factory_profile = FactoryProfile(vc: self)
        setBaseVmAction(base_vm: vm_profile)
        
        setEvents()
        setListeners()
    }
    
    private func setEvents()
    {
        vm_profile.br_current_user
            .subscribe(onNext:
                { user in
                  
                    guard let user = user else { return }
                    
                    self.factory_profile.lbl_name.text = user.getFullName()
                    self.factory_profile.lbl_email.text = user.email
                    if let url_avatar = user.url_avatar
                    {
                          self.factory_profile.img_avatar.loadImageMy(url_str: url_avatar)
                    }
                    else
                    {
                        self.factory_profile.img_avatar.loadImageMy(image: MyImage.ic_user_avatar.getImage())
                    }
                  
                    
            })
        .disposed(by: dispose_bag)
    }
    
    private func setListeners()
    {
        factory_profile.btn_img_avatar.addAction {
            self.vm_profile.clickedAvatar()
        }
        
        factory_profile.btn_logout.addAction {
            self.vm_profile.clickedLogout()
        }
        
        factory_profile.btn_privacy_policy.addAction {
            self.vm_profile.clickedPrivacyPolicy()
        }
    }
}
