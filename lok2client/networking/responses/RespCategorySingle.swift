import Foundation

class RespCategorySingle:BaseResponse
{
    var category:ModelCategory?
    
    required init(from decoder: Decoder) throws
    {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try? values.decode(ModelCategory.self, forKey: .category)
    }

    private enum CodingKeys: String, CodingKey
    {
        case category = "data"
    }
}
