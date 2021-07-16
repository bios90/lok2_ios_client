import Foundation
import RxSwift
import RxCocoa

class VmCategoryShow:BaseVm
{
    let br_category_id:BehaviorRelay<Int?> = BehaviorRelay.init(value: nil)
    let br_category:BehaviorRelay<ModelCategory?> = BehaviorRelay.init(value: nil)
    let br_documents_to_display:BehaviorRelay<FeedDisplayInfo<ModelDocument>> = BehaviorRelay.init(value: FeedDisplayInfo(items: [], behaviour: .FULL_RELOAD))
    let br_search_text:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    
    override init()
    {
        super.init()
        setEvents()
    }
    
    private func setEvents()
    {
        br_category_id.subscribe(onNext:
            { category_id in
                
                guard let category_id = category_id else { return }
                
                self.base_networker.getCategoryById(category_id: category_id, action_success:
                    { category in
                        
                        self.br_category.accept(category)
                })
                
                self.reloadDocuments()
        })
            .disposed(by: dispose_bag)
        
        br_search_text
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .subscribe(onNext:
            { _ in
                
                self.reloadDocuments()
        })
        .disposed(by: dispose_bag)
    }
    
    private func reloadDocuments()
    {
        guard let category_id = br_category_id.value else { return }
        base_networker.getDocuments(category_id: category_id, search: br_search_text.value, action_success:
            { documents in
                
                self.br_documents_to_display.accept(FeedDisplayInfo(items: documents, behaviour: .UPDATE))
        })
    }
}

//MARK: -Listeners
extension VmCategoryShow
{
    func clickedBack()
    {
        ps_dissmiss_vc.onNext(true)
    }
}

