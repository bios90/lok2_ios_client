import Foundation
import RxSwift
import RxCocoa

class VmCategs:BaseVm
{
    var br_categories:BehaviorRelay<FeedDisplayInfo<ModelCategory>> = BehaviorRelay.init(value: FeedDisplayInfo(items: [], behaviour: .FULL_RELOAD))
    let ps_clicked_category:PublishSubject<ModelCategory> = PublishSubject.init()
    
    override init()
    {
        super.init()
        reloadCategories()
    }
    
    private func reloadCategories()
    {
        base_networker.getAllCategories(action_success:
            { categories in
                
                self.br_categories.accept(FeedDisplayInfo(items: categories, behaviour: .UPDATE))
        })
    }
}

//MARK: -Listeners
extension VmCategs
{
    func clickedCategory(category:ModelCategory)
    {
        ps_clicked_category.onNext(category)
    }
}
