import UIKit

class ViewLogin:BaseViewController
{
    var vm_login:VmLogin!
    var factory_login:FactoryLogin!
    
    override func viewDidLoad()
    {
        show_navbar = false
        status_bar_style = .lightContent
        super.viewDidLoad()
        factory_login = FactoryLogin(vc: self)
        setBaseVmAction(base_vm: vm_login)
        
        setListeners()
    }
    
    private func setListeners()
    {
        (factory_login.tf_email <-> vm_login.br_email).disposed(by: dispose_bag)
        (factory_login.tf_password <-> vm_login.br_password).disposed(by: dispose_bag)
        
        factory_login.btn_register.addAction {
            self.vm_login.clickedRegister()
        }
        
        factory_login.btn_login.addAction {
            self.vm_login.clickedLogin()
        }
        
        factory_login.btn_forgot_pass.addAction {
            self.vm_login.clickedForgotPass()
        }
    }
    
    
}
