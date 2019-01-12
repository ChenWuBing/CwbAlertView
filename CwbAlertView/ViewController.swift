
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func action1(_ sender: UIButton) {
        let cwbAlertView = CWBAlertView.init(title: "温馨提示", message: "这是一个仿系统alert的弹框", preferredStyle: .alert)
        
        let cwbAction1 = CWBAlertAction.init(title: "按钮1", style: .default) { (_) in
            print("点击按钮1")
        }
        let cwbAction2 = CWBAlertAction.init(title: "按钮2", style: .default) { (_) in
            print("点击按钮2")
        }
        let cwbAction3 = CWBAlertAction.init(title: "按钮3", style: .cancel) { (_) in
            print("点击按钮3")
        }
        cwbAction2.textColor = UIColor.red
        cwbAlertView.addAction(cwbAction1)
        cwbAlertView.addAction(cwbAction2)
        cwbAlertView.addAction(cwbAction3)
        cwbAlertView.show()
    }
    
    @IBAction func action2(_ sender: Any) {
        let cwbAlertView = CWBAlertView.init(title: "温馨提示", message: "这是一个仿系统alert的弹框", preferredStyle: .actionSheet)
        
        let cwbAction1 = CWBAlertAction.init(title: "按钮1", style: .default) { (_) in
            print("点击按钮1")
        }
        let cwbAction2 = CWBAlertAction.init(title: "按钮2", style: .default) { (_) in
            print("点击按钮2")
        }
        cwbAction2.textColor = UIColor.red
        cwbAlertView.addAction(cwbAction1)
        cwbAlertView.addAction(cwbAction2)
        cwbAlertView.show()
    }
    
    @IBAction func action3(_ sender: Any) {
        let cwbAlertView = CWBAlertView.init(title: "温馨提示", message: "这是一个仿系统alert的弹框,这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框这是一个仿系统alert的弹框", preferredStyle: .alert)
        cwbAlertView.show()
    }
    
}

