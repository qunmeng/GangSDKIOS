//
//  GangMessageNotifyTableViewCell.m
//  Demo
//
//  Created by xd on 2017/12/12.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangMessageNotifyTableViewCell.h"
#import "GangMessageNotificationViewController.h"
#import <GangSupport/MGWebImage.h>
@implementation GangMessageNotifyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.label_senderName setTextColor:[UIColor colorFromHexRGB:GangColor_messageCenter_senderName]];
    [self.label_content setTextColor:[UIColor colorFromHexRGB:GangColor_messageCenter_content]];
    [self.label_date setTextColor:[UIColor colorFromHexRGB:GangColor_messageCenter_date]];
    [self.btn_delete setTitleColor:[UIColor colorFromHexRGB:GangColor_messageCenter_btn_delete] forState:UIControlStateNormal];
    [self.btn_details setTitleColor:[UIColor colorFromHexRGB:GangColor_messageCenter_btn_details] forState:UIControlStateNormal];
}

- (void)setTheObj:(GangMessageBean *)obj{
    [super setTheObj:obj];
    if (obj.isread) {
        [self.iv_bg setImage:[UIImage imageNamed:@"qm_bg_message_notify_hasread"]];
    } else {
        [self.iv_bg setImage:[UIImage imageNamed:@"qm_bg_item"]];
    }
    [self.iv_senderIcon setImageWithURLString:obj.data.iconurl];
    self.label_senderName.text = obj.data.title;
    self.label_content.text = obj.data.content;
    NSString *str_date =[CodoneTools getTimeStringFromScends:[obj.createtime integerValue]/1000];
    if (str_date) {
       str_date = [str_date substringToIndex:10];;
    }
    self.label_date.text = str_date;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btn_delete_click:(UIButton *)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        ((GangMessageBean*)self.obj_hold).data.status = 3;
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}
- (IBAction)btn_details_click:(UIButton *)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        ((GangMessageBean*)self.obj_hold).data.status = 4;
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}

@end
