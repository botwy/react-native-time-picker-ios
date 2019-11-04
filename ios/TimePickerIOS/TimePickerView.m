//
//  TimePickerView.m
//  TimePickerIOS
//
//  Created by Гончаров Денис Васильевич on 31.10.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

#import "TimePickerView.h"

@implementation TimePickerView
  
  - (void)setup {
    self.delegate = self.pickerManager;
    self.dataSource = self.pickerManager;

    if (self.pickerManager.isDateShow) {
      [self selectRow:[self.pickerManager getDayIndex] inComponent:[self.pickerManager getPickerTypeIndexBy:Date] animated:true];
    }
    [self selectRow:self.pickerManager.hour inComponent:[self.pickerManager getPickerTypeIndexBy:Hour] animated:false];
    [self selectRow:self.pickerManager.minute inComponent:[self.pickerManager getPickerTypeIndexBy:Minute] animated:false];
    [self selectRow:self.pickerManager.second inComponent:[self.pickerManager getPickerTypeIndexBy:Second] animated:false];
    [self selectRow:self.pickerManager.millisecond inComponent:[self.pickerManager getPickerTypeIndexBy:Millisecond] animated:false];
  }

- (BOOL)isDateShow {
  return self.pickerManager.isDateShow;
}

- (void)setIsDateShow:(BOOL)isDateShow {
  self.pickerManager.isDateShow = isDateShow;
  [self.pickerManager ajustPickerTypes];
  [self setup];
}

- (NSInteger)day {
  return self.pickerManager.day;
}

- (void)setDay:(NSInteger)day {
  self.pickerManager.day = day;
  if (self.pickerManager.isDateShow) {
    [self selectRow:[self.pickerManager getDayIndex] inComponent:[self.pickerManager getPickerTypeIndexBy:Date] animated:true];
  }
}

- (NSInteger)month {
  return self.pickerManager.month;
}

- (void)setMonth:(NSInteger)month {
  self.pickerManager.month = month;
  if (self.pickerManager.isDateShow) {
     [self selectRow:[self.pickerManager getDayIndex] inComponent:[self.pickerManager getPickerTypeIndexBy:Date] animated:true];
  }
}

- (NSInteger)year {
  return self.pickerManager.year;
}

- (void)setYear:(NSInteger)year {
  self.pickerManager.year = year;
  if (self.pickerManager.isDateShow) {
   [self selectRow:[self.pickerManager getDayIndex] inComponent:[self.pickerManager getPickerTypeIndexBy:Date] animated:true];
  }
}

  - (NSInteger)hour {
    return self.pickerManager.hour;
  }
  
  - (void)setHour:(NSInteger)hour {
    self.pickerManager.hour = hour;
    [self selectRow:self.pickerManager.hour inComponent:[self.pickerManager getPickerTypeIndexBy:Hour] animated:true];
  }
  
  - (NSInteger)minute {
    return self.pickerManager.second;
  }
  
  - (void)setMinute:(NSInteger)minute {
    self.pickerManager.minute = minute;
    [self selectRow:self.pickerManager.minute inComponent:[self.pickerManager getPickerTypeIndexBy:Minute] animated:true];
  }
  
  - (NSInteger)second {
    return self.pickerManager.second;
  }
  
  - (void)setSecond:(NSInteger)second {
    self.pickerManager.second = second;
    [self selectRow:self.pickerManager.second inComponent:[self.pickerManager getPickerTypeIndexBy:Second] animated:true];
  }
  
  - (NSInteger)millisecond {
    return self.pickerManager.millisecond;
  }
  
  - (void)setMillisecond:(NSInteger)millisecond {
    self.pickerManager.millisecond = millisecond;
    [self selectRow:self.pickerManager.millisecond inComponent:[self.pickerManager getPickerTypeIndexBy:Millisecond] animated:true];
  }
  
  @end
