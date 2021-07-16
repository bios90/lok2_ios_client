import UIKit
import DeepDiff

class ViewCategoryShow:BaseViewController
{
    var vm_category_show:VmCategoryShow!
    var factory_category_show:FactoryCategoryShow!
    var documents:[ModelDocument] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_category_show)
        factory_category_show = FactoryCategoryShow(vc: self)
        setupNavBar()
        
        setEvents()
        setListeners()
    }
    
    private func setupNavBar()
    {
        status_bar_style = .lightContent
        show_navbar = true
        self.navigationController?.navigationBar.barTintColor = MyColors.gi.red
        let btn_left = BtnAction(text: "Назад", action:
        { _ in
            self.vm_category_show.clickedBack()
        })
        setBtnLeft(btn: btn_left)
        setNavbarTitleColor(color: MyColors.gi.white)
    }
    
    private func setEvents()
    {
        vm_category_show.br_documents_to_display
            .subscribe(onNext:
                { display_info in
                    
                    if case LoadBehaviour.FULL_RELOAD = display_info.behaviour
                    {
                        self.documents = []
                        self.factory_category_show.tb_documents.reloadData()
                    }
                    
                    let changes = diff(old: self.documents, new: display_info.items)
                    
                    self.factory_category_show.tb_documents.reload(changes:changes,updateData:
                        {
                            self.documents = display_info.items
                    })
            })
            .disposed(by: dispose_bag)
        
        vm_category_show.br_category
            .subscribe(onNext:
                { category in
                    
                    guard let title = category?.title else { return }
                    
                    self.navigationItem.title = title
            })
        .disposed(by: dispose_bag)
    }
    
    private func setListeners()
    {
        factory_category_show.tb_documents.delegate = self
        factory_category_show.tb_documents.dataSource = self
        (factory_category_show.la_search.tf_search <-> vm_category_show.br_search_text).disposed(by: dispose_bag)
    }
}

extension ViewCategoryShow:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let document = documents[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellDocument.reuse_id) as! CellDocument
        cell.bindDocument(document: document)
        cell.root_btn.removeClickAction()
        cell.root_btn.addAction {
            self.vm_category_show.clickedDocument(document: document)
        }
        return cell
    }
}
