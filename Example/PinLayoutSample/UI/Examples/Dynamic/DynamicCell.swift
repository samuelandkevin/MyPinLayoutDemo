//
//  DynamicCell.swift
//  PinLayoutSample
//
//  Created by 黄坤鹏 on 2021/6/5.
//  Copyright © 2021 layoutbox. All rights reserved.
//

import Foundation
import PinLayout
import SDWebImage

class DynamicCell : UITableViewCell {
    
    var onFoldBlock:((DynamicCell)->Void)?
    
    /// 阴影
    fileprivate lazy var viewShadow: UIView = {
        let viewShadow = UIView()
        viewShadow.backgroundColor     = "#DBDBDB".color
        viewShadow.layer.shadowColor   =  "#DBDBDB".color.cgColor;
        viewShadow.layer.shadowOpacity = 0.67;
        viewShadow.layer.shadowOffset  = CGSize(width: 0, height: 0);
        viewShadow.layer.shadowRadius  = 4;
        viewShadow.layer.cornerRadius  = 10;
        return viewShadow
    }()
    
    /// 容器
    lazy var viewContainer: UIView = {
        let viewContainer = UIView()
        viewContainer.layer.masksToBounds = true
        viewContainer.layer.cornerRadius = 5
        viewContainer.backgroundColor = "#FFFFFF".color
        return viewContainer
    }()
    
    /// 时间
    fileprivate lazy var lbTime: UILabel = {
        let lbTime = UILabel.eh_creatLabel(text: "", textAlignment: .center, textColor: "#8C8C8C".color, font: UIFont.systemFont(ofSize: 14, weight: .regular))
        return lbTime
    }()
    
    
    /// 标题
    fileprivate lazy var lbTitle: UILabel = {
        let lbTitle = UILabel.eh_creatLabel(text: "", textAlignment: .left, textColor: "#383838".color, font: UIFont.systemFont(ofSize: 16, weight: .bold))
        return lbTitle
    }()
    
    /// 分隔线
    fileprivate lazy var viewSep: UIView = {
        let viewSep = UIView()
        viewSep.backgroundColor = "#EDEDED".color
        return viewSep
    }()
    
    /// 描述
    fileprivate lazy var lbDes: UILabel = {
        let lbDes = UILabel.eh_creatLabel(text: "", textAlignment: .left, textColor: "#383838".color, font: font_des)
        lbDes.numberOfLines = 0
        return lbDes
    }()
    
    private let font_des:UIFont = UIFont.systemFont(ofSize: 13, weight: .regular)
    

