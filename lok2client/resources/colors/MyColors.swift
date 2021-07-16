import UIKit

class MyColors
{
    static let gi = MyColors()
    
    let transparent = colorFromHex(hex: "#FFFFFF").withAlphaComponent(0)
    let white = colorFromHex(hex: "#FFFFFF")
    let white_trans_50 = colorFromHex(hex: "#FFFFFF").withAlphaComponent(50)
    let black = colorFromHex(hex: "#000000")
    let black_trans_50 = colorFromHex(hex: "#FFFFFF").withAlphaComponent(50)
    let gray0 = colorFromHex(hex: "#F9F9F9")
    let gray1 = colorFromHex(hex: "#F3F3F3")
    let gray2 = colorFromHex(hex: "#E9E9E9")
    let gray3 = colorFromHex(hex: "#D9D9D9")
    let gray4 = colorFromHex(hex: "#B9B9B9")
    let gray4_trans_50 = colorFromHex(hex: "#B9B9B9").withAlphaComponent(50)
    let gray5 = colorFromHex(hex: "#8A8A8A")
    let gray6 = colorFromHex(hex: "#5A5A5A")
    let gray7 = colorFromHex(hex: "#383838")
    let gray8 = colorFromHex(hex: "#222222")
    let gray8_trans_50 = colorFromHex(hex: "#222222").withAlphaComponent(50)
    
    
    let red = colorFromHex(hex: "#E7271E")
    let red_light = colorFromHex(hex: "#F7443C")
    let red_dark = colorFromHex(hex: "#CC130B")
    let red_trans_50 = colorFromHex(hex: "#E7271E").withAlphaComponent(50)
    
    let green = colorFromHex(hex: "#2AB398")
    let green_trans_50 = colorFromHex(hex: "#2AB398").withAlphaComponent(50)
    let green_dark = colorFromHex(hex: "#11998E")
    let green_light = colorFromHex(hex: "#43CEA2")
    
    let yellow = colorFromHex(hex: "#F5A623")
    
    static func colorFromHex (hex:String) -> UIColor
    {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
