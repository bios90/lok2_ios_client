import UIKit
import DeepDiff

class ViewSearch:BaseViewController
{
    var vm_search:VmSearch!
    var factory_search:FactorySearch!
    var documents:[ModelDocument] = []
    
    override func viewDidLoad()
    {
        status_bar_style = .default
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_search)
        factory_search = FactorySearch(vc: self)
        
        setEvents()
        setListeners()
    }
    
    private func setEvents()
    {
        vm_search.br_documents_to_display
            .subscribe(onNext:
                { display_info in
                    
                    if case LoadBehaviour.FULL_RELOAD = display_info.behaviour
                    {
                        self.documents = []
                        self.factory_search.tb_documents.reloadData()
                    }
                    
                    let changes = diff(old: self.documents, new: display_info.items)
                    
                    self.factory_search.tb_documents.reload(changes:changes,updateData:
                        {
                            self.documents = display_info.items
                    })
            })
            .disposed(by: dispose_bag)
    }
    
    private func setListeners()
    {
        factory_search.tb_documents.delegate = self
        factory_search.tb_documents.dataSource = self
        (factory_search.la_search.tf_search <-> vm_search.br_search_text).disposed(by: dispose_bag)
    }
}

extension ViewSearch:UITableViewDataSource,UITableViewDelegate
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
            self.vm_search.clickedDocument(document: document)
        }
        return cell
    }
}
