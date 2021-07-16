import UIKit

class CellCategory:UITableViewCell
{
    static let reuse_id = "CellCategory"
    let side_offset = 12
    
    let view_root:UIView =
    {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let root_btn : BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_text.accept("")
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.backgroundColor = MyColors.gi.white
        btn.layer.backgroundColor = MyColors.gi.white.cgColor
        
        return btn
    }()
    
    let img_logo :UIImageView =
    {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let img_new:UIImageView =
    {
        let img = UIImageView()
        img.image = MyImage.img_new.getImage()
        return img
    }()
    
    let lbl_title:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.red
        lbl.font = MyFonts.gi.bold_l
        lbl.text = "CAtegorryryry"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lbl_text:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.font = MyFonts.gi.reg_s
        lbl.text = "CAtegorryryry lsjnskjng  skjgnfsdklfgnajds nfslkns jfkngdflskjgn"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lbl_date:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.font = MyFonts.gi.bold_xs
        lbl.text = "22 okt 1204"
        return lbl
    }()
    
    
    let lbl_documents_count:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.font = MyFonts.gi.bold_xs
        lbl.text = "Docs count is 4324"
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout_subviews()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout_subviews()
    {
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        self.backgroundColor = .clear
        
        self.contentView.addSubview(view_root)
        self.view_root.addSubview(root_btn)
        self.root_btn.addSubview(img_logo)
        self.root_btn.addSubview(img_new)
        self.root_btn.addSubview(lbl_title)
        self.root_btn.addSubview(lbl_text)
        self.root_btn.addSubview(lbl_date)
        self.root_btn.addSubview(lbl_documents_count)
        
        self.view_root.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
                make.bottom.equalTo(root_btn.snp.bottom)
        })
        
        root_btn.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.bottom.equalTo(lbl_date.snp.bottom).offset(10)
                make.top.equalToSuperview().offset(10)
        })
        
        img_logo.snp.makeConstraints(
            { make in
                
                make.left.top.right.equalToSuperview()
                make.height.equalTo(120)
        })
        
        img_new.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(24)
                make.top.right.equalToSuperview()
        })
        
        lbl_title.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(side_offset)
                make.right.equalToSuperview().offset(-side_offset)
                make.top.equalTo(img_logo.snp.bottom).offset(10)
        })
        
        lbl_text.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(side_offset)
                make.right.equalToSuperview().offset(-side_offset)
                make.top.equalTo(lbl_title.snp.bottom)
        })
        
        lbl_date.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(side_offset)
                make.top.equalTo(lbl_text.snp.bottom).offset(8)
        })
        
        lbl_documents_count.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-side_offset)
                make.top.equalTo(lbl_text.snp.bottom).offset(8)
        })
        
        
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        root_btn.layer.masksToBounds = false
        root_btn.layer.shadowColor = MyColors.gi.gray5.cgColor
        root_btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        root_btn.layer.shadowOpacity = 0.45
        root_btn.layer.shadowRadius = 12
    }
    
    func bindCategory(category:ModelCategory)
    {
        if let url_logo = category.url_logo
        {
            img_logo.loadImageMy(url_str: url_logo,
                                 action_load_finished: {
                                    self.layoutIfNeeded()
            })
        }
        
        lbl_title.text = category.title
        lbl_text.text = category.text
        lbl_documents_count.text = "Докуметов: " + String(category.documents?.count ?? 0)
        if let date = category.updated
        {
            lbl_date.text = "Обновлено: " + date.formatToString()
        }
        else
        {
            lbl_date.text = "Обновлено: -"
        }
        
        img_new.isHidden = !category.isNew()
    }
}
