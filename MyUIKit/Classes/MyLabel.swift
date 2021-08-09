import Foundation

class MyLabel: UILabel {
    
    /// 字间距 默认值：1.0
    var wordSpace: Float = 1.0 {
        willSet {
            textStyle(wordSpace: newValue, lineSpace: lineSpace, lineHeight: lineHeight)
        }
    }
    
    /// 行间距 默认值：1.0
    var lineSpace: Float = 1.0 {
        willSet {
            textStyle(wordSpace: wordSpace, lineSpace: newValue, lineHeight: lineHeight)
        }
    }
    
    /// 段落高度 默认值：1.0
    var lineHeight: Float = 1.0 {
        willSet {
            textStyle(wordSpace: wordSpace, lineSpace: lineSpace, lineHeight: newValue)
        }
    }
    
    /// 字体大小
    var fontSize: CGFloat? {
        willSet {
            font = UIFont.init(name: font.familyName, size: newValue!)
        }
    }
    
    /// 设置字体字间距、行间距、段落高度
    private func textStyle(wordSpace: Float, lineSpace: Float, lineHeight: Float) {
        let attributedString = NSMutableAttributedString.init(string: text!, attributes: [NSAttributedString.Key.kern: wordSpace])
        let style = NSMutableParagraphStyle()
        style.lineSpacing = CGFloat(lineSpace)
        style.lineHeightMultiple = CGFloat(lineHeight)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: .init(location: 0, length: text!.count))
        attributedText = attributedString
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultInit()
    }
    
    init() {
        super.init(frame: .zero)
        defaultInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置label默认值
    private func defaultInit() {
        textColor = .white
        font = UIFont(name: App.fontName, size: 14)
    }
    
    override var text: String? {
        didSet{
            textStyle(wordSpace: 1.2, lineSpace: 1.4, lineHeight: 1.0)
        }
    }
}
