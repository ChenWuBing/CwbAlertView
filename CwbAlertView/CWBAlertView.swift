
import UIKit

enum CWBAlertViewStyle {
    case actionSheet
    case alert
}
///自定义可以用UIView.Show()显示出来效果的弹窗
class CWBAlertView: UIView {
    ///中间视图
    fileprivate var centerView = UIView()
    ///标题
    fileprivate var title:String?
    ///提示信息
    fileprivate var message:String?
    ///弹窗类型
    fileprivate var type:CWBAlertViewStyle!
    ///按钮个数
    fileprivate var actionArray = [CWBAlertAction]()
    ///是否可以点击消失
    fileprivate var canClickDismis = false
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    deinit {
        print("销毁自定制弹窗")
    }
    public convenience init(title: String?, message: String?, preferredStyle: CWBAlertViewStyle) {
        
        self.init()
        for sView in UIApplication.shared.delegate!.window!!.subviews {
            if sView.isKind(of: CWBAlertView.classForCoder())  {
                let alertView = sView as! CWBAlertView
                if alertView.message == message {
                    return
                }
            }
        }
        self.title = title
        self.message = message
        self.type = preferredStyle
        self.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.layoutIfNeeded()
    }
    open func addAction(_ action: CWBAlertAction) {
        actionArray.append(action)
    }
    open func show(){
        UIView.animate(withDuration: 0.3) {
//            self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }
        let centerViewWidth = self.type == CWBAlertViewStyle.alert ? self.frame.size.width * 0.75 : self.frame.size.width * 0.9
        var titleHeight:CGFloat = 0
        var messageHeight:CGFloat = 0
        var actionHeight:CGFloat = 0
        var y:CGFloat = 15
        self.centerView.layer.masksToBounds = true
        self.centerView.layer.cornerRadius = 8
        self.centerView.backgroundColor = UIColor.white
        
        if self.title != nil {
            titleHeight = self.calculateStringSize(str: self.title!, maW: centerViewWidth - 10, maH: 10000, fontSize: 15.0).height
            //标题
            let titleLabel = UILabel.init(frame: CGRect.init(x: 5, y: 15, width: centerViewWidth - 10, height: titleHeight))
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            titleLabel.text = self.title!
            self.centerView.addSubview(titleLabel)
        }
        if self.message != nil {
            //提示语
            messageHeight = self.calculateStringSize(str: self.message!, maW: centerViewWidth - 30, maH: 10000, fontSize: 14.0).height
            let messageLabel = UILabel.init(frame: CGRect.init(x: 15, y: titleHeight != 0 ? titleHeight + 20 : 15, width: centerViewWidth - 30, height: messageHeight))
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            messageLabel.text = self.message!
            messageLabel.font = UIFont.systemFont(ofSize: 14.0)
            messageLabel.textColor = RGBColor(r: 65, g: 65, b: 65, alpha: 1)
            self.centerView.addSubview(messageLabel)
        }
        
        if titleHeight != 0{
            y += titleHeight + 15
        }
        if messageHeight != 0{
            y += messageHeight + 15
        }
        
        if self.type == CWBAlertViewStyle.alert {
            if self.actionArray.count == 1 {
                if y != 15 {
                    let lineView1 = UIView.init(frame: CGRect.init(x: 0, y: y, width: centerViewWidth, height: 0.5))
                    lineView1.backgroundColor = RGBColor(r: 180, g: 180, b: 180, alpha: 1)
                    self.centerView.addSubview(lineView1)
                }
                
                let action = self.actionArray.first
                action?.frame = CGRect.init(x: 0, y: y, width: centerViewWidth, height: 40)
                actionHeight += 40.5
                self.centerView.addSubview(action!)
            }
            else if self.actionArray.count == 2 {
                if y != 15 {
                    let lineView1 = UIView.init(frame: CGRect.init(x: 0, y: y, width: centerViewWidth, height: 0.5))
                    lineView1.backgroundColor = RGBColor(r: 230, g: 230, b: 230, alpha: 1)
                    self.centerView.addSubview(lineView1)
                }
                let action1 = self.actionArray.first
                action1?.frame = CGRect.init(x: 0, y: y, width: centerViewWidth * 0.5 - 0.5, height: 40)
                self.centerView.addSubview(action1!)
                
                let lineView2 = UIView.init(frame: CGRect.init(x: centerViewWidth * 0.5, y: y, width: 0.5, height: 40))
                lineView2.backgroundColor = RGBColor(r: 230, g: 230, b: 230, alpha: 1)
                self.centerView.addSubview(lineView2)
                
                let action2 = self.actionArray.last
                action2?.frame = CGRect.init(x: centerViewWidth * 0.5, y: y, width: centerViewWidth * 0.5 + 0.5, height: 40)
                self.centerView.addSubview(action2!)
                actionHeight += 40.5
            }
            else {
                for (index,action) in self.actionArray.enumerated() {
                    let lineView = UIView.init(frame: CGRect.init(x: 0, y: y + CGFloat(index * 40), width: centerViewWidth, height: 0.5))
                    lineView.backgroundColor = RGBColor(r: 230, g: 230, b: 230, alpha: 1)
                    self.centerView.addSubview(lineView)
                    action.frame = CGRect.init(x: 0, y: y + CGFloat(index * 40) + 0.5, width: centerViewWidth, height: 40)
                    self.centerView.addSubview(action)
                    actionHeight += 40.5
                }
            }
        }
        else{
            if titleHeight == 0 && messageHeight == 0 {
                y = 0
            }
            for (index,action) in self.actionArray.enumerated() {
                if index != 0 || y != 0{
                    let lineView = UIView.init(frame: CGRect.init(x: 0, y: y + CGFloat(index * 40), width: centerViewWidth, height: 0.5))
                    lineView.backgroundColor = RGBColor(r: 180, g: 180, b: 180, alpha: 1)
                    self.centerView.addSubview(lineView)
                }
                action.frame = CGRect.init(x: 0, y: y + CGFloat(index * 40) + 0.5, width: centerViewWidth, height: 40)
                self.centerView.addSubview(action)
                actionHeight += 40.5
            }
        }
        
        let totalH = y + actionHeight
        self.canClickDismis = totalH > UIScreen.main.bounds.height
        if self.canClickDismis {
            //添加中心视图
            self.centerView.frame = CGRect.init(x: 0, y: 0, width: centerViewWidth, height: UIScreen.main.bounds.height - 40)
            self.centerView.center = self.center
            self.centerView.alpha = 0.5
            for view in self.centerView.subviews {
                view.removeFromSuperview()
            }
            let textView = UITextView.init(frame: self.centerView.bounds)
            textView.text = message
            textView.isScrollEnabled = true
            textView.isEditable = false
            self.centerView.addSubview(textView)
            self.addSubview(self.centerView)
            UIView.animate(withDuration: 0.3) {
                self.centerView.alpha = 1
            }
        }
        else {
            if self.type == CWBAlertViewStyle.alert {
                //添加中心视图
                self.centerView.frame = CGRect.init(x: 0, y: 0, width: centerViewWidth, height: totalH)
                self.centerView.center = self.center
                self.centerView.alpha = 0.5
                self.addSubview(self.centerView)
                UIView.animate(withDuration: 0.3) {
                    self.centerView.alpha = 1
                }
            }
            else{
                //添加底部视图
                self.centerView.frame = CGRect.init(x: 0, y: 0, width: centerViewWidth, height: totalH)
                self.centerView.center = CGPoint.init(x: self.centerX, y: self.frame.size.height + (totalH) * 0.5)
                self.addSubview(self.centerView)
                UIView.animate(withDuration: 0.3) {
                    self.centerView.center = CGPoint.init(x: self.centerX, y: self.frame.size.height - (totalH + 20) * 0.5)
                }
            }
        }
        CpiToolManager.addEffectView(self, nil,nil)
        UIApplication.shared.delegate?.window!!.addSubview(self)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canClickDismis && (touches.first?.view)! != self.centerView && !(touches.first?.view)!.isKind(of: CWBAlertAction.classForCoder()){
            if self.type == CWBAlertViewStyle.alert {
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 0.5
                }) { (_) in
                    self.removeFromSuperview()
                }
            }
            else{
                UIView.animate(withDuration: 0.3, animations: {
                    self.centerView.center = CGPoint.init(x: self.centerX, y: self.frame.size.height + self.centerView.frame.size.height * 0.5)
                }) { (_) in
                    self.removeFromSuperview()
                }
            }
        }
    }
    ///计算字符串大小
    fileprivate func calculateStringSize(str: String, maW: CGFloat, maH: CGFloat, fontSize: CGFloat) -> CGSize {
        
        let paragraohStyle = NSMutableParagraphStyle()
        paragraohStyle.lineSpacing = 1
        let dict = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize), NSAttributedStringKey.paragraphStyle: paragraohStyle]
        let nsStr = str as NSString
        return nsStr.boundingRect(with: CGSize.init(width: maW, height: maH), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: dict, context: nil).size
        
    }
}

