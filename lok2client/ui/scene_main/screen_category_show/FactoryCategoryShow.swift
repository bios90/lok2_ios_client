import UIKit

class FactoryCategoryShow
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
    
    let la_search:LaSearch =
    {
        let la_search = LaSearch()
        return la_search
    }()
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        setupViews()
    }
    
    private func setupViews()
    {
        self.vc.view.backgroundColor = MyColors.gi.white
        self.vc.view.addSubview(la_search)
        self.vc.view.addSubview(tb_documents)
        
        la_search.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.top.equalToTopWithSafe(parent: self.vc.view, offset: 12)
                make.height.equalTo(44)
        })
        
        tb_documents.snp.makeConstraints(
            { make in
                
                make.bottom.left.right.equalToSuperview()
                make.top.equalTo(la_search.snp.bottom)
        })
    }
}
