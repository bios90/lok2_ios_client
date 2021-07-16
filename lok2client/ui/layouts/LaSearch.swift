import UIKit

class LaSearch:UIView
{
    let tf_search:UITextField =
    {
        let tf = UITextField()
        tf.font = MyFonts.gi.reg_m
        tf.textColor = MyColors.gi.gray7
        tf.setPlaceHolder(text: MyString.search.localized(), color: MyColors.gi.gray4)
        return tf
    }()
    
    let img_search :UIImageView =
    {
        let image = UIImageView(image: MyImage.ic_search.getImage())
        image.setImageColor(color: MyColors.gi.gray4)
        return image
    }()
    
    init()
    {
        super.init(frame: .zero)
        self.addShadowMin()
        self.backgroundColor = MyColors.gi.white
        self.layer.cornerRadius = 4
        self.layer.shadowOpacity = 1
        
        setupViews()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews()
    {
        self.addSubview(img_search)
        self.addSubview(tf_search)
        
        img_search.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-12)
                make.width.height.equalTo(22)
                make.centerY.equalToSuperview()
        })
        
        tf_search.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalTo(img_search.snp.left).offset(-12)
                make.centerY.equalToSuperview()
        })
    }
}
