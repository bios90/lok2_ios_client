import Foundation
import RxSwift
import RxCocoa

class VmLogin:BaseVm
{
    var ps_clicked_register: PublishSubject<Void> = PublishSubject()
    let br_email:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    let br_password:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    let ps_success_login:PublishSubject<Void> = PublishSubject.init()
    
    override init()
    {
        super.init()
        
    }
    
    func madeRegisterWithEmail(email:String)
    {
        MessagesManager.showGreenAlerter(text: MyString.success_register_email_to_finish.localized())
        br_email.accept(email)
    }
}

//MARK: -Listeners
extension VmLogin
{
    func clickedLogin()
    {
        let email = br_email.value
        let password = br_password.value
        let push_token = LocalData.getPushToken() ?? "asdfndsnf;lnfl;nfkljdnsgkljnsdfg"
        
        let validation_data = ValidationManager.validateLogin(email: email, password: password)
        if(!validation_data.is_valid)
        {
            MessagesManager.showRedAlerter(text: validation_data.getErrorMessage())
            return
        }
        
        base_networker.makeLogin(email: email!, password: password!, push_token: push_token, action_success:
            { user in
                
//                if(user.email_verified != true)
//                {
//                    let message = "Необходимо подтвердить email"
//                    MessagesManager.showRedAlerter(text: message)
//                    return
//                }
                
                LocalData.saveCurrentUser(user: user)
                self.ps_success_login.onNext(())
        })
    }
    
    func clickedRegister()
    {
        ps_clicked_register.onNext(())
    }
    
    func clickedForgotPass()
    {
        return
        BuilderDialogMy().setDialogName(dialog_name: MyString.password_recovery.localized())
            .setTitle(title: MyString.password_recovery.localized())
            .setText(text: MyString.for_password_recover.localized())
            .setBtnCancel(btn: BtnAction(text: MyString.cancel.localized(), action: { _ in}))
            .setWithTf(with_tf: true)
            .setBtnOk(btn: BtnAction(text: MyString.recover.localized(), action:
                { str_as_any in
                    
                    guard let email = str_as_any as? String else { return }
                    
                    if(!isValidEmail(email))
                    {
                        MessagesManager.showRedAlerter(text: MyString.enter_valid_email.localized())
                        return
                    }
                    
                    self.base_networker.makePasswordReset(email: email, action_success:
                        {
                            let text = "На почту \(email) отправлено письмо с инструкцией по восстановлению"
                            MessagesManager.showGreenAlerter(text: text)
                    })
            }))
            .build()
    }
}
