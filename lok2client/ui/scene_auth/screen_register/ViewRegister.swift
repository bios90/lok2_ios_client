import Foundation

class ViewRegister:BaseViewController
{
    var vm_register:VmRegister!
    var factory_register:FactoryRegister!
    
    override func viewDidLoad()
    {
        show_navbar = false
        status_bar_style = .lightContent
        super.viewDidLoad()
        factory_register = FactoryRegister(vc: self)
        setBaseVmAction(base_vm: vm_register)
        
        setEvents()
        setListeners()
    }
    
    private func setListeners()
    {
        (factory_register.tf_first_name <-> vm_register.br_first_name).disposed(by: dispose_bag)
        (factory_register.tf_last_name <-> vm_register.br_last_name).disposed(by: dispose_bag)
        (factory_register.tf_email <-> vm_register.br_email).disposed(by: dispose_bag)
        (factory_register.tf_password1 <-> vm_register.br_password1).disposed(by: dispose_bag)
        (factory_register.tf_password2 <-> vm_register.br_password2).disposed(by: dispose_bag)
        
        factory_register.btn_register.addAction {
            self.vm_register.clickedRegister()
        }
        
        factory_register.btn_img_avatar.addAction {
            self.vm_register.clickedAvatar()
        }
        
        factory_register.btn_privacy_policy.addAction {
            self.vm_register.clickedPrivacyPolicy()
        }
        
        factory_register.btn_back.addAction {
            self.vm_register.clickedBack()
        }
    }
    
    private func setEvents()
    {
        vm_register.br_image.subscribe(onNext:
            { image in
                
                guard let image = image else { return }
                self.factory_register.img_avatar.loadImageMy(image: image)
        })
        .disposed(by: dispose_bag)
    }
}
