import Foundation

protocol ObjectWithId
{
    var id:Int? { get set }
}

protocol ObjectWithDates
{
    var created: Date? { get set }
    var updated: Date? { get set }
    var deleted: Date? { get set }
}

extension ObjectWithDates
{
    func isNew()->Bool
    {
        guard let updated = updated,
        let diff_hours = getDateInterval(recent: Date(), previous: updated).hour
            else { return false }
        
        return diff_hours < 48
    }
}

class FeedDisplayInfo<T>
{
    let behaviour:LoadBehaviour
    let items:[T]
    
    init(items:[T], behaviour:LoadBehaviour)
    {
        self.behaviour = behaviour
        self.items = items
    }
}


