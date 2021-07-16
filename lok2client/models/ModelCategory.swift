import Foundation
import DeepDiff

class ModelCategory:Codable,ObjectWithId,ObjectWithDates
{
    var id:Int?
    var created: Date?
    var updated: Date?
    var deleted: Date?
    var title:String?
    var text:String?
    var url_logo:String?
    var documents:[ModelDocument]?
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeInt(from: .id)
        self.created = try? container.decodeDate(from: .created)
        self.updated = try? container.decodeDate(from: .updated)
        self.deleted = try? container.decodeDate(from: .deleted)
        self.title = try? container.decodeString(from: .title)
        self.text = try? container.decodeString(from: .text)
        self.url_logo = try? container.decodeString(from: .url_logo)
        self.documents = try? container.decodeArray(type: ModelDocument.self, from: .documents)
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case created = "created_at"
        case deleted = "deleted_at"
        case updated = "updated_at"
        case title
        case text
        case url_logo
        case documents
    }
}

extension ModelCategory:DiffAware
{
    var diffId: Int
    {
        return id!
    }
    
    static func compareContent(_ a: ModelCategory, _ b: ModelCategory) -> Bool
    {
        if(a.updated != b.updated)
        {
            return false
        }
        
        if(a.url_logo != b.url_logo)
        {
            return false
        }
        
        if(a.title != b.title)
        {
            return false
        }
        
        if(a.text != b.text)
        {
            return false
        }
        
        if(a.documents?.count != b.documents?.count)
        {
            return false
        }
        
        return true
    }
}
