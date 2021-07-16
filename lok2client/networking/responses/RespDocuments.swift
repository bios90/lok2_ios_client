import Foundation

class RespDocuments:BaseResponse
{
    var documents:[ModelDocument]?
    
    required init(from decoder: Decoder) throws
    {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        documents = try? values.decodeArray(type: ModelDocument.self, from: .documents)
    }

    private enum CodingKeys: String, CodingKey
    {
        case documents = "data"
    }
}