enum CWBAlertActionStyle : Int {
    case `default`
    case cancel
}
class CWBAlertAction : UIView{
    //标题
    var title:String?
    //事件
    var handler:((CWBAlertAction) -> Swift.Void)?
    //文字颜色
    var textColor:UIColor?{
        didSet {
            self.layoutSubviews()
        }
    }
    //类型
    private var style:CWBAlertActionStyle?
    
    public convenience init(title: String?, style: CWBAlertActionStyle, handler: ((CWBAlertAction) -> Void)? = nil) {
        self.init()
        self.layoutIfNeeded()
        self.title = title
        self.handler = handler
        self.style = style
    }
    override func layoutSubviews() {
        if self.title != nil {
            let titleLabel = UILabel.init(frame: self.bounds)
            if self.style != nil {
                if self.style! == CWBAlertActionStyle.cancel {
                    titleLabel.textColor = RGBColor(r: 102, g: 102, b: 102, alpha: 1)
                }
                else{
                    titleLabel.textColor = textColor != nil ? textColor! : navgationBarColor
                }
            }
            else{
                titleLabel.textColor = textColor != nil ? textColor! : navgationBarColor
            }
            
            titleLabel.textAlignment = .center
            titleLabel.text = self.title!
            titleLabel.font = UIFont.systemFont(ofSize:  16.0)
            self.addSubview(titleLabel)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if handler != nil {
            handler!(self)
        }
        self.disMissCenterView()
    }
    
    fileprivate func disMissCenterView(){
        if let fView = self.superview?.superview as? CWBAlertView {
            if fView.type == CWBAlertViewStyle.alert {
                UIView.animate(withDuration: 0.3, animations: {
                    fView.alpha = 0.5
                }) { (_) in
                    fView.removeFromSuperview()
                }
            }
            else{
                UIView.animate(withDuration: 0.3, animations: {
                    fView.centerView.center = CGPoint.init(x: fView.centerX, y: fView.frame.size.height + fView.centerView.frame.size.height * 0.5)
                }) { (_) in
                    fView.removeFromSuperview()
                }
            }
        }
    }
}
