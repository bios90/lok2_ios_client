import UIKit

class FactoryRegister
{
    static let top_margin_sm = 6
    static let top_margin_l = 10
    static let element_width = 240
    static let avatar_height = 80
    static let tf_height = 34
    
    let vc:BaseViewController
    
    let img_bg:UIImageView =
    {
        let img = UIImageView(image: MyImage.bg_main.getImage())
        img.contentMode = .scaleToFill
        return img
    }()
    
    let btn_back : BtnRipple =
    {
        let btn = BtnRipple()
        let img_arrow_back = MyImage.ic_arrow_back.getImage().setColorMy(MyColors.gi.white)
        btn.addImage(image: img_arrow_back, size: 24)
        return btn
    }()
    
    let view_for_elements:UIView =
    {
        let view = UIView()
        return view
    }()
    
    let btn_img_avatar:BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.white
        btn.setRippleColor(color: MyColors.gi.red.withAlphaComponent(0.2))
        btn.setRippleCornerRadius(radius: 40)
        btn.layer.cornerRadius = 40
        btn.clipsToBounds = false
        btn.addShadowMin()
        return btn
    }()
    
    let img_avatar : UIImageView =
    {
        let img = UIImageView()
        img.clipsToBounds = true
        img.layer.cornerRadius = 40
        img.contentMode = .scaleAspectFill
        img.image = MyImage.ic_user_avatar.getImage()
        return img
    }()

    let lbl_first_name:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_m
        lbl.textColor = MyColors.gi.gray5
        lbl.text = MyString.name.localized()
        return lbl
    }()
    
    let tf_first_name:BaseTextField =
    {
        let tf = ViewsHelper.getGrayStrokedTf()
        tf.textAlignment = .center
        tf.textColor = MyColors.gi.gray8
        return tf
    }()
    
    let lbl_last_name:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_m
        lbl.textColor = MyColors.gi.gray5
        lbl.text = MyString.last_name.localized()
        return lbl
    }()
    
    let tf_last_name:BaseTextField =
    {
        let tf = ViewsHelper.getGrayStrokedTf()
        tf.textAlignment = .center
        tf.textColor = MyColors.gi.gray8
        return tf
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
    
    let lbl_password1:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_m
        lbl.textColor = MyColors.gi.gray5
        lbl.text = MyString.password.localized()
        return lbl
    }()
    
    let tf_password1:BaseTextField =
    {
        let tf = ViewsHelper.getGrayStrokedTf()
        tf.textAlignment = .center
        tf.isSecureTextEntry = true
        tf.textColor = MyColors.gi.gray8
        return tf
    }()
    
    let lbl_password2:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_m
        lbl.textColor = MyColors.gi.gray5
        lbl.text = MyString.repeat_password.localized()
        return lbl
    }()
    
    let tf_password2:BaseTextField =
    {
        let tf = ViewsHelper.getGrayStrokedTf()
        tf.textAlignment = .center
        tf.isSecureTextEntry = true
        tf.textColor = MyColors.gi.gray8
        return tf
    }()
    
    let btn_register:BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.red
        btn.br_text_color.accept(MyColors.gi.white)
        btn.br_text.accept(MyString.registration.localized())
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        return btn
    }()
    
    let btn_privacy_policy:BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.transparent
        btn.setRippleColor(color: MyColors.gi.white.withAlphaComponent(0.2))
        btn.br_text_color.accept(MyColors.gi.white)
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
        self.vc.view.addSubview(img_bg)
        self.vc.view.addSubview(btn_back)
        self.vc.view.addSubview(view_for_elements)
        self.view_for_elements.addSubview(btn_img_avatar)
        self.btn_img_avatar.addSubview(img_avatar)
        self.view_for_elements.addSubview(lbl_first_name)
        self.view_for_elements.addSubview(tf_first_name)
        self.view_for_elements.addSubview(lbl_last_name)
        self.view_for_elements.addSubview(tf_last_name)
        self.view_for_elements.addSubview(lbl_email)
        self.view_for_elements.addSubview(tf_email)
        self.view_for_elements.addSubview(lbl_password1)
        self.view_for_elements.addSubview(tf_password1)
        self.view_for_elements.addSubview(lbl_password2)
        self.view_for_elements.addSubview(tf_password2)
        self.view_for_elements.addSubview(btn_register)
        self.vc.view.addSubview(btn_privacy_policy)
        
        img_bg.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        btn_back.snp.makeConstraints(
            { make in
                
                make.top.equalToTopWithSafe(parent: self.vc.view, offset: 6)
                make.left.equalToSuperview().offset(6)
                make.width.height.equalTo(24)
        })
        
        
        view_for_elements.snp.makeConstraints(
            { make in
                
                make.width.equalTo(FactoryRegister.element_width)
                make.center.equalToSuperview()
                make.top.equalTo(btn_img_avatar.snp.top)
                make.bottom.equalTo(btn_register.snp.bottom)
        })
        
        btn_img_avatar.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
                make.width.height.equalTo(80)
        })
        
        img_avatar.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        lbl_first_name.snp.makeConstraints(
            { make in
                
                make.centerX.equalToSuperview()
                make.top.equalTo(btn_img_avatar.snp.bottom).offset(FactoryRegister.top_margin_l)
        })
        
        tf_first_name.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalToSuperview()
                make.top.equalTo(lbl_first_name.snp.bottom).offset(FactoryRegister.top_margin_sm)
                make.height.equalTo(FactoryRegister.tf_height)
        })
        
        
        lbl_last_name.snp.makeConstraints(
            { make in
                
                make.centerX.equalToSuperview()
                make.top.equalTo(tf_first_name.snp.bottom).offset(FactoryRegister.top_margin_l)
        })
        
        tf_last_name.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalToSuperview()
                make.top.equalTo(lbl_last_name.snp.bottom).offset(FactoryRegister.top_margin_sm)
                make.height.equalTo(FactoryRegister.tf_height)
        })
        
        
        lbl_email.snp.makeConstraints(
            { make in
                
                make.centerX.equalToSuperview()
                make.top.equalTo(tf_last_name.snp.bottom).offset(FactoryRegister.top_margin_l)
        })
        
        tf_email.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalToSuperview()
                make.top.equalTo(lbl_email.snp.bottom).offset(FactoryRegister.top_margin_sm)
                make.height.equalTo(FactoryRegister.tf_height)
        })
        
        
        
        lbl_password1.snp.makeConstraints(
            { make in
                
                make.centerX.equalToSuperview()
                make.top.equalTo(tf_email.snp.bottom).offset(FactoryRegister.top_margin_l)
        })
        
        tf_password1.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalToSuperview()
                make.top.equalTo(lbl_password1.snp.bottom).offset(FactoryRegister.top_margin_sm)
                make.height.equalTo(FactoryRegister.tf_height)
        })
        
        
        
        lbl_password2.snp.makeConstraints(
            { make in
                
                make.centerX.equalToSuperview()
                make.top.equalTo(tf_password1.snp.bottom).offset(FactoryRegister.top_margin_l)
        })
        
        tf_password2.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalToSuperview()
                make.top.equalTo(lbl_password2.snp.bottom).offset(FactoryRegister.top_margin_sm)
                make.height.equalTo(FactoryRegister.tf_height)
        })
        
        
        
        btn_register.snp.makeConstraints(
            { make in
          
                make.width.centerX.equalToSuperview()
                make.top.equalTo(tf_password2.snp.bottom).offset(22)
                make.height.equalTo(40)
        })
        
        
        btn_privacy_policy.snp.makeConstraints(
            { make in
                
                make.bottom.equalToBottomWithSafe(parent: self.vc.view, offset: 0)
                make.centerX.width.equalToSuperview()
                make.height.equalTo(40)
        })
        
    }
}
