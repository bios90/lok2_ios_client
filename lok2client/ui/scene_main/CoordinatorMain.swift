import UIKit

class CoordinatorMain:BaseCoordinator
{
    let vm_tab_wrapper = VmTabWrapper()
    let vm_categs = VmCategs()
    let vm_favorites = VmFavorites()
    let vm_search = VmSearch()
    let vm_profile = VmProfile()
    let vm_category_show = VmCategoryShow()
    
    override init(nav_controller: BaseNavController)
    {
        super.init(nav_controller: nav_controller)
        setEvents()
    }
    
    private func setEvents()
    {
        vm_categs.ps_clicked_category
            .subscribe(onNext:
                { category in
                    
                    guard let category_id = category.id else { return }
                    self.toCategoryShow(category_id: category_id)
            }).disposed(by: dispose_bag)
        
        BusMainEvents.gi.ps_to_make_logout
            .subscribe(onNext:
                {
                    LocalData.clearCurrentUser()
                    AppDelegate.gi.startAuth()
            })
        .disposed(by: dispose_bag)
    }
}

extension CoordinatorMain
{
    func toScreenMain()
    {
        let vc_categs = ViewCategs()
        vc_categs.vm_categs = vm_categs
        let img_pair_categs = HelperImages.getImgPairForTabs(img: MyImage.ic_categ.getImage())
        let tab_icon_categs = UITabBarItem(title: MyString.categories.localized(), image: img_pair_categs.img_normal, selectedImage: img_pair_categs.img_selected)
        vc_categs.tabBarItem = tab_icon_categs
        
        let vc_favorites = ViewFavorites()
        vc_favorites.vm_favorites = vm_favorites
        let img_pair_favorites = HelperImages.getImgPairForTabs(img: MyImage.ic_heart.getImage())
        let tab_icon_favorites = UITabBarItem(title: MyString.favorites.localized(), image: img_pair_favorites.img_normal, selectedImage: img_pair_favorites.img_selected)
        vc_favorites.tabBarItem = tab_icon_favorites
        
        let vc_search = ViewSearch()
        vc_search.vm_search = vm_search
        let img_pair_search = HelperImages.getImgPairForTabs(img: MyImage.ic_search.getImage())
        let tab_icon_search = UITabBarItem(title: MyString.search.localized(), image: img_pair_search.img_normal, selectedImage: img_pair_search.img_selected)
        vc_search.tabBarItem = tab_icon_search
        
        let vc_profile = ViewProfile()
        vc_profile.vm_profile = vm_profile
        let img_pair_profile = HelperImages.getImgPairForTabs(img: MyImage.ic_user.getImage())
        let tab_icon_profile = UITabBarItem(title: MyString.profile.localized(), image: img_pair_profile.img_normal, selectedImage: img_pair_profile.img_selected)
        vc_profile.tabBarItem = tab_icon_profile

        let vc_wrapper = ViewTabWrapper()
        vc_wrapper.vm_tab_wrapper = vm_tab_wrapper
        vc_wrapper.viewControllers = [vc_categs,vc_favorites,vc_search,vc_profile]
        navigation_controller.clearAndPush(vc: vc_wrapper)

        vc_wrapper.preloadAllControllers()
        ViewTabWrapper.applyTabsButtonsColors()
    }
    
    func toCategoryShow(category_id:Int)
    {
        let vc = ViewCategoryShow()
        vc.vm_category_show = VmCategoryShow()
        navigation_controller.pushViewController(vc, animated: true)
        
        vc.vm_category_show.br_category_id.accept(category_id)
    }
}
