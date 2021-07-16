import UIKit
import DeepDiff

class ViewFavorites:BaseViewController
{
    var vm_favorites:VmFavorites!
    var factory_favorites:FactoryFavorites!
    var documents:[ModelDocument] = []
    
    override func viewDidLoad()
    {
        status_bar_style = .default
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_favorites)
        factory_favorites = FactoryFavorites(vc: self)
       
        setEvents()
        setListeners()
        
        factory_favorites.tb_documents.reloadData()
    }
    
    private func setEvents()
    {
        vm_favorites.br_documents_to_display
            .subscribe(onNext:
                { display_info in
                    
                    if case LoadBehaviour.FULL_RELOAD = display_info.behaviour
                    {
                        self.documents = []
                        self.factory_favorites.tb_documents.reloadData()
                    }
                    
                    let changes = diff(old: self.documents, new: display_info.items)
                    
                    self.factory_favorites.tb_documents.reload(changes:changes,updateData:
                        {
                            self.documents = display_info.items
                    })
            })
            .disposed(by: dispose_bag)
    }
    
    private func setListeners()
    {
        factory_favorites.tb_documents.delegate = self
        factory_favorites.tb_documents.dataSource = self
    }
}

extension ViewFavorites:UITableViewDataSource,UITableViewDelegate
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
            self.vm_favorites.clickedDocument(document: document)
        }
        return cell
    }
}
