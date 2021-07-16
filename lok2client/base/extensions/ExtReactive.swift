import Foundation
import RxSwift
import RxCocoa

public extension Observable
{
    func doFinally(_ action:@escaping()->())->Observable
    {
        return self.do(afterError:
            { _ in
                action()
        },afterCompleted:
            {
                action()
        })
    }
    
    func addScreenDisabling() ->  Observable
    {
        return self.do(onSubscribed:
            {
                MessagesManager.disableScreenTouches()
        }).doFinally(
            {
                MessagesManager.enableScreenTouches()
        })
    }
    
    func mainThreated()->Observable
    {
        return self
            .observeOn(MainScheduler.instance)
    }
    
    func addProgressDialog() -> Observable
    {
        return self.do(onSubscribed:
            {
                MessagesManager.showProgressNewDelayed()
        })
            .doFinally(
                {
                    MessagesManager.dismissProgressNewDelayed()
            })
    }
    
    func subscribeMy(_ action_success:@escaping(Element)->Void,_ action_error:((Error)->())? = nil)->Disposable
    {
        return self.subscribe(onNext:
            { element in
                
                action_success(element);
        },onError:
            { error in
                action_error?(error)
        })
    }
    
    func addMyErrorChecker() -> Observable
    {
        self.do(onError:
            { error in
                
                switch error
                {
                case RequestError.ErrEmailOccupied:
                    print("Email occupied error")
                case RequestError.ErrConnection:
                    MessagesManager.showNoInternet()
                case RequestError.ErrServerFailed(let message):
                    MessagesManager.showRedAlerter(text: message)
                case RequestError.ErrJsonDecode:
                    MessagesManager.showRedAlerter(text: MyString.error_parsing.localized())
                case RequestError.ErrServer:
                    print("**** Got Error on Server Size with no message ****")
                    fallthrough
                default:
                    MessagesManager.showRedAlerter(text: MyString.error_default.localized())
                }
        })
    }
    
    func addParsingFilter(_ check:@escaping(Element)->Bool)->Observable
    {
        return self.map(
            { element in
                
                if(!check(element))
                {
                    throw RequestError.ErrJsonDecode
                }
                
                return element
        })
    }
}
