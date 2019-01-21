//
//  SwiftHud.swift
//  SwiftHud
//
//  Created by season on 2018/10/9.
//  Copyright © 2018 season. All rights reserved.
//

import UIKit


/// 运行回调
public typealias RunClosure = () -> ()

// MARK:- Hud
/// 对外的Hud类
public class Hud {
    
    /// 非showOnNavigationBar的整体背景颜色
    public static var backgroundColor: UIColor = .clear {
        didSet {
            HudInternal.backgroundColor = backgroundColor
        }
    }
    
    /// 非showOnNavigationBar的mainView的背景颜色
    public static var mainColor: UIColor = .hudBg {
        didSet {
            HudInternal.mainColor = mainColor
        }
    }
    
    /// 非showOnNavigationBar的文字显示颜色和绘制的颜色
    public static var textColor: UIColor = .white {
        didSet {
            HudInternal.textColor = textColor
            HudGraph.drawColor = textColor
        }
    }
    
    /// 菊花转的颜色
    public static var indicatorColor: UIColor = .white {
        didSet {
            HudInternal.indicatorColor = indicatorColor
        }
    }
    
    /// 显示消息
    ///
    /// - Parameters:
    ///   - message: 信息
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - responseTap: 是否响应点击移除
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    public static func showMessage(message: String, autoClear: Bool = true, autoClearTime: TimeInterval = 3, responseTap: Bool = false, runable: RunClosure? = nil) -> UIWindow? {
        guard let _ = UIApplication.shared.keyWindow else { return nil }
        return HudInternal.showMessage(message: message, autoClear: autoClear, autoClearTime: autoClearTime, responseTap: responseTap, runable: runable)
    }
    
    /// 显示等待
    ///
    /// - Parameters:
    ///   - message: 信息
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - responseTap: 是否响应点击移除
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    public static func showWait(message: String? = nil, autoClear: Bool = true, autoClearTime: TimeInterval = 3, responseTap: Bool = false, runable: RunClosure? = nil) -> UIWindow? {
        guard let _ = UIApplication.shared.keyWindow else { return nil }
        return HudInternal.showWait(message:message, autoClear:autoClear, autoClearTime:autoClearTime, responseTap:responseTap, runable:runable)
    }
    
    /// 显示成功
    ///
    /// - Parameters:
    ///   - message: 信息
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - responseTap: 是否响应点击移除
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    public static func showSuccess(message: String, autoClear: Bool = true, autoClearTime: TimeInterval = 3, responseTap: Bool = false, runable: RunClosure? = nil) -> UIWindow? {
        guard let _ = UIApplication.shared.keyWindow else { return nil }
        return HudInternal.showNotice(type: .success, message: message, autoClear: autoClear, autoClearTime: autoClearTime, responseTap: responseTap, runable: runable)
    }
    
    /// 显示失败
    ///
    /// - Parameters:
    ///   - message: 信息
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - responseTap: 是否响应点击移除
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    public static func showFail(message: String, autoClear: Bool = true, autoClearTime: TimeInterval = 3, responseTap: Bool = false, runable: RunClosure? = nil) -> UIWindow? {
        guard let _ = UIApplication.shared.keyWindow else { return nil }
        return HudInternal.showNotice(type: .fail, message: message, autoClear: autoClear, autoClearTime: autoClearTime, responseTap: responseTap, runable: runable)
    }
    
    /// 显示信息
    ///
    /// - Parameters:
    ///   - message: 信息
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - responseTap: 是否响应点击移除
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    public static func showInfo(message: String, autoClear: Bool = true, autoClearTime: TimeInterval = 3, responseTap: Bool = false, runable: RunClosure? = nil) -> UIWindow? {
        guard let _ = UIApplication.shared.keyWindow else { return nil }
        return HudInternal.showNotice(type: .info, message: message, autoClear: autoClear, autoClearTime: autoClearTime, responseTap: responseTap, runable: runable)
    }
    
    /// 显示 可以通过枚举进而进行更多的自定义
    ///
    /// - Parameters:
    ///   - type: HudType的类型
    ///   - message: 信息
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - responseTap: 是否响应点击移除
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    public static func showNotice(type: HudType = .info, message: String, autoClear: Bool = true, autoClearTime: TimeInterval = 3, responseTap: Bool = false, runable: RunClosure? = nil) -> UIWindow? {
        guard let _ = UIApplication.shared.keyWindow else { return nil }
        return HudInternal.showNotice(type: type, message: message, autoClear: autoClear, autoClearTime: autoClearTime, responseTap: responseTap, runable: runable)
    }
    
