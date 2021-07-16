import UIKit

class FactoryProfile
{
    let vc:BaseViewController
    static let circle_size = 140
    
    let lbl_email:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.font = MyFonts.gi.reg_s
        return lbl
    }()
    
    let lbl_name:UILabel =
    {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.gray7
        lbl.font = MyFonts.gi.reg_xl
        return lbl
    }()
    
    let btn_logout:BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.transparent
        btn.layer.cornerRadius = 4
        btn.layer.borderColor = MyColors.gi.red.cgColor
        btn.layer.borderWidth = 2
        btn.br_text.accept(MyString.logout.localized())
        return btn
    }()
    
    let btn_img_avatar:BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.white
        btn.setRippleColor(color: MyColors.gi.red.withAlphaComponent(0.2))
        btn.setRippleCornerRadius(radius: CGFloat(FactoryProfile.circle_size / 2))
        btn.layer.cornerRadius = CGFloat(FactoryProfile.circle_size / 2)
        btn.clipsToBounds = false
        btn.addShadowMin()
        return btn
    }()
    
    let img_avatar : UIImageView =
    {
        let img = UIImageView()
        img.clipsToBounds = true
        img.layer.cornerRadius = CGFloat(FactoryProfile.circle_size / 2)
        img.image = MyImage.ic_user_avatar.getImage()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let btn_privacy_policy:BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.transparent
        btn.setRippleColor(color: MyColors.gi.red.withAlphaComponent(0.2))
        btn.br_text_color.accept(MyColors.gi.red)
        btn.br_text.accept(MyString.privacy_policy.localized())
        return btn
    }()
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        setupViews()
    }
    
    private func setupViews()
    {
        self.vc.view.addSubview(lbl_email)
        self.vc.view.addSubview(lbl_name)
        self.vc.view.addSubview(btn_logout)
        self.vc.view.addSubview(btn_img_avatar)
        self.btn_img_avatar.addSubview(img_avatar)
        self.vc.view.addSubview(btn_logout)
        self.vc.view.addSubview(btn_privacy_policy)
        
        lbl_email.snp.makeConstraints(
            { make in
                
                make.center.equalToSuperview()
        })
        
        lbl_name.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.bottom.equalTo(lbl_email.snp.top).offset(-12)
        })
        
        btn_img_avatar.snp.makeConstraints(
            { make in
                
                make.bottom.equalTo(lbl_name.snp.top).offset(-12)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(FactoryProfile.circle_size)
        })
        
        img_avatar.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        btn_logout.snp.makeConstraints(
            { make in
                 
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.top.equalTo(lbl_email.snp.bottom).offset(12)
                make.height.equalTo(40)
        })
        
        btn_privacy_policy.snp.makeConstraints(
            { make in
                
                make.left.right.equalToSuperview()
                make.bottom.equalToBottomWithSafe(parent: self.vc.view, offset: 0)
                make.height.equalTo(40)
        })
    }
}
