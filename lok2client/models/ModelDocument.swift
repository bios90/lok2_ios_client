import Foundation
import DeepDiff

class ModelDocument:Codable,ObjectWithId,ObjectWithDates
{
    var id:Int?
    var created: Date?
    var updated: Date?
    var deleted: Date?
    var title:String?
    var text:String?
    var url_logo:String?
    var url_pdf:String?
    var url_html:String?
    var url_video:String?
    var pdf_file_name:String?
    
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
        self.url_pdf = try? container.decodeString(from: .url_pdf)
        self.url_html = try? container.decodeString(from: .url_html)
        self.url_video = try? container.decodeString(from: .url_video)
        self.pdf_file_name = try? container.decodeString(from: .pdf_file_name)
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
        case url_pdf
        case url_html
        case url_video
        case pdf_file_name
    }
}

extension ModelDocument:DiffAware
{
    var diffId: Int
    {
        return id!
    }
    
    static func compareContent(_ a: ModelDocument, _ b: ModelDocument) -> Bool
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
        
        if(a.url_pdf != b.url_pdf)
        {
            return false
        }
        
        if(a.url_video != b.url_video)
        {
            return false
        }
        
        if(a.url_html != b.url_html)
        {
            return false
        }
        
        return true
    }
}

