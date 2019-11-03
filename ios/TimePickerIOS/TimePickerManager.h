//
//  TimePickerManager.h
//  TimePickerIOS
//
//  Created by Гончаров Денис Васильевич on 31.10.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTViewManager.h>

@interface TimePickerManager : RCTViewManager <UIPickerViewDelegate, UIPickerViewDataSource>
  
  @property NSInteger hour;
  @property NSInteger minute;
  @property NSInteger second;
  @property NSInteger millisecond;
  
  @end
