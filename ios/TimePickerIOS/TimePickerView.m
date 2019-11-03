//
//  TimePickerView.m
//  TimePickerIOS
//
//  Created by Гончаров Денис Васильевич on 31.10.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

#import "TimePickerView.h"

@implementation TimePickerView
  
  - (instancetype)initWithFrame:(CGRect)frame
  {
    self = [super initWithFrame:frame];
    if (self) {
      [self setup];
    }
    
    return self;
  }
  
  - (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
      [self setup];
    }
    
    return self;
  }
  
  - (void)setup {
    self.pickerManager = [[TimePickerManager alloc] init];
    self.delegate = self.pickerManager;
    self.dataSource = self.pickerManager;
    
    [self selectRow:self.pickerManager.hour inComponent:0 animated:false];
    [self selectRow:self.pickerManager.minute inComponent:1 animated:false];
  }
  
  - (NSInteger)hour {
    return self.pickerManager.hour;
  }
  
  - (void)setHour:(NSInteger)hour {
    self.pickerManager.hour = hour;
    [self selectRow:self.pickerManager.hour inComponent:0 animated:true];
  }
  
  - (NSInteger)minute {
    return self.pickerManager.second;
  }
  
  - (void)setMinute:(NSInteger)minute {
    self.pickerManager.minute = minute;
    [self selectRow:self.pickerManager.minute inComponent:1 animated:true];
  }
  
  - (NSInteger)second {
    return self.pickerManager.second;
  }
  
  - (void)setSecond:(NSInteger)second {
    self.pickerManager.second = second;
    [self selectRow:self.pickerManager.second inComponent:2 animated:true];
  }
  
  - (NSInteger)millisecond {
    return self.pickerManager.millisecond;
  }
  
  - (void)setMillisecond:(NSInteger)millisecond {
    self.pickerManager.millisecond = millisecond;
    [self selectRow:self.pickerManager.millisecond inComponent:3 animated:true];
  }
  
  @end
