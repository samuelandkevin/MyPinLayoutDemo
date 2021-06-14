//
//  Model.swift
//  PinLayoutSample
//
//  Created by 黄坤鹏 on 2021/6/6.
//  Copyright © 2021 layoutbox. All rights reserved.
//

import Foundation

enum EHMessageType: Int16 {
    /// 手机顶部通知栏
    case push = 0
    /// 首页弹窗
    case popUp = 1
    /// 系统消息
    case message = 2
    /// 提醒输入经期
    case inputPeriod = 3
    /// 提醒测试
    case inputTest = 4
    /// 医生对患者的邮件邀请信息
    case mailInvite = 5
    /// 扫码安装app,全球优惠券弹窗
    case globalCoupon = 6
    /// 被邀请者弹窗，弹窗或message都可以获取活动优惠券
    case invitedCoupon = 7
    /// 邀请者不弹窗，message领取活动优惠券
    case inviteCoupon = 8
    /// 新弹窗方式
    case newPopup = 9
}

open class EHMessageModel: NSObject {

    @objc public var userID: String?
    @objc public var messageID: String?
    @objc public var notificationID: String?
    @objc public var campaignID: String?
    /// type: 0.手机顶部通知栏  1.首页弹窗 2.系统消息   3.提醒输入经期  4.提醒测试   5.医生对患者的邮件邀请信息，6.全球优惠券弹窗 7、被邀请者弹窗，弹窗或message都可以获取活动优惠券 8、邀请者不弹窗，message领取活动优惠券  9.新弹窗方式
    @objc public var msgType: Int16 = 0
    @objc public var msgTitle: String?
    @objc public var msgContent: String?
    @objc public var imageUrl: String?
    @objc public var msgLink: String?
    @objc public var createTime: NSDate?
    @objc public var updateTime: NSDate?
    @objc public var extraId:String? //邮件邀请数据分享的主键id
    @objc public var inviteId:String? //邀请id
    @objc public var name:String? // 医生名字
    @objc public var inviteStatus:String?// 对应邮件邀请的状态 已创建 HAS_CREATE,已阅读 HAS_READ, 已拒绝 HAS_REFUSE, 已接受 HAS_ACCEPT

    /// 打开h5的地址
    @objc public var viewLink:String?
    /// 该消息是否增加到消息列表中
    @objc public var addMsgList:Bool = false
    /// 消息的权重，越多越优先
    @objc public var priority:Int16 = 0
    /// 是否弹窗(否则就直接打开网页)
    @objc public var isPopup:Bool = false
    /// 是否可以点击回退按钮，true：禁止返回，false：允许返回
    @objc public var noBack:Bool = false
    
    // 以下为自定义字段
    /// 消息未读
    @objc public var unRead:Bool = false
    
    //  是否展开
    public var isOpening: Bool = false
    
    // 图片高度
    public var imageH:CGFloat = 0
    
    // 图片
    public var image:UIImage?
    
    public var imageW:CGFloat = 0
    public override init() {
        super.init()
    }
    
   
    
    
}
