import Foundation

class CoordinatorAuth:BaseCoordinator
{
    let vm_register = VmRegister()
    let vm_login = VmLogin()
    
    override init(nav_controller: BaseNavController)
    {
        super.init(nav_controller: nav_controller)
        setEvents()
    }
    
    private func setEvents()
    {
        vm_login.ps_clicked_register.subscribe(onNext:
            {
                self.toRegister()
        })
        .disposed(by: dispose_bag)
        
        vm_register.ps_made_success_register.subscribe(onNext:
            { email in
                
                self.vm_login.madeRegisterWithEmail(email: email)
        })
        .disposed(by: dispose_bag)
        
        vm_login.ps_success_login.subscribe(onNext:
            {
                AppDelegate.gi.startMain()
        })
        .disposed(by: dispose_bag)
    }
}

//MARK: -Navigation
extension CoordinatorAuth
{
    func toLogin()
    {
        let vc_login = ViewLogin()
        vc_login.vm_login = vm_login
        
        navigation_controller.pushViewController(vc_login, animated: true)
    }
    
    func toRegister()
    {
        let vc_register = ViewRegister()
        vc_register.vm_register = VmRegister()
        
        navigation_controller.pushViewController(vc_register, animated: true)
    }
}
