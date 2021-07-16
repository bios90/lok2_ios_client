import UIKit

class FactoryCategs
{
    let vc:BaseViewController
    
    let tb_categs:UITableView =
    {
        let tb = UITableView()
        tb.backgroundColor = MyColors.gi.transparent
        tb.showsVerticalScrollIndicator = false
        tb.tableFooterView = UIView()
        tb.register(CellCategory.self, forCellReuseIdentifier: CellCategory.reuse_id)
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 1000
        tb.separatorInset = UIEdgeInsets.zero
        tb.separatorStyle = UITableViewCell.SeparatorStyle.none
        tb.bounces = false
        
        
        return tb
    }()
    
    let view_tb_bottom : UIView =
    {
        let view = UIView()
        return view
    }()
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        setupViews()
    }
    
    private func setupViews()
    {
        self.vc.view.addSubview(tb_categs)
        tb_categs.tableFooterView = view_tb_bottom
        
        tb_categs.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        view_tb_bottom.snp.makeConstraints(
            { make in
                

                make.height.equalTo(20)
        })
    }
}
