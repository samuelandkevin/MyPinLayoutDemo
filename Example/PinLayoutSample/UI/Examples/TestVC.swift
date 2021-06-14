//
//  TestVC.swift
//  PinLayoutSample
//
//  Created by 黄坤鹏 on 2021/6/13.
//  Copyright © 2021 layoutbox. All rights reserved.
//

import Foundation
import PinLayout

class TestVC:UIViewController{
    fileprivate let lb1 = UILabel()
    fileprivate let lb2 = UILabel()
    fileprivate let lb3 = UILabel()
    fileprivate let aView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        lb1.font = UIFont.systemFont(ofSize: 14)
        lb1.numberOfLines = 0
        view.addSubview(lb1)
        lb2.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(lb2)
        lb3.font = UIFont.systemFont(ofSize: 14)
        lb3.numberOfLines = 0
        view.addSubview(lb3)
        aView.backgroundColor = .blue
        view.addSubview(aView)
        
        lb1.text = "姓名姓名姓名姓名姓名姓名姓名姓名姓名姓名姓名姓名姓名姓名姓名姓名"
        lb2.text = "性别"
        lb3.text = "兴趣爱好兴趣爱好兴趣爱好兴趣爱好"
        
    }
    
    func layoutUI(){
        lb1.pin.left(10).top(view.pin.safeArea.top+10).sizeToFit(.widthFlexible).maxWidth(40%)
        lb2.pin.after(of: lb1,aligned: .top).sizeToFit(.widthFlexible).marginLeft(20)
        lb3.pin.sizeToFit(.widthFlexible).top(to: lb2.edge.top).right(to: view.edge.right).marginRight(10).after(of: lb2).marginLeft(20).maxWidth(50%)
        aView.pin.below(of: visible([lb1,lb2,lb3])).marginTop(10).left(10).right(10).height(100)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }
}
