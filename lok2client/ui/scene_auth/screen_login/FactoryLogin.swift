import UIKit
import SnapKit

class FactoryLogin
{
    static let element_width = 240
    
    let vc:BaseViewController
    
    let img_bg:UIImageView =
    {
        let img = UIImageView(image: MyImage.bg_main.getImage())
        img.contentMode = .scaleToFill
        return img
    }()
    
    let img_logo:UIImageView =
    {
        let img = UIImageView(image: MyImage.ei_kei_logo.getImage())
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let lbl_email:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_m
        lbl.textColor = MyColors.gi.gray5
        lbl.text = MyString.email.localized()
        return lbl
    }()
    
    let tf_email:BaseTextField =
    {
        let tf = ViewsHelper.getGrayStrokedTf()
        tf.textAlignment = .center
        tf.textColor = MyColors.gi.gray8
        return tf
    }()
    
    let lbl_password:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_m
        lbl.textColor = MyColors.gi.gray5
        lbl.text = MyString.password.localized()
        return lbl
    }()
    
    let tf_password:BaseTextField =
    {
        let tf = ViewsHelper.getGrayStrokedTf()
        tf.textAlignment = .center
        tf.isSecureTextEntry = true
        tf.textColor = MyColors.gi.gray8
        return tf
    }()
    
    let btn_forgot_pass :BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.transparent
        btn.setRippleColor(color: MyColors.gi.red.withAlphaComponent(0.2))
        btn.br_text.accept(MyString.forgot_pass.localized())
        
        btn.isUserInteractionEnabled = false
        btn.isHidden = true
        
        return btn
    }()
    
    let btn_login :BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.red
        btn.br_text_color.accept(MyColors.gi.white)
        btn.br_text.accept(MyString.enter.localized())
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        return btn
    }()
    
    let btn_register:BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.transparent
        btn.br_text_color.accept(MyColors.gi.white)
        btn.setRippleColor(color: MyColors.gi.white.withAlphaComponent(0.2))
        btn.br_text.accept(MyString.registration.localized())
        return btn
    }()
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        setupViews()
    }
    
    private func setupViews()
    {
        self.vc.view.backgroundColor = .orange
        self.vc.view.addSubview(img_bg)

        self.vc.view.addSubview(lbl_password)
        self.vc.view.addSubview(tf_password)
        self.vc.view.addSubview(tf_email)
        self.vc.view.addSubview(lbl_email)
        self.vc.view.addSubview(img_logo)
        self.vc.view.addSubview(btn_forgot_pass)
        self.vc.view.addSubview(btn_login)
        self.vc.view.addSubview(btn_register)
        
        img_bg.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        lbl_password.snp.makeConstraints(
            { make in
                
                make.center.equalToSuperview()
        })
        
        tf_password.snp.makeConstraints(
            { make in
                
                make.centerX.equalToSuperview()
                make.width.equalTo(FactoryLogin.element_width)
                make.height.equalTo(40)
                make.top.equalTo(lbl_password.snp.bottom).offset(6)
        })
        
        tf_email.snp.makeConstraints(
            { make in
                
                make.centerX.equalToSuperview()
                make.width.equalTo(FactoryLogin.element_width)
                make.height.equalTo(40)
                make.bottom.equalTo(lbl_password.snp.top).offset(-12)
        })
        
        lbl_email.snp.makeConstraints(
            { make in
                
                make.bottom.equalTo(tf_email.snp.top).offset(-6)
                make.centerX.equalToSuperview()
        })
        
        img_logo.snp.makeConstraints(
            { make in
                
                make.bottom.equalTo(lbl_email.snp.top).offset(-22)
                make.width.height.equalTo(146)
                make.centerX.equalToSuperview()
        })
        
        btn_forgot_pass.snp.makeConstraints(
            { make in
                
                make.top.equalTo(tf_password.snp.bottom).offset(6)
                make.height.equalTo(32)
                make.width.equalTo(FactoryLogin.element_width)
                make.centerX.equalToSuperview()
        })
        
        btn_login.snp.makeConstraints(
            { make in
                
                make.top.equalTo(btn_forgot_pass.snp.bottom).offset(32)
                make.height.equalTo(40)
                make.width.equalTo(FactoryLogin.element_width)
                make.centerX.equalToSuperview()
        })
        
        btn_register.snp.makeConstraints(
            { make in
                
                make.width.equalToSuperview()
                make.height.equalTo(40)
                make.centerX.equalToSuperview()
                make.bottom.equalToBottomWithSafe(parent: self.vc.view, offset: 0)
        })
    }
}