    /// 显示Gif
    ///
    /// - Parameters:
    ///   - images: 图片数组
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - responseTap: 是否响应点击移除
    ///   - runable: 非自动移除后的操作响应
    ///   - timeMilliseconds: 动画时长,越短动画的节奏越快
    ///   - scale: 图片与mainView的比例,我这里用的黄金比例
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    public static func showAnimate(images: [UIImage], autoClear: Bool = true, autoClearTime: TimeInterval = 3, responseTap: Bool = false, timeMilliseconds: Int = 70, scale: CGFloat = 0.618, runable: RunClosure? = nil) -> UIWindow? {
        guard let _ = UIApplication.shared.keyWindow else { return nil }
        return HudInternal.showAnimate(images: images, autoClear: autoClear, autoClearTime: autoClearTime, responseTap: responseTap, timeMilliseconds: timeMilliseconds, scale: scale, runable: runable)
    }
    
    /// 通知栏的单行文字信息 注意没有做多行处理 如果多了会进入linebreak模式,另外横屏模式下暂时有问题
    ///
    /// - Parameters:
    ///   - message: 信息
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - textColor: 颜色
    ///   - fontSize: 字体大小
    ///   - backgroundColor: 背景颜色
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    public static func showOnNavigationBar(message: String, autoClear: Bool = true, autoClearTime: TimeInterval = 3, textColor: UIColor = .black, fontSize: CGFloat = 13, backgroundColor: UIColor? = nil , runable: RunClosure? = nil) -> UIWindow? {
        guard let _ = UIApplication.shared.keyWindow else { return nil }
        return HudInternal.showOnNavigationBar(message: message, autoClear: autoClear, autoClearTime: autoClearTime, textColor: textColor, fontSize: fontSize, backgroundColor: backgroundColor, runable: runable)
    }
    
    /// 清除Hud
    public static func clear() {
        HudInternal.clear()
    }
    
    /// 私有化构造方法
    private init() {}
}

// MARK: - Hud配置化的链式方法,链式方法一定要在show方法之前,否则无效
extension Hud {
    
    /// 设置Hud的背景颜色
    ///
    /// - Parameter backgroundColor: 背景颜色
    /// - Returns: Hud类
    @discardableResult
    public static func setBackgroundColor(_ backgroundColor: UIColor) -> Hud.Type {
        self.backgroundColor = backgroundColor
        return type(of: Hud())
    }
    
    /// 设置主颜色
    ///
    /// - Parameter mainColor: 主颜色
    /// - Returns: Hud类
    @discardableResult
    public static func setMainColor(_ mainColor: UIColor) -> Hud.Type {
        self.mainColor = mainColor
        return type(of: Hud())
    }
    
    /// 设置文字颜色
    ///
    /// - Parameter textColor: 文字颜色
    /// - Returns: Hud类
    @discardableResult
    public static func setTextColor(_ textColor: UIColor) -> Hud.Type {
        self.textColor = textColor
        return type(of: Hud())
    }
    
    /// 设置菊花转颜色
    ///
    /// - Parameter indicatorColor: 菊花转颜色
    /// - Returns: Hud类
    @discardableResult
    public static func setIndicatorColor(_ indicatorColor: UIColor) -> Hud.Type {
        self.indicatorColor = indicatorColor
        return type(of: Hud())
    }
    
    /// 设置为默认值
    ///
    /// - Returns: Hud类
    @discardableResult
    public static func setDeault() -> Hud.Type {
        backgroundColor = .clear
        mainColor = .hudBg
        textColor = .white
        indicatorColor = .white
        return type(of: Hud())
    }
}

// MARK:- Hud类型枚举
/// Hud类型枚举
///
/// - success: 成功
/// - fail: 失败
/// - info: 信息
public enum HudType {
    case success
    case fail
    case info
}

// MARK:- Hud类型枚举分类获取图片
extension HudType {
    func getImage() -> UIImage? {
        let image: UIImage?
        switch self {
        case .success:
            image = HudGraph.imageOfCheckmark
        case .fail:
            image = HudGraph.imageOfCross
        case .info:
            image = HudGraph.imageOfInfo
        }
        return image
    }
}

