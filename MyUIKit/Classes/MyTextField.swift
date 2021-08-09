
import Foundation

/// 输入框类型
enum TFType {
    case mobile, code, idCard, email, text, password
}

class MyTextField: UITextField, UITextFieldDelegate {
    
    /// 左侧view距离左边的距离
    var leftViewLeading: CGFloat = 15
    
    /// 输入框文字距离leftView的距离
    var textLeading: CGFloat = 15
    
    /// 右侧view距离右边的距离
    var rightViewTrailing: CGFloat = 15
    
    /// 输入文字的最大字数 0不限制
    var maxLenght: Int = 0
    
    /// 是否限制输入空格
    var isLimitSpace: Bool = true
    
    /// 是否禁止粘贴
    var isLimitPaste: Bool = true
    
    /// 字体大小
    var fontSize: CGFloat? {
        willSet {
            font = UIFont.init(name: font!.familyName, size: newValue!)
        }
    }
    
    /// 输入框输入类型
    var type: TFType? {
        willSet {
            switch newValue {
            case .mobile:
                keyboardType = .numberPad
                clearButtonMode = .whileEditing
                maxLenght = 11
                break
            case .code:
                keyboardType = .numberPad
                maxLenght = 6
                isLimitPaste = false
                break
            case .idCard:
                keyboardType = .default
                clearButtonMode = .whileEditing
                maxLenght = 17
                break
            case .email:
                keyboardType = .emailAddress
                clearButtonMode = .whileEditing
                break
            case .text:
                keyboardType = .default
                clearButtonMode = .whileEditing
                isLimitSpace = false
                isLimitPaste = false
                break
            case .password:
                keyboardType = .default
                isSecureTextEntry = true
                let btn = UIButton(type: .custom)
                btn.setImage(UIImage(named: "eyes_close"), for: .normal)
                btn.setImage(UIImage(named: "eyes_open"), for: .selected)
                btn.adjustsImageWhenHighlighted = false
                btn.addTarget(self, action: #selector(showOrHiddenPassword(_:)), for: .touchUpInside)
                rightView = btn
                rightViewMode = .always
                break
            default:
                keyboardType = .default
                clearButtonMode = .whileEditing
                isLimitSpace = false
                isLimitPaste = false
                break
                
            }
        }
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
    
    private func defaultInit() {
        font = UIFont.init(name: App.fontName, size: 14)
        defaultTextAttributes = [NSAttributedString.Key.kern: 1.2]
        textColor = .white
        delegate = self
    }
    
    override var placeholder: String? {
        didSet {
            attributedPlaceholder = NSMutableAttributedString.init(string: placeholder!, attributes: [NSAttributedString.Key.font: UIFont.init(name: App.fontName, size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.9), NSAttributedString.Key.kern: 1.2])
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = bounds.insetBy(dx: leftViewLeading, dy: 0)
        return super.leftViewRect(forBounds: rect)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = bounds.insetBy(dx: rightViewTrailing, dy: 0)
        return super.rightViewRect(forBounds: rect)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = bounds.insetBy(dx: textLeading, dy: 0)
        return super.textRect(forBounds: rect)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = bounds.insetBy(dx: textLeading, dy: 0)
        return super.editingRect(forBounds: rect)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existedLength = textField.text?.count
        let selectedLength = range.length
        let replaceLength = string.count
        let pointLength = existedLength! - selectedLength + replaceLength
        /// 限制输入最大字符
        if pointLength > maxLenght && maxLenght != 0 {
            return false
        }
        /// 是否允许输入空格
        let tempStr = string.components(separatedBy: NSCharacterSet.whitespacesAndNewlines).joined(separator: "")
        if (tempStr != string) && isLimitSpace {
            return false
        }
        
        /// 手机号和验证码只允许输入（复制）数字
        if type == .mobile || type == .code {
            let set = CharacterSet.init(charactersIn: "0123456789").inverted
            let filteredStr = string.components(separatedBy: set).joined(separator: "")
            if filteredStr == string {
                return true
            }
            return false
        }
        
        return true
    }
    
    /// 是否禁止粘贴
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if (action == #selector(paste(_:))){
            return !isLimitPaste
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    @objc private func showOrHiddenPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isSecureTextEntry = !sender.isSelected
    }
}
