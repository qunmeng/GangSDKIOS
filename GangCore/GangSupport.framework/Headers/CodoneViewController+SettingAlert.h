//
//  CodoneViewController+Alert.h
//  CodoneApplication
//
//  Created by codone on 2016/12/20.
//  Copyright © 2016年 codone. All rights reserved.
//

#import "CodoneViewController.h"

@interface CodoneViewController (SettingAlert)<UIAlertViewDelegate>
- (void)showAletToSettingFor:(int)type;
@end