/// 标记是否是导航栏的通知样式
let kNaviBarHud = 10001

/// 点击Hud的消失的触发次数
let kHideHudTaps = 2

/// 倒角的数值
let kCornerRadius: CGFloat = 12

// MARK:-  Hud对内API
/// Hud对内API
private class HudInternal: NSObject {
    //MARK:- 属性设置
    static var windows = [UIWindow?]()
    
    static let rootView = UIApplication.shared.keyWindow?.subviews.first
    
    static var timer: DispatchSource!
    
    static var timerTimes = 0
    
    static var backgroundColor = UIColor.clear
    
    static var mainColor: UIColor = UIColor.hudBg
    
    static var textColor: UIColor = UIColor.white
    
    static var indicatorColor: UIColor = .white
    
    /// 清除Hud
    static func clear() {
        cancelPreviousPerformRequests(withTarget: self)
        if let _ = timer {
            timer.cancel()
            timer = nil
            timerTimes = 0
        }
        windows.removeAll(keepingCapacity: false)
    }
    
    /// 仅显示文字
    ///
    /// - Parameters:
    ///   - message: 信息
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - responseTap: 是否响应点击移除
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    static func showMessage(message: String, autoClear: Bool = true, autoClearTime: TimeInterval = 3, responseTap: Bool = false, runable: RunClosure? = nil) -> UIWindow? {
        
        guard let rv = rootView else { return nil }
        
        let window = UIWindow()
        window.backgroundColor = backgroundColor
        window.rootViewController = UIApplication.topViewController()
        let mainView = UIView()
        mainView.layer.cornerRadius = kCornerRadius
        mainView.backgroundColor = mainColor
        
        if responseTap {
            let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapHide(_:)))
            tapGesture.numberOfTapsRequired = kHideHudTaps
            window.addGestureRecognizer(tapGesture)
        }
        
        let label = UILabel()
        label.text = message
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = textColor
        let size = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 82, height: CGFloat.greatestFiniteMagnitude))
        label.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        mainView.addSubview(label)
        
        let superFrame = CGRect(x: 0, y: 0, width: label.frame.width + 50 , height: label.frame.height + 30)
        window.frame = rv.bounds
        mainView.frame = superFrame
        label.center = mainView.center
        mainView.center = rv.center
        
        #if swift(>=4.2)
        window.windowLevel = UIWindow.Level.alert
        #else
        window.windowLevel = UIWindowLevelAlert
        #endif
        
        window.isHidden = false
        window.addSubview(mainView)
        windows.append(window)
        
        if autoClear {
            let selector = #selector(hideHud(_:))
            perform(selector, with: window, afterDelay: autoClearTime)
            
            //  延时操作
            DispatchQueue.main.asyncAfter(deadline: .now() + autoClearTime) {
                runable?()
            }
        }
        
        return window
    }
    
    /// 显示HudType类型的通知
    ///
    /// - Parameters:
    ///   - type: HudType
    ///   - message: 信息
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - responseTap: 是否响应点击移除
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    static func showNotice(type: HudType = .info, message: String, autoClear: Bool = true, autoClearTime: TimeInterval = 3, responseTap: Bool = false, runable: RunClosure? = nil) -> UIWindow? {
        
        guard let rv = rootView else { return nil }
        
        var frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        let window = UIWindow()
        window.backgroundColor = backgroundColor
        window.rootViewController = UIApplication.topViewController()
        let mainView = UIView()
        mainView.layer.cornerRadius = kCornerRadius
        mainView.backgroundColor = mainColor
        
        if responseTap {
            let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapHide(_:)))
            tapGesture.numberOfTapsRequired = kHideHudTaps
            window.addGestureRecognizer(tapGesture)
        }
        
        
        let image = type.getImage()
        let checkmarkView = UIImageView(image: image)
        checkmarkView.frame = CGRect(x: 27, y: 15, width: 36, height: 36)
        mainView.addSubview(checkmarkView)
        
        let label = UILabel(frame: CGRect(x: 0, y: 60, width: 90, height: 16))
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = textColor
        label.text = message
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 0
        
        var size = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 82, height: CGFloat.greatestFiniteMagnitude))
        
        //  如果字符串的长度大于原有预计的90 需要重新进行计算
        if size.width > 90 {
            label.frame.origin.x = 5
            label.frame.size.width = size.width
            if Int(size.height) % 16 != 0 {
                let ratio = Int(size.height) / 16 + 2
                size.height = CGFloat(ratio) * 16
            }
            label.frame.size.height = size.height
            frame.size.width = size.width + 10
            frame.size.height = size.height + label.frame.minY + 5
            checkmarkView.frame.origin.x = (frame.width - checkmarkView.frame.width) / 2
            
        }
        
        mainView.addSubview(label)
        
        window.frame = rv.bounds
        mainView.frame = frame
        mainView.center = rv.center
        
        #if swift(>=4.2)
        window.windowLevel = UIWindow.Level.alert
        #else
        window.windowLevel = UIWindowLevelAlert
        #endif
        window.center = rv.center
        window.isHidden = false
        window.addSubview(mainView)
        windows.append(window)
        
        mainView.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            mainView.alpha = 1
        })
        
        if autoClear {
            let selector = #selector(hideHud(_:))
            perform(selector, with: window, afterDelay: autoClearTime)
            //  延时操作
            DispatchQueue.main.asyncAfter(deadline: .now() + autoClearTime) {
                runable?()
            }
        }
        return window
    }
    
    /// 展示菊花转并可以带多行文字
    ///
    /// - Parameters:
    ///   - message: 信息
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - responseTap: 是否响应点击移除
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    static func showWait(message: String? = nil, autoClear: Bool = true, autoClearTime: TimeInterval = 3, responseTap: Bool = false, runable: RunClosure? = nil) -> UIWindow? {
        
        guard let rv = rootView else { return nil }
        
        var frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        let window = UIWindow()
        window.backgroundColor = backgroundColor
        window.rootViewController = UIViewController()
        let mainView = UIView()
        mainView.layer.cornerRadius = kCornerRadius
        mainView.backgroundColor = mainColor
        
        if responseTap {
            let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapHide(_:)))
            tapGesture.numberOfTapsRequired = kHideHudTaps
            window.addGestureRecognizer(tapGesture)
        }
        
        
        #if swift(>=4.2)
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        #else
        let ai = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        #endif
        ai.color = indicatorColor
        if let msg = message {
            ai.frame = CGRect(x: 27, y: 15, width: 36, height: 36)
            
            let label = UILabel(frame: CGRect(x: 0, y: 60, width: 90, height: 16))
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = textColor
            label.text = msg
            label.lineBreakMode = .byTruncatingMiddle
            label.textAlignment = .center
            label.numberOfLines = 0
            
            var size = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 82, height: CGFloat.greatestFiniteMagnitude))
            
            //  如果字符串的长度大于原有预计的90 需要重新进行计算
            if size.width > 90 {
                label.frame.origin.x = 5
                label.frame.size.width = size.width
                if Int(size.height) % 16 != 0 {
                    let ratio = Int(size.height) / 16 + 2
                    size.height = CGFloat(ratio) * 16
                }
                label.frame.size.height = size.height
                frame.size.width = size.width + 10
                frame.size.height = size.height + label.frame.minY + 5
                ai.frame.origin.x = (frame.width - ai.frame.width) / 2
            }
            
            mainView.addSubview(label)
        }else {
            ai.frame = CGRect(x: 27, y: 27, width: 36, height: 36)
        }
        
        
        ai.startAnimating()
        mainView.addSubview(ai)
        
        window.frame = rv.bounds
        mainView.frame = frame
        mainView.center = rv.center
        
        #if swift(>=4.2)
        window.windowLevel = UIWindow.Level.alert
        #else
        window.windowLevel = UIWindowLevelAlert
        #endif
        
        window.center = rv.center
        window.isHidden = false
        window.addSubview(mainView)
        windows.append(window)
        
        mainView.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            mainView.alpha = 1
        })
        
        if autoClear {
            let selector = #selector(hideHud(_:))
            perform(selector, with: window, afterDelay: autoClearTime)
            //  延时操作
            DispatchQueue.main.asyncAfter(deadline: .now() + autoClearTime) {
                runable?()
            }
        }
        return window
    }
    
    /// 播放GIF的wait
    ///
    /// - Parameters:
    ///   - images: 图片数组
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - responseTap: 是否响应点击移除
    ///   - runable: 非自动移除后的操作响应
    ///   - timeMilliseconds: 动画时长,越短动画的节奏越快
    ///   - scale: 图片与mainView的比例,我这里用的黄金比例
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    static func showAnimate(images: [UIImage], autoClear: Bool = true, autoClearTime: TimeInterval = 3, responseTap: Bool = false, timeMilliseconds: Int = 70, scale: CGFloat = 0.618, runable: RunClosure? = nil) -> UIWindow? {
        guard let rv = rootView, images.count > 0 else { return nil }
        let frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        let window = UIWindow()
        window.backgroundColor = backgroundColor
        window.rootViewController = UIViewController()
        let mainView = UIView()
        mainView.layer.cornerRadius = kCornerRadius
        mainView.backgroundColor = mainColor
        
        if responseTap {
            let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapHide(_:)))
            tapGesture.numberOfTapsRequired = kHideHudTaps
            window.addGestureRecognizer(tapGesture)
        }
        
        let imgViewFrame = CGRect(x: frame.size.width * (1 - scale) * 0.5, y: frame.size.height * (1 - scale) * 0.5, width: frame.size.width * scale, height: frame.size.height * scale)
        
        if images.count > timerTimes {
            let imageView = UIImageView(frame: imgViewFrame)
            imageView.image = images.first
            imageView.contentMode = .scaleAspectFit
            mainView.addSubview(imageView)
            timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)), queue: DispatchQueue.main) as? DispatchSource
            timer.schedule(deadline: .now(), repeating: DispatchTimeInterval.milliseconds(timeMilliseconds))
            timer.setEventHandler(handler: {
                let image = images[timerTimes % images.count]
                imageView.image = image
                timerTimes += 1
            })
            timer.resume()
        }
        
        window.frame = rv.bounds
        mainView.frame = frame
        mainView.center = rv.center
        
        #if swift(>=4.2)
        window.windowLevel = UIWindow.Level.alert
        #else
        window.windowLevel = UIWindowLevelAlert
        #endif
        window.isHidden = false
        window.addSubview(mainView)
        windows.append(window)
        
        mainView.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            mainView.alpha = 1
        })
        
        if autoClear {
            
            let selector = #selector(hideHud(_:))
            perform(selector, with: window, afterDelay: autoClearTime)
            
            //  延时操作
            DispatchQueue.main.asyncAfter(deadline: .now() + autoClearTime) {
                self.clear()
                runable?()
            }
        }
        
        return window
    }
    
    /// 通知栏的单行文字信息 注意没有做多行处理 如果多了会进入linebreak模式,另外横屏模式下暂时有问题
    ///
    /// - Parameters:
    ///   - message: 信息
    ///   - autoClear: 是否自动移除
    ///   - autoClearTime: 移除的延迟时间
    ///   - textColor: 颜色
    ///   - fontSize: 字体大小
    ///   - backgroundColor: 背景颜色
    ///   - runable: 非自动移除后的操作响应
    /// - Returns: 返回window
    @discardableResult
    static func showOnNavigationBar(message: String, autoClear: Bool = true, autoClearTime: TimeInterval = 3, textColor: UIColor = .black, fontSize: CGFloat = 13, backgroundColor: UIColor? = nil , runable: RunClosure? = nil) -> UIWindow? {
        
        guard UIDevice.current.orientation == .portrait else { return nil }
        
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let frame = CGRect(x: 0, y: 0, width: statusBarFrame.width, height: (statusBarFrame.height + 44))
        let window = UIWindow()
        window.rootViewController = UIApplication.topViewController()
        window.backgroundColor = UIColor.clear
        let toolbar = UIToolbar()
        toolbar.barTintColor = backgroundColor
        let label = UILabel(frame: CGRect(x: 0, y: statusBarFrame.height, width: frame.width, height: (frame.height - 44)))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.text = message
        label.lineBreakMode = .byTruncatingMiddle
        toolbar.addSubview(label)
        
        window.frame = frame
        toolbar.frame = frame

        #if swift(>=4.2)
        window.windowLevel = UIWindow.Level.statusBar
        #else
        window.windowLevel = UIWindowLevelStatusBar
        #endif
        window.isHidden = false
        window.addSubview(toolbar)
        windows.append(window)
        
        var origPoint = toolbar.frame.origin
        origPoint.y = -(toolbar.frame.size.height)
        let destPoint = toolbar.frame.origin
        toolbar.tag = kNaviBarHud
        
        toolbar.frame = CGRect(origin: origPoint, size: toolbar.frame.size)
        UIView.animate(withDuration: 0.3, animations: {
            toolbar.frame = CGRect(origin: destPoint, size: toolbar.frame.size)
        }, completion: { _ in
            if autoClear {
                DispatchQueue.global().asyncAfter(deadline: .now() + autoClearTime, execute: {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.3, animations: {
                            /// Vanishing animation
                            toolbar.frame = CGRect(origin: origPoint, size: toolbar.frame.size)
                        }, completion: { (_) in
                            let selector = #selector(hideHud(_:))
                            self.perform(selector, with: window, afterDelay: TimeInterval(autoClearTime))
                        })
                    }
                    runable?()
                })
            }
        })
        return window
    }
    
    /// 点击手势隐藏
    ///
    /// - Parameter gesture: 手势
    @objc
    static func tapHide(_ gesture: UITapGestureRecognizer) {
        clear()
    }
    
    /// 隐藏Hud
    ///
    /// - Parameter sender: 传递值
    @objc
    static func hideHud(_ sender: AnyObject) {
        guard let window = sender as? UIWindow, let view = window.subviews.first else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            if view.tag == kNaviBarHud {
                view.frame = CGRect(x: 0, y: -view.frame.height, width: view.frame.width, height: view.frame.height)
            }
            view.alpha = 0
            view.removeFromSuperview()
        }) { (_) in
            
            if let index = windows.index(where: { (item) -> Bool in
                return item == window
            }) {
                windows.remove(at: index)
            }
        }
    }
}


