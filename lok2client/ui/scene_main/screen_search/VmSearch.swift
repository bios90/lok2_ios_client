import Foundation
import RxSwift
import RxCocoa

class VmSearch:BaseVm
{
    let br_documents_to_display:BehaviorRelay<FeedDisplayInfo<ModelDocument>> = BehaviorRelay.init(value: FeedDisplayInfo(items: [], behaviour: .FULL_RELOAD))
    let br_search_text:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    
    override init()
    {
        super.init()
        setEvents()
    }
    
    private func setEvents()
    {
        br_search_text
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .subscribe(onNext:
                { text in
                    
                    self.reloadDocuments()
            })
            .disposed(by: dispose_bag)
    }
    
    private func reloadDocuments()
    {
        let search_text = br_search_text.value
        
        if(search_text == nil)
        {
            self.br_documents_to_display.accept(FeedDisplayInfo(items: [], behaviour: .FULL_RELOAD))
        }
        else
        {
            base_networker.getDocuments(category_id: nil, search: search_text, action_success:
                { documents in
                    
                    self.br_documents_to_display.accept(FeedDisplayInfo(items: documents, behaviour: .UPDATE))
            })
        }
    }
}
