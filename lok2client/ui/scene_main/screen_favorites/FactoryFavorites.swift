import UIKit

class FactoryFavorites
{
    let vc:BaseViewController
    
    let tb_documents:UITableView =
    {
        let tb = UITableView()
        tb.backgroundColor = MyColors.gi.transparent
        tb.showsVerticalScrollIndicator = false
        tb.tableFooterView = UIView()
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 1000
        tb.register(CellDocument.self, forCellReuseIdentifier: CellDocument.reuse_id)
        tb.separatorInset = UIEdgeInsets.zero
        tb.separatorStyle = UITableViewCell.SeparatorStyle.none
        tb.bounces = false
        
        return tb
    }()
    
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        setupViews()
    }
    
    private func setupViews()
    {
        self.vc.view.addSubview(tb_documents)
        
        tb_documents.snp.makeConstraints(
            { make in
                
                make.bottom.top.left.right.equalToSuperview()
        })
    }
}