// MARK:-  Hud图形绘制
private class HudGraph {
    
    /// 存储图形用的结构体
    struct Cache {
        static var imageOfCheckmark: UIImage?
        static var imageOfCross: UIImage?
        static var imageOfInfo: UIImage?
    }
    
    static var drawColor: UIColor = .white
    
    /// 绘制图片
    ///
    /// - Parameter type: 类型
    static func draw(_ type: HudType) {
        let checkmarkShapePath = UIBezierPath()
        
        // draw circle
        checkmarkShapePath.move(to: CGPoint(x: 36, y: 18))
        checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        checkmarkShapePath.close()
        
        switch type {
        // draw checkmark
        case .success:
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.addLine(to: CGPoint(x: 16, y: 24))
            checkmarkShapePath.addLine(to: CGPoint(x: 27, y: 13))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.close()
        // draw X
        case .fail:
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 26))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 26))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 10))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.close()
        // draw !
        case .info:
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.addLine(to: CGPoint(x: 18, y: 22))
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.close()
            
            drawColor.setStroke()
            checkmarkShapePath.stroke()
            
            let checkmarkShapePath = UIBezierPath()
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 27))
            checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 27), radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
            checkmarkShapePath.close()
            
            drawColor.setFill()
            checkmarkShapePath.fill()
        }
        
        drawColor.setStroke()
        checkmarkShapePath.stroke()
    }
    
    /// checkMark
    static var imageOfCheckmark: UIImage? {
        guard let imageOfCheckmark = Cache.imageOfCheckmark else {
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
            draw(.success)
            Cache.imageOfCheckmark = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return Cache.imageOfCheckmark
        }
        
        return imageOfCheckmark
    }
    
    /// X
    static var imageOfCross: UIImage? {
        guard let imageOfCross = Cache.imageOfCross else {
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
            draw(.fail)
            Cache.imageOfCross = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return Cache.imageOfCross
        }
        
        return imageOfCross
    }
    
    /// info
    static var imageOfInfo: UIImage? {
        guard let imageOfInfo = Cache.imageOfInfo else {
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
            draw(.info)
            Cache.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return Cache.imageOfInfo
        }
        
        return imageOfInfo
    }
}

// MARK: - UIWindow的隐藏分类
public extension UIWindow{
    public func hide(){
        HudInternal.hideHud(self)
    }
}

// MARK: - 获取顶层控制器
extension UIApplication {
    class func topViewController(_ rootVC: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = rootVC as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = rootVC as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = rootVC?.presentedViewController {
            return topViewController(presented)
        }
        
        return rootVC
    }
}

// MARK: - Hud的背景颜色
extension UIColor {
    class var hudBg: UIColor  {
        return UIColor(red:0, green:0, blue:0, alpha: 0.8)
    }
}