    /// 折叠文本
    fileprivate lazy var lbFold: UILabel = {
        let lbFold = UILabel.eh_creatLabel(text: "Unfold", textAlignment: .left, textColor: "#9E3CF8".color, font: UIFont.systemFont(ofSize: 12))
        lbFold.isUserInteractionEnabled = true
        lbFold.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFold)))
        lbFold.eh_clickEdgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 30)
        return lbFold
    }()
    
    /// 箭头
    fileprivate lazy var imgvFold: UIImageView = {
        let imgvFold = UIImageView()
        imgvFold.image = UIImage(named: "btn_msg_unfold")  // 11 7
        imgvFold.isUserInteractionEnabled = true
        imgvFold.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFold)))
        return imgvFold
    }()
    
    /// 图片内容
    fileprivate lazy var imgvContent: UIImageView = {
        let imgvContent = UIImageView()
        imgvContent.backgroundColor = .gray
        return imgvContent
    }()
   
    /// 属性文本
    fileprivate lazy var attributes: [NSAttributedString.Key : Any] = {
        var attributes:[NSAttributedString.Key : Any] = [:]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .left
        attributes = [
            NSAttributedString.Key.paragraphStyle : paragraphStyle,
            NSAttributedString.Key.font:font_des,
            NSAttributedString.Key.foregroundColor:"#383838".color
        ]
        return attributes
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _layoutUI()
    }
    
    /// 数据源
    var model:EHMessageModel? {
        didSet {
            
            // 文本显示，接受或者拒绝
            if let m = model   {
               
                //标题
                lbTitle.text  = m.msgTitle
  
                
                
                //时间
                lbTime.text   = "234324"
                
                
                //设置图片
                if let imageUrl = m.imageUrl,imageUrl.count > 0{
                    imgvContent.sd_setImage(with: URL(string: imageUrl)) {[weak self] (image, error, cacheType, url) in
                        guard let weakSelf = self else { return}
                        if let image = image{
                            var w1 = UIScreen.main.bounds.size.width * 0.7
                            if image.size.width < w1 {
                                w1 = image.size.width
                            }
                            let h1 = image.size.height * w1 / image.size.width
                            weakSelf.imgvContent.image = image
                            if let u = weakSelf.model?.imageUrl ,u == imageUrl {
                                print("下载成功后，更新图片，\(u)")
                                weakSelf.model?.imageW = w1
                                weakSelf.model?.imageH = h1
                                weakSelf.setNeedsLayout()
                            }
                        }
                    }

                }else{
                    imgvContent.image = nil
                }
                
              
    
                lbDes.attributedText = NSAttributedString(string: m.msgContent ?? "", attributes: attributes)
                
                //计算文本高度
                let textHeight = (m.msgContent ?? "").boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width - 80, height: CGFloat(Double.greatestFiniteMagnitude)),
                options: .usesLineFragmentOrigin,
                attributes: attributes,
                context: nil).size.height
                //字体大小 * 行数
                let rowsLimit:CGFloat = 3
                let limitHeight = font_des.pointSize * rowsLimit + 5*CGFloat(rowsLimit)
                if textHeight > limitHeight {
                    lbFold.isHidden   = false
                    imgvFold.isHidden = false
                    if m.isOpening {
                        imgvFold.image = UIImage(named: "btn_msg_fold")
                        lbFold.text = "Fold"
                        lbDes.numberOfLines = 0
                    } else {
                        imgvFold.image = UIImage(named: "btn_msg_unfold")
                        lbFold.text = "Unfold"
                        lbDes.numberOfLines = Int(rowsLimit)
                    }
                }else{
                    lbFold.isHidden   = true
                    imgvFold.isHidden = true
                    lbFold.text = ""
                    lbDes.numberOfLines = 0
                }
                
            }else{
                lbDes.text  = ""
                lbTime.text = ""
                imgvContent.image = nil
            }
            
            _layoutUI()
            
        }
    }
}

// MARK: - Private
extension DynamicCell{
    fileprivate func _setupUI(){
        self.selectionStyle = .none
        contentView.addSubview(lbTime)
        contentView.addSubview(viewShadow)
        contentView.addSubview(viewContainer)
        viewContainer.addSubview(lbTitle)
        viewContainer.addSubview(viewSep)
        viewContainer.addSubview(lbDes)
        viewContainer.addSubview(lbFold)
        viewContainer.addSubview(imgvFold)
        viewContainer.addSubview(imgvContent)
        
    }
    
    fileprivate func _layoutUI(){

        lbTime.pin.horizontally().top(10).sizeToFit(.width)
        
        lbTitle.pin.horizontally(19).marginTop(16).sizeToFit(.width)
        
        viewSep.pin.height(1).horizontally().below(of: lbTitle).marginTop(12)
        
        lbDes.pin.horizontally(19).below(of: lbTitle).marginTop(24).sizeToFit(.width)
        
        lbFold.pin.below(of: lbDes).left(to: lbTitle.edge.left).marginTop(10).sizeToFit(.widthFlexible)
        
        imgvFold.pin.width(11).height(7).after(of: lbFold,aligned: .center).marginLeft(5)
        
        imgvContent.pin.below(of: visible([lbDes,lbFold])).left(to: lbTitle.edge.left).width(model?.imageW ?? 0).marginTop(10).marginBottom(20).height(model?.imageH ?? 0)
        
        viewContainer.pin.below(of: lbTime).horizontally(20).marginTop(10).wrapContent(.vertically,padding: 10).bottom(10)
        
        viewShadow.pin.center(to: viewContainer.anchor.center).size(of: viewContainer)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        _layoutUI()
        return CGSize(width:size.width , height: viewContainer.frame.maxY + 20)
    }
    
    @objc func onFold(){
        //点击展开按钮
        if let b = onFoldBlock{
            b(self)
        }
    }
}

