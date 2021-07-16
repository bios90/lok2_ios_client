import Foundation

class ModelUser:Codable,ObjectWithId,ObjectWithDates
{
    var id:Int?
    var created: Date?
    var updated: Date?
    var deleted: Date?
    var first_name:String?
    var last_name:String?
    var email:String?
    var email_verified:Bool?
    var url_avatar:String?
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeInt(from: .id)
        self.created = try? container.decodeDate(from: .created)
        self.updated = try? container.decodeDate(from: .updated)
        self.deleted = try? container.decodeDate(from: .deleted)
        self.first_name = try? container.decodeString(from: .first_name)
        self.last_name = try? container.decodeString(from: .last_name)
        self.email = try? container.decodeString(from: .email)
        self.email_verified = try? container.decodeBool(from: .email_verified)
        self.url_avatar = try? container.decodeString(from: .url_avatar)
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case created
        case deleted
        case updated
        case first_name
        case last_name
        case email
        case email_verified
        case url_avatar
    }
    
    func getFullName()->String
    {
        return "\(last_name ?? "") \(first_name ?? "")"
    }
}
