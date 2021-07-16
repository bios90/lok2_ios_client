import UIKit
import DeepDiff

class ViewCategs:BaseViewController
{
    var vm_categs:VmCategs!
    var factory_categs:FactoryCategs!
    var categories:[ModelCategory] = []
    
    override func viewDidLoad()
    {
        status_bar_style = .default
        super.viewDidLoad()
        factory_categs = FactoryCategs(vc: self)
        setEvents()
        setListeners()
    }
    
    private func setListeners()
    {
        factory_categs.tb_categs.delegate = self
        factory_categs.tb_categs.dataSource = self
    }
    
    private func setEvents()
    {
        vm_categs.br_categories
            .subscribe(onNext:
                { display_info in
                    
                    if case LoadBehaviour.FULL_RELOAD = display_info.behaviour
                    {
                        self.categories = []
                        self.factory_categs.tb_categs.reloadData()
                    }
                    
                    let changes = diff(old: self.categories, new: display_info.items)
                    
                    self.factory_categs.tb_categs.reload(changes:changes,updateData:
                        {
                            self.categories = display_info.items
                    })
            })
            .disposed(by: dispose_bag)
    }
}

extension ViewCategs:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let category = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellCategory.reuse_id) as! CellCategory
        cell.bindCategory(category: category)
        cell.root_btn.removeClickAction()
        cell.root_btn.addAction {
            self.vm_categs.clickedCategory(category: category)
        }
        return cell
    }
}
