import Foundation

class ModelUserFavorite:Codable
{
    var set:Set<Int> = Set<Int>()
    
    init()
    {
        
    }
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.set = try container.decodeSet(type: Int.self, from: .set) ?? Set<Int>()
    }
    
    enum CodingKeys: String, CodingKey
    {
        case set
    }
    
    func getIdsStr() -> String?
    {
        if(set.count == 0)
        {
            return nil
        }
        
        let arr = set.map({ String($0) })
        return listOfStringToSingle(strings: arr,separator: "-")
    }
}
