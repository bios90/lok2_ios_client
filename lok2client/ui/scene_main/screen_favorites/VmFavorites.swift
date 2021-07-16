import Foundation
import RxSwift
import RxCocoa

class VmFavorites:BaseVm
{
    let br_documents_to_display:BehaviorRelay<FeedDisplayInfo<ModelDocument>> = BehaviorRelay.init(value: FeedDisplayInfo(items: [], behaviour: .FULL_RELOAD))
    
    override init()
    {
        super.init()
        setEvents()
        
        self.reloadFavorites()
    }
    
    private func setEvents()
    {
        BusMainEvents.gi.ps_user_favorites_changed
            .subscribe(onNext:
                {
                    
                    self.reloadFavorites()
            })
            .disposed(by: dispose_bag)
    }
    
    private func reloadFavorites()
    {
        let favorites_as_str = LocalData.getUserFavorites().getIdsStr()
        if favorites_as_str == nil
        {
            br_documents_to_display.accept(FeedDisplayInfo(items: [], behaviour: .FULL_RELOAD))
        }
        else
        {   
            base_networker.loadFavorites(favorites_str: favorites_as_str!, action_success:
                { documents in
                    self.br_documents_to_display.accept(FeedDisplayInfo(items:documents, behaviour: .UPDATE))
            })
        }
    }
}
