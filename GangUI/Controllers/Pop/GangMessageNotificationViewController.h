//
//  GangMessageNotificationViewController.h
//  Demo
//
//  Created by xd on 2017/12/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBasePresentViewController.h"
@protocol GangMessageNotificationDelegate <NSObject>
-(void)update:(id)obj;
@end
@interface GangMessageNotificationViewController : GangBasePresentViewController

@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet UILabel *label_content;
@property (weak, nonatomic) IBOutlet UILabel *label_date;
@property (weak, nonatomic) IBOutlet UILabel *label_sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_status;

@property (strong) NSString *content;
@property (strong) NSString *date;
@property (strong) NSString *sender;
@property (strong) id obj;

@property (weak) id<GangMessageNotificationDelegate> delegate;
@end
