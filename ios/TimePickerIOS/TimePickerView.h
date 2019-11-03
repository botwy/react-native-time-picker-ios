//
//  TimePickerView.h
//  TimePickerIOS
//
//  Created by Гончаров Денис Васильевич on 31.10.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimePickerManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TimePickerView : UIPickerView
  
  @property (strong, nonatomic) TimePickerManager *pickerManager;
  @property NSInteger hour;
  @property NSInteger minute;
  @property NSInteger second;
  @property NSInteger millisecond;
  
  @property (nonatomic, copy) RCTBubblingEventBlock onChange;
  
  @end

NS_ASSUME_NONNULL_END
