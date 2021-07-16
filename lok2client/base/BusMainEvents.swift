import Foundation
import RxSwift
import RxCocoa

class BusMainEvents
{
    static let gi = BusMainEvents()
    
    let ps_user_favorites_changed:PublishSubject<Void> = PublishSubject.init()
    let ps_to_make_logout:PublishSubject<Void> = PublishSubject.init()
}
