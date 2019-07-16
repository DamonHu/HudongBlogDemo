//
//  ViewController.swift
//  KeyboardTest
//
//  Created by Damon on 2019/7/16.
//  Copyright © 2019 Damon. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ColorKeyBoardProtocol {

    lazy var numberTextField: UITextField = {
        let tTextField = UITextField(frame: CGRect.zero)
        tTextField.layer.masksToBounds = true
        tTextField.layer.borderColor = UIColor.black.cgColor
        tTextField.layer.borderWidth = 1.0
        let colorKeyBoardView = ColorKeyBoardView(boardType: ColorBoardType.number)
        colorKeyBoardView.delegate = self
        colorKeyBoardView.tag = 1
        tTextField.inputView = colorKeyBoardView
        return tTextField
    }()
    
    lazy var hexNumberTextField: UITextField = {
        let tTextField = UITextField(frame: CGRect.zero)
        tTextField.layer.masksToBounds = true
        tTextField.layer.borderColor = UIColor.black.cgColor
        tTextField.layer.borderWidth = 1.0
        let colorKeyBoardView = ColorKeyBoardView(boardType: ColorBoardType.hexNumber)
        colorKeyBoardView.delegate = self
        colorKeyBoardView.tag = 2
        tTextField.inputView = colorKeyBoardView
        return tTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.p_createUI()
    }
    
    func p_createUI() {
        self.view.addSubview(self.numberTextField)
        self.numberTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(self.hexNumberTextField)
        self.hexNumberTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.numberTextField.snp_bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
    }
    
    //MARK: - ColorKeyBoardProtocol
    func keyBoardItemDidClickDelete(_ keyBoard: ColorKeyBoardView) {
        let textFieldList = [self.numberTextField,self.hexNumberTextField]
        if let fieldText = textFieldList[keyBoard.tag - 1].text {
            if !fieldText.isEmpty {
                let index = fieldText.index(before: fieldText.endIndex)
                textFieldList[keyBoard.tag - 1].text = String(fieldText.prefix(upTo: index))
            } else {
                print("没有输入字符串，不去删除")
            }
        } else {
            print("没有输入字符串，不去删除")
        }
    }
    
    func keyBoardItemDidClicked(_ keyBoard: ColorKeyBoardView, _ text: String) {
        let textFieldList = [self.numberTextField,self.hexNumberTextField]
        if let fieldText = textFieldList[keyBoard.tag - 1].text {
            textFieldList[keyBoard.tag - 1].text = fieldText + text
        } else {
            textFieldList[keyBoard.tag - 1].text = text
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

