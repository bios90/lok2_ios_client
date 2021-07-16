import Foundation

class BaseNetworker
{
    let base_vm:BaseVm
    
    init(base_vm:BaseVm)
    {
        self.base_vm = base_vm
    }
    
    func makeRegister(first_name:String,last_name:String,email:String,password:String,avatar:String?,action_success:@escaping(ModelUser)->Void,action_error:((Error)->Void)? = nil)
    {
        MyRequest.getReqRegister(first_name: first_name, last_name: last_name, email: email, password: password, avatar: avatar)
            .toObservable()
            .mainThreated()
            .addMyParser(type: RespUserSingle.self)
            .addParsingFilter({ $0.user != nil })
            .addProgressDialog()
            .addScreenDisabling()
            .addMyErrorChecker()
            .subscribeMy(
                { response in
                    
                    action_success(response.user!)
            },
                { error in
                    
                    action_error?(error)
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func makeLogin(email:String,password:String,push_token:String?,action_success:@escaping(ModelUser)->Void,action_error:((Error)->Void)? = nil)
    {
        MyRequest.getReqLogin(email: email, password: password, push_token: push_token)
            .toObservable()
            .addMyParser(type: RespUserSingle.self)
            .addParsingFilter({ $0.user != nil })
            .addProgressDialog()
            .addMyErrorChecker()
            .addScreenDisabling()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.user!)
            },
                { error in
                    
                    action_error?(error)
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func getUserById(user_id:Int,action_success:@escaping(ModelUser)->Void)
    {
        MyRequest.getUserById(user_id: user_id)
            .toObservable()
            .addProgressDialog()
            .addScreenDisabling()
            .addMyParser(type: RespUserSingle.self)
            .addParsingFilter({ $0.user != nil })
            .addMyErrorChecker()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.user!)
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func updateUser(user_id:Int,first_name:String?,last_name:String?,email:String?,password:String?,avatar:String?,action_success:@escaping(ModelUser)->Void,action_error:((Error)->Void)? = nil)
    {
        MyRequest.getReqUpdategUser(user_id: user_id, first_name: first_name, last_name: last_name, password: password, avatar: avatar)
            .toObservable()
            .addProgressDialog()
            .addScreenDisabling()
            .addMyParser(type: RespUserSingle.self)
            .addParsingFilter({ $0.user != nil })
            .addMyErrorChecker()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.user!)
            },
                { error in
                    
                    action_error?(error)
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func makePasswordReset(email:String,action_success:@escaping()->Void)
    {
        MyRequest.getReqPassRecover(email: email)
            .toObservable()
            .addMyParser(type: BaseResponse.self)
            .addProgressDialog()
            .addMyErrorChecker()
            .addScreenDisabling()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success()
            },
                { error in
                    
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func getAllCategories(action_success:@escaping([ModelCategory])->Void)
    {
        MyRequest.getAllCategories()
            .toObservable()
            .addMyParser(type: RespCategories.self)
            .addParsingFilter({ $0.categories != nil })
            .addProgressDialog()
            .addMyErrorChecker()
            .addScreenDisabling()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.categories!)
            },
                { error in
                    
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func getDocuments(category_id:Int?,search:String?,action_success:@escaping([ModelDocument])->Void)
    {
        MyRequest.getDocuments(category_id: category_id, search: search)
            .toObservable()
            .addMyParser(type: RespDocuments.self)
            .addParsingFilter({ $0.documents != nil })
            .addProgressDialog()
            .addMyErrorChecker()
            .addScreenDisabling()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.documents!)
            },
                { error in
                    
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func getCategoryById(category_id:Int,action_success:@escaping(ModelCategory)->Void)
    {
        MyRequest.getCategoryById(category_id: category_id)
            .toObservable()
            .addMyParser(type: RespCategorySingle.self)
            .addParsingFilter({ $0.category != nil })
            .addProgressDialog()
            .addMyErrorChecker()
            .addScreenDisabling()
        .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.category!)
            },
                { error in
                    
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func downloadFile(url:String,action_success:@escaping(String)->Void)
    {
        MyRequest.getFileDownloadRequest(url_str: url)
            .toObservableFileDownload()
            .addProgressDialog()
            .addMyErrorChecker()
            .addScreenDisabling()
            .mainThreated()
            .subscribeMy(
                { file_path in
                    
                    guard let file_path = file_path else { return }
                    action_success(file_path)
            },
                { error in
                    
            })
            .disposed(by:base_vm.dispose_bag)
    }
    
    func loadFavorites(favorites_str:String,action_success:@escaping([ModelDocument])->Void)
    {
        MyRequest.getFavorites(ids_as_str: favorites_str)
            .toObservable()
            .addMyParser(type: RespDocuments.self)
            .addParsingFilter({ $0.documents != nil })
            .addProgressDialog()
            .addMyErrorChecker()
            .addScreenDisabling()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.documents!)
            },
                { error in
                    
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    
}
