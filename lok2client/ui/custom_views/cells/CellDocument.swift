import UIKit
import DeepDiff

class CellDocument:UITableViewCell
{
    static let reuse_id = "CellDocument"
    var image_height_constraint:NSLayoutConstraint!
    
    let images_info_size = 20
    
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
    
    let img_logo:UIImageView =
    {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 4
        return img
    }()
    
    let lbl_pdf:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_light_m
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.red
        lbl.text = FawString.pdf.rawValue
        return lbl
    }()
    
    let lbl_html:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_light_m
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.red
        lbl.text = FawString.link.rawValue
        return lbl
    }()
    
    let lbl_video:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_light_m
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.red
        lbl.text = FawString.video.rawValue
        return lbl
    }()
    
    let lbl_title:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.red
        lbl.font = MyFonts.gi.bold_l
        lbl.text = "CAtegorryryry"
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let lbl_text:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.font = MyFonts.gi.reg_s
        lbl.text = "CAtegorryryry lsjnskjng  skjgnfsdklfgnajds nfslkns jfkngdflskjgn"
        lbl.numberOfLines = 4
        return lbl
    }()
    
    let lbl_date:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.font = MyFonts.gi.bold_xs
        lbl.text = "22 okt 1204"
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let img_new:UIImageView =
    {
        let img = UIImageView()
        img.image = MyImage.img_new.getImage()
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout_subviews_my()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout_subviews_my()
    {
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        self.backgroundColor = .clear
        
        self.contentView.addSubview(view_root)
        self.view_root.addSubview(root_btn)
        self.root_btn.addSubview(img_logo)
        self.root_btn.addSubview(img_new)
        self.root_btn.addSubview(lbl_title)
        self.root_btn.addSubview(lbl_pdf)
        self.root_btn.addSubview(lbl_video)
        self.root_btn.addSubview(lbl_html)
        self.root_btn.addSubview(lbl_text)
        self.root_btn.addSubview(lbl_date)
        
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
        
        img_logo.translatesAutoresizingMaskIntoConstraints = false
        img_logo.topAnchor.constraint(equalTo: root_btn.topAnchor).isActive = true
        img_logo.leftAnchor.constraint(equalTo: root_btn.leftAnchor).isActive = true
        img_logo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //        img_logo.bottomAnchor.constraint(equalTo: lbl_date.bottomAnchor, constant: 10).isActive = true
        image_height_constraint = img_logo.heightAnchor.constraint(equalToConstant: 100)
        image_height_constraint.isActive = true
        //        img_logo.bottomAnchor.constraint(equalTo: lbl_date.bottomAnchor, constant: 10)
        //                img_logo.snp.makeConstraints(
        //                    { make in
        //
        //                        make.left.top.equalToSuperview()
        //                        make.width.equalTo(100)
        //                        make.height.equalToSuperview()
        //                        //                make.bottom.equalTo(lbl_date.snp.bottom).offset(10)
        //                })
        
        img_new.snp.makeConstraints(
               { make in
                   
                   make.width.height.equalTo(24)
                   make.top.right.equalToSuperview()
           })
        
        lbl_pdf.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(images_info_size)
                make.right.equalToSuperview().offset(-10)
                make.top.equalToSuperview().offset(10)
        })
        
        lbl_video.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(images_info_size)
                make.right.equalTo(lbl_pdf.snp.left).offset(-6)
                make.centerY.equalTo(lbl_pdf.snp.centerY)
        })
        
        lbl_html.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(images_info_size)
                make.right.equalTo(lbl_video.snp.left).offset(-6)
                make.centerY.equalTo(lbl_pdf.snp.centerY)
        })
        
        lbl_title.snp.makeConstraints(
            { make in
                
                make.left.equalTo(img_logo.snp.right).offset(6)
                make.right.equalTo(lbl_html.snp.left).offset(-6)
                make.top.equalToSuperview().offset(10)
        })
        
        lbl_text.snp.makeConstraints(
            { make in
                
                make.left.equalTo(img_logo.snp.right).offset(6)
                make.right.equalToSuperview().offset(-10)
                make.top.equalTo(lbl_title.snp.bottom)
        })
        
        lbl_date.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-10)
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
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        img_logo.kf.cancelDownloadTask()
        img_logo.image = nil
        
    }
    
    func bindDocument(document:ModelDocument)
    {
        //
        
        lbl_pdf.isHidden = document.url_pdf == nil
        lbl_video.isHidden = document.url_video == nil
        lbl_html.isHidden = document.url_html == nil
        
        lbl_title.text = document.title
        lbl_text.text = document.text
        
        if let date = document.updated
        {
            lbl_date.text = "Обновлено: " + date.formatToString()
        }
        else
        {
            lbl_date.text = "Обновлено: -"
        }
        
        if let url_logo = document.url_logo
        {
            self.img_logo.loadImageMy(url_str: url_logo,action_load_finished:
                {
                    self.myLaRecursevly()
                    self.root_btn.myla()
                    runActionWithDelay(milliseconds: 50, action:
                        {
                            self.myLaRecursevly()
                            self.root_btn.myla()
                            let height = self.root_btn.frame.height
                            self.image_height_constraint.constant = height
                            print("Height is \(height)")
                            self.img_logo.myla()
                    })
            })
        }
        
        img_new.isHidden = !document.isNew()
    }
}

