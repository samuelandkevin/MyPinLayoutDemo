//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import PinLayout

class WrapContentView: UIView {
    private let scrollView = UIScrollView()

    private let topContainer = UIView()
    private let topLogo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    private let topLabel = UILabel()

    private let separatorView1 = UIView()

    private let middleContainer = UIView()
    private let middleLabel = UILabel()
    private let button1 = UIButton(type: .custom)
    private let button2 = UIButton(type: .custom)
    private let button3 = UIButton(type: .custom)

    private let separatorView2 = UIView()

    private let bottomContainer = UIView()
    private let bottomLogo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    private let bottomLabel = UILabel()
    
    
    private let viewContainer1 = UIView()
    private let imgvLogo1 = UIImageView(image: UIImage(named: "PinLayout-logo"))
    private let lb1_1 = UILabel()
    private let lb1_2 = UILabel()
    private let lb1_3 = UILabel()
    private let btn_1 = UIButton(type: .custom)
    private let tf1 = UITextField()
    private let sw1 = UISwitch()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        addSubview(scrollView)

        topContainer.backgroundColor = .lightColor
        scrollView.addSubview(topContainer)

        //
        // Top section
        //
        topLogo.contentMode = .scaleAspectFit
        topContainer.addSubview(topLogo)

        configureLabel(topLabel, text: "This view use 'pin.wrapContent()' to wrap its subviews (logo and label). This view horizontally center at the top.")
        topContainer.addSubview(topLabel)

        // Separator 1
        separatorView1.pin.height(1)
        separatorView1.backgroundColor = .pinLayoutColor
        scrollView.addSubview(separatorView1)

        //
        // Middle section
        //
        middleContainer.backgroundColor = .lightColor
        scrollView.addSubview(middleContainer)

        configureLabel(middleLabel, text: "This view use 'pin.wrapContent()' to wrap its subviews (1 label and 3 buttons). This view is horizontally centered.")
        middleContainer.addSubview(middleLabel)

        button1.setTitle("Button 1", for: .normal)
        button1.setTitleColor(.black, for: .normal)
        button1.sizeToFit()
        middleContainer.addSubview(button1)

        button2.setTitle("Button 2", for: .normal)
        button2.setTitleColor(.black, for: .normal)
        button2.sizeToFit()
        middleContainer.addSubview(button2)

        button3.setTitle("Button 3", for: .normal)
        button3.setTitleColor(.black, for: .normal)
        button3.sizeToFit()
        middleContainer.addSubview(button3)

        // Separator 2
        separatorView2.pin.height(1)
        separatorView2.backgroundColor = .pinLayoutColor
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } 
        scrollView.addSubview(separatorView2)

        //
        // Bottom section
        //
        bottomContainer.backgroundColor = .lightColor
        scrollView.addSubview(bottomContainer)

        bottomLogo.contentMode = .scaleAspectFit
        bottomContainer.addSubview(bottomLogo)

        configureLabel(bottomLabel, text: "This view use 'pin.wrapContent()' to wrap its subviews (logo and label). This view is horizontally centered. This view is vertically center in the region between the separator and the bottom of the screen using '.align(.center)'")
        bottomContainer.addSubview(bottomLabel)
        
        
        viewContainer1.backgroundColor = .lightColor
        scrollView.addSubview(viewContainer1)
        
        configureLabel(lb1_1, text: "My Name is Peter")
        lb1_1.textAlignment = .left
        viewContainer1.addSubview(lb1_1)
        
        configureLabel(lb1_2, text: "My Job is Doctor")
        lb1_2.textAlignment = .left
        viewContainer1.addSubview(lb1_2)
        
        viewContainer1.addSubview(imgvLogo1)
        configureLabel(lb1_3, text: "My Description is long,My Description is long,My Description is long,My Description is long,My Description is long,My Description is long.")
        lb1_3.textAlignment = .left
        viewContainer1.addSubview(lb1_3)
        
        btn_1.backgroundColor = .green
        btn_1.setTitle("Confirm", for: .normal)
        btn_1.setTitleColor(.black, for: .normal)
        btn_1.sizeToFit()
        viewContainer1.addSubview(btn_1)
        
        tf1.layer.borderWidth = 1
        tf1.layer.borderColor = UIColor.red.cgColor
        tf1.layer.cornerRadius = 6
        tf1.layer.masksToBounds = true
        tf1.placeholder = "Please inupt your phone"
        viewContainer1.addSubview(tf1)
        
        sw1.tintColor = .lightGray
        sw1.addTarget(self, action: #selector(didChangeSwitch), for: .valueChanged)
        viewContainer1.addSubview(sw1)
        
    }
    
    @objc func didChangeSwitch(){
        bottomContainer.isHidden = !sw1.isOn
        
        UIView.animate(withDuration: 0.2) {
            self._layoutUI()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _layoutUI()
    }
    
    private func _layoutUI(){
        let padding: CGFloat = 10

        scrollView.pin.all()
       
        // Top section
        topLogo.pin.width(100).aspectRatio()
        topLabel.pin.below(of: topLogo, aligned: .center).width(260).sizeToFit(.width).marginTop(padding)
        topContainer.pin.wrapContent(padding: 4).top(pin.safeArea.top + padding).hCenter()
        

        // Separator1
        separatorView1.pin.below(of: topContainer, aligned: .center).width(80%).marginTop(padding)

        middleLabel.pin.width(260).sizeToFit(.width)
        button2.pin.below(of: middleLabel, aligned: .center).marginTop(padding)
        button1.pin.before(of: button2, aligned: .center).marginRight(padding)
        button3.pin.after(of: button2, aligned: .center).marginLeft(padding)
        middleContainer.pin.wrapContent(padding: 4).below(of: separatorView1).hCenter().marginTop(padding)

        // Separator2
        separatorView2.pin.below(of: middleContainer, aligned: .center).width(80%).marginTop(padding)

        // Bottom section
        bottomLogo.pin.width(50).aspectRatio()
        bottomLabel.pin.after(of: bottomLogo, aligned: .top).width(200).marginLeft(10).sizeToFit(.width)
        bottomContainer.pin.wrapContent(padding: 30).below(of: separatorView2).hCenter().marginTop(padding)
       
        viewContainer1.pin.left(50).right(50)
        lb1_1.pin.left().top().maxWidth(30%).sizeToFit(.width)
        lb1_2.pin.after(of: lb1_1, aligned: .top).sizeToFit(.width).maxWidth(50%)
        imgvLogo1.pin.below(of: [lb1_1, lb1_2], aligned: .left).marginTop(padding).width(30).aspectRatio()
        lb1_3.pin.after(of: imgvLogo1, aligned: .top).marginLeft(10).right().sizeToFit(.width)
        tf1.pin.below(of: [imgvLogo1, lb1_3]).marginTop(10).height(44).width(100%).hCenter().marginLeft(10).pinEdges()
        btn_1.pin.below(of: tf1, aligned: .center).height(30)
        sw1.pin.below(of: btn_1, aligned: .center).width(50).marginTop(padding)
        
        viewContainer1.pin.wrapContent(.vertically, padding: 10).below(of: visible([bottomContainer, separatorView2])).hCenter().marginTop(padding)
        
        scrollView.contentSize = CGSize(width: frame.width, height: viewContainer1.frame.maxY)
    }

    private func configureLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
    }
}
