import UIKit

class ViewsHelper
{
    static func getGrayStrokedTf()->BaseTextField
    {
        let tf = BaseTextField()
        tf.layer.cornerRadius = 4
        tf.clipsToBounds = true
        tf.layer.borderColor = MyColors.gi.gray4.cgColor
        tf.layer.borderWidth = 1
        tf.backgroundColor = MyColors.gi.white
        return tf
    }
    
    static func getDefScroll()->UIScrollView
    {
        let scroll = UIScrollView()
        scroll.bounces = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }
}
