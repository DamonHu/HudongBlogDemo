//
//  ColorKeyBoardView.swift
//  HudongBlog
//
//  Created by Damon on 2019/7/16.
//  Copyright © 2019 damon. All rights reserved.
//

import UIKit
import SnapKit

protocol ColorKeyBoardProtocol {
    ///点击了删除
    func keyBoardItemDidClickDelete(_ keyBoard:ColorKeyBoardView)
    
    /// 点击了内容按钮
    ///
    /// - Parameter text: 点击了键盘的内容
    func keyBoardItemDidClicked(_ keyBoard:ColorKeyBoardView,_ text:String)
}

//键盘类型
enum ColorBoardType {
    case number
    case hexNumber
}

class ColorKeyBoardView: UIView {
    var delegate:ColorKeyBoardProtocol?
    
    init(frame: CGRect,boardType:ColorBoardType) {
        super.init(frame: frame)
        self.p_createUI(boardType: boardType)
    }
    
    convenience init(boardType:ColorBoardType) {
        self.init(frame:CGRect.init(x: 0, y: 0, width: kScreenW, height: 220),boardType:boardType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func p_createUI(boardType:ColorBoardType) -> Void {
        self.backgroundColor = UIColorFromRGB(rgbValue: 0x7fa99b)
        var hexNumberList:[[String]]
        switch boardType {
        case .number:
            hexNumberList = [["1","2","3"],["4","5","6"],["7","8","9"],["","0","删除"]]
        case .hexNumber:
            hexNumberList = [["0","1","2","3","4"],["5","6","7","8","9"],["A","B","C","D","E"],["#","F","删除"]]
        }
        
        var stackViewList = [UIStackView]()
        for numberList in hexNumberList {
            //每个按钮的布局
            let stackView = UIStackView(frame: CGRect.zero)
            stackView.axis = NSLayoutConstraint.Axis.horizontal
            stackView.distribution = UIStackView.Distribution.fillEqually
            stackView.spacing = 1
            stackView.alignment = UIStackView.Alignment.fill
            for number in numberList {
                let button = UIButton(type: UIButton.ButtonType.custom)
                button.setTitle(number, for: UIControl.State.normal)
                button.backgroundColor = UIColorFromRGB(rgbValue: 0x394a51)
                button.addTarget(self, action: #selector(p_buttonDidClicked(sender:)), for: UIControl.Event.touchUpInside)
                stackView.addArrangedSubview(button)
            }
            stackViewList.append(stackView)
        }
        
        let stackView = UIStackView(arrangedSubviews: stackViewList)
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.spacing = 1
        stackView.alignment = UIStackView.Alignment.fill
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func p_buttonDidClicked(sender:UIButton) -> Void {
        if let keyboardDelegate = self.delegate {
            if let title = sender.title(for: UIControl.State.normal) {
                if title == "删除" {
                    keyboardDelegate.keyBoardItemDidClickDelete(self)
                } else if !title.isEmpty {
                    keyboardDelegate.keyBoardItemDidClicked(self,title)
                }
            }
        }
    }
}
