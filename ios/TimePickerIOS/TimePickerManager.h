//
//  TimePickerManager.h
//  TimePickerIOS
//
//  Created by Гончаров Денис Васильевич on 31.10.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __has_include(<React/RCTViewManager.h>)
#import <React/RCTViewManager.h>
#else
#import "RCTViewManager.h"
#endif

typedef enum { Date, Hour, Minute, Second, Millisecond } PickerType;

@interface TimePickerManager : RCTViewManager <UIPickerViewDelegate, UIPickerViewDataSource>

@property BOOL isDateShow;

@property NSInteger day;
@property NSInteger month;
@property NSInteger year;
@property NSInteger hour;
@property NSInteger minute;
@property NSInteger second;
@property NSInteger millisecond;

-(NSInteger)getPickerTypeIndexBy:(PickerType)pickerType;
-(NSInteger)getDayIndex;
-(void)ajustPickerTypes;

@end
