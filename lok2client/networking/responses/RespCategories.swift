import Foundation

class RespCategories:BaseResponse
{
    var categories:[ModelCategory]?
    
    required init(from decoder: Decoder) throws
    {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try? values.decodeArray(type: ModelCategory.self, from: .categories)
    }

    private enum CodingKeys: String, CodingKey
    {
        case categories = "data"
    }
}
