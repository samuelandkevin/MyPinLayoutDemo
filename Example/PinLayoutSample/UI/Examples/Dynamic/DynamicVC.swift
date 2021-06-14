//
//  DynamicVC.swift
//  PinLayoutSample
//
//  Created by 黄坤鹏 on 2021/6/6.
//  Copyright © 2021 layoutbox. All rights reserved.
//

import Foundation

class DynamicVC: UIViewController {
    private var mainView: DynamicTBV {
        return self.view as! DynamicTBV
    }
    override func loadView() {
        view = DynamicTBV()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var arr = [EHMessageModel]()
        let imagesArr:[String] = [ "https://cdn.premom.com/test/community/post/569067049901000.jpg",
        "https://cdn.premom.com/test/community/post/5690fde5b901000.jpg",
        "https://cdn.premom.com/test/community/post/56b7d9715101000.jpg",
        "https://cdn.premom.com/test/community/post/56b7d999a501000.jpg",
        "https://cdn.premom.com/test/community/post/56b7d9a98901000.jpg",
        "https://cdn.premom.com/test/community/post/56b7d9b94501000.jpg",
        "https://cdn.premom.com/test/community/post/56b809653101000.jpg",
        "https://cdn.premom.com/test/community/post/56b80989e901000.jpg",
        "https://cdn.premom.com/test/community/post/56b80997c501000.jpg",
        "https://cdn.premom.com/test/community/post/56b809a4cd01000.jpg",
        "https://cdn.premom.com/test/community/post/56b809b19901000.jpg"]
        for i in 0...100 {
            let m1 = EHMessageModel()
            m1.msgTitle = "msg titlte" + "\(i)"
            m1.imageUrl = (i % 2) == 0 ? nil : imagesArr[Int(arc4random())%imagesArr.count]
            let n = arc4random()%6
            var msgContent = ""
            for _ in 0...n {
                msgContent += "long is long long long long long end? "
            }
            m1.msgContent = msgContent
            arr.append(m1)
        }
        
        mainView.configure(dataArray: arr)
    }
}
