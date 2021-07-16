import Foundation
import YPImagePicker
import RxSwift
import RxCocoa

class VmRegister:BaseVm
{
    let br_image:BehaviorRelay<UIImage?> = BehaviorRelay.init(value: nil)
    let br_first_name:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    let br_last_name:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    let br_email:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    let br_password1:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    let br_password2:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    
    let ps_made_success_register:PublishSubject<String> = PublishSubject.init()
    
    override init()
    {
        super.init()
    }
}

//MARK: -Listeners
extension VmRegister
{
    func clickedBack()
    {
        self.ps_dissmiss_vc.onNext(true)
    }
    
    func clickedAvatar()
    {
        ImagesGetterManager.getGalleyCameraImage(action_success:
            { image in
                
                self.br_image.accept(image.image)
        })
    }
    
    func clickedPrivacyPolicy()
    {
        MessagesManager.showPrivacyPolicyDialog()
    }
    
    func clickedRegister()
    {
        let first_name = br_first_name.value
        let last_name = br_last_name.value
        let email = br_email.value
        let password1 = br_password1.value
        let password2 = br_password2.value
        let avatar = br_image.value?.toBase64()
        
        let validation_data = ValidationManager.validateRegister(first_name: first_name, last_name: last_name, email: email, password1: password1, password2: password2)
        
        if(!validation_data.is_valid)
        {
            MessagesManager.showRedAlerter(text: validation_data.getErrorMessage())
            return
        }
        
        base_networker.makeRegister(first_name: first_name!, last_name: last_name!, email: email!, password: password1!, avatar: avatar, action_success:
            { user in
                
                self.ps_made_success_register.onNext(email!)
                self.ps_dissmiss_vc.onNext(true)
            })
    }
}


