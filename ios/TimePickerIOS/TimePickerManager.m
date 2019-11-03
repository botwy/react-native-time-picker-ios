//
//  TimePickerManager.m
//  TimePickerIOS
//
//  Created by Гончаров Денис Васильевич on 31.10.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimePickerManager.h"
#import "TimePickerView.h"

@implementation TimePickerManager
  
  #pragma mark RCTViewManager
  
  RCT_EXPORT_MODULE(TimePickerIOS)
  
  - (UIView *)view {
    return [[TimePickerView alloc] init];
  }
  
  RCT_EXPORT_VIEW_PROPERTY(hour, NSInteger)
  RCT_EXPORT_VIEW_PROPERTY(minute, NSInteger)
  RCT_EXPORT_VIEW_PROPERTY(second, NSInteger)
  RCT_EXPORT_VIEW_PROPERTY(millisecond, NSInteger)
  
  RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)

  #pragma mark -
  
  - (id)init
  {
    self = [super init];
    if (self) {
      self.hour = 0;
      self.minute = 0;
      self.second = 0;
      self.millisecond = 0;
    }
    return self;
  }
  
  #pragma mark - UIPickerViewDataSource
  
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
  return 4;
}
  
- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  switch (component) {
    case 0:
    return 24;
    case 1:
    case 2:
    return 60;
    case 3:
    return 1000;
    default:
    return 0;
  }
}
  
   #pragma mark UIPickerViewDelegate
  
  - (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    if (component == 3) {
      title = [NSString stringWithFormat:@"%03ld", (long)row];
    } else {
      title = [NSString stringWithFormat:@"%02ld", (long)row];
    }
    return title;
  }
  
  - (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
      case 0:
      self.hour = row;
      break;
      case 1:
      self.minute = row;
      break;
      case 2:
      self.second = row;
      break;
      case 3:
      self.millisecond = row;
      break;
      default:
      break;
    }
    
    TimePickerView *timePicker = (TimePickerView *)pickerView;
    if (!timePicker.onChange) {
      return;
    }
    timePicker.onChange(@{
                          @"hour": [NSNumber numberWithLong:self.hour],
                          @"minute": [NSNumber numberWithLong:self.minute],
                          @"second": [NSNumber numberWithLong:self.second],
                          @"millisecond": [NSNumber numberWithLong:self.millisecond],
                          });
  }
  
  @end


