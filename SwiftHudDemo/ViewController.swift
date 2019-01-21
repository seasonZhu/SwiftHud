//
//  ViewController.swift
//  SwiftHud
//
//  Created by season on 2018/10/9.
//  Copyright © 2018 season. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- 属性设置
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 44, width: view.bounds.width, height: view.bounds.height - 44), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
    }()
    
    private var dataSource = ["仅显示文字", "仅等待", "等待且有文字", "成功", "失败", "信息", "动画", "导航栏通知"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0:
            Hud.showMessage(message: "测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试", autoClear: true, autoClearTime: 3, responseTap: true) {
                print("showMessage", indexPath)
            }
        case 1:
            Hud.showWait() {
                print("showWait", indexPath)
            }
        case 2:
            Hud.setBackgroundColor(UIColor.red.withAlphaComponent(0.5))
                .setMainColor(UIColor.gray)
                .setTextColor(UIColor.yellow)
                .setIndicatorColor(UIColor.green)
                .showWait(message: "测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试", autoClear: true, autoClearTime: 3, responseTap: true) {
                print("showWait Message", indexPath)
            }
        case 3:
            Hud.setDeault().showSuccess(message: "成功啦") {
                print("showSuccess", indexPath)
            }
        case 4:
            Hud.setDeault().showFail(message: "失败失败啦") {
                print("showFail", indexPath)
            }
        case 5:
            Hud.setDeault().showInfo(message: "信息信息信息信息信息信息信息信息信息") {
                print("showInfo", indexPath)
            }
        case 6:
            /*
            var loadingImages = [UIImage]()
            for index in 0...16 {
                let loadImageName = String(format: "new_brand_progress%02d", index)
                if let loadImage = UIImage(named: loadImageName) {
                    loadingImages.append(loadImage)
                }
            }
            */
            
            DispatchQueue.global().async {
                let array = 0...16
                let imgs = array.reduce([]) { (result, x) -> [UIImage] in
                    let loadImageName = String(format: "new_brand_progress%02d", x)
                    let loadImage = UIImage(named: loadImageName)!
                    return result + [loadImage]
                }
                DispatchQueue.main.async {
                    Hud.showAnimate(images: imgs, autoClear: true, responseTap: true) {
                        print("showGif", indexPath)
                    }
                }
            }
            /// 模拟 4s后 加载完成
            /*
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                Hud.clear()
            }
            */
        case 7:
            Hud.showOnNavigationBar(message: "这个一条通知栏信息😁", autoClear: true, autoClearTime: 3) {
                print("showOnNavigationBar", indexPath)
            }
        default:
            break
        }
    }
}

