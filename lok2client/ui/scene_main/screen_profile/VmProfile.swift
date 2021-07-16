import Foundation
import RxSwift
import RxCocoa

class VmProfile:BaseVm
{
    let br_current_user:BehaviorRelay<ModelUser?> = BehaviorRelay.init(value: nil)
    
    override init()
    {
        super.init()
        
        reloadUser()
    }
    
    private func reloadUser()
    {
        base_networker.getUserById(user_id: getCurentUserId(), action_success:
            { user in
                
                self.br_current_user.accept(user)
        })
    }
    
    private func getCurentUserId()->Int
    {
        guard let user_id = LocalData.getCurrentUser()?.id else
        {
            fatalError("**** Error no user ****")
        }
        
        return user_id
    }
}

//MARK: -Listeners
extension VmProfile
{
    func clickedAvatar()
    {
        ImagesGetterManager.getGalleyCameraImage(action_success:
            { image in
                
                guard let user_id = LocalData.getCurrentUser()?.id,
                    let img_as_base_64 = image.image.toBase64() else { return }
                
                self.base_networker.updateUser(user_id: user_id, first_name: nil, last_name: nil, email: nil, password: nil, avatar: img_as_base_64, action_success:
                    { _ in
                        self.reloadUser()
                })
        })
    }
    
    func clickedLogout()
    {
        BuilderDialogMy()
            .setDialogName(dialog_name: "logout_dialog")
            .setBtnOk(btn: BtnAction(text: MyString.logout.localized(), action:
                { _ in
                    
                    BusMainEvents.gi.ps_to_make_logout.onNext(())
            }))
            .setBtnCancel(btn: BtnAction(text: MyString.cancel.localized(), action: {_ in}))
            .setTitle(title: MyString.logout.localized())
            .setText(text: MyString.exit_current_account.localized())
            .build()
    }
    
    func clickedPrivacyPolicy()
    {
        MessagesManager.showPrivacyPolicyDialog()
    }
}
