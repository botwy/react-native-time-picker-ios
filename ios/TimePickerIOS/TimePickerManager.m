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
  TimePickerView *pickerView = [[TimePickerView alloc] init];
  pickerView.pickerManager = self;
  
  return pickerView;
}

RCT_EXPORT_VIEW_PROPERTY(isDateShow, BOOL)

RCT_EXPORT_VIEW_PROPERTY(day, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(month, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(year, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(hour, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(minute, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(second, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(millisecond, NSInteger)

RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)

#pragma mark -

NSArray* _pickerTypes;

-(void)setPickerTypes:(NSArray *)pickerTypes {
  _pickerTypes = pickerTypes;
}

-(NSArray *)getPickerTypes{
  return _pickerTypes;
}

-(NSInteger)getPickerTypeBy:(NSInteger)component {
  NSArray *pickerTypes = [self getPickerTypes];
  return [[pickerTypes objectAtIndex:component] integerValue];
}

-(NSInteger)getPickerTypeIndexBy:(PickerType)pickerType {
  NSArray *pickerTypes = [self getPickerTypes];
  NSInteger pickerIndex = [pickerTypes indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    return [obj integerValue] == pickerType;
  }];
  
  return pickerIndex;
}

NSCalendar *calendar;
NSDate *firstDay;

- (id)init
{
  self = [super init];
  if (self) {
    calendar = NSCalendar.currentCalendar;
    firstDay = [calendar dateWithEra:1 year:1970 month:1 day:1 hour:0 minute:0 second:0 nanosecond:0];
    self.day = 1;
    self.month = 1;
    self.year = 1970;
    self.hour = 0;
    self.minute = 0;
    self.second = 0;
    self.millisecond = 0;
    self.isDateShow = false;
    _pickerTypes = @[@(Hour), @(Minute), @(Second), @(Millisecond)];
  }
  return self;
}

- (void)ajustPickerTypes {
  if (self.isDateShow) {
    [self setPickerTypes: @[@(Date), @(Hour), @(Minute), @(Second), @(Millisecond)]];
  } else {
    [self setPickerTypes: @[@(Hour), @(Minute), @(Second), @(Millisecond)]];
  }
}
#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
  return [[self getPickerTypes] count];
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  NSInteger pickerType = [self getPickerTypeBy:component];
  switch (pickerType) {
    case Date:
      return 365000;
    case Hour:
      return 24;
    case Minute:
    case Second:
      return 60;
    case Millisecond:
      return 1000;
    default:
      return 0;
      break;
  }
}

#pragma mark UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  NSInteger pickerType = [self getPickerTypeBy:component];
  NSString *title;
  
  if (pickerType == Date) {
    NSDate *selectDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:row toDate:firstDay options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.calendar = calendar;
    formatter.dateStyle = NSDateFormatterShortStyle;
    title = [formatter stringFromDate:selectDate];
    
  } else if (pickerType == Millisecond) {
    title = [NSString stringWithFormat:@"%03ld", (long)row];
  } else {
    title = [NSString stringWithFormat:@"%02ld", (long)row];
  }
  
  return title;
}

- (void)setDayMonthYear:(NSInteger)row {
  NSDate *selectDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:row toDate:firstDay options:0];
  NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:selectDate];
  self.day = dateComponents.day;
  self.month = dateComponents.month;
  self.year = dateComponents.year;
}

- (NSInteger)getDayIndex {
  NSDate *date = [calendar dateWithEra:1 year:self.year month:self.month day:self.day hour:0 minute:0 second:0 nanosecond:0];
  NSInteger dayIndex = ((int)date.timeIntervalSince1970 + calendar.timeZone.secondsFromGMT)/(60*60*24);
  
  return dayIndex;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  NSInteger pickerType = [self getPickerTypeBy:component];
  switch (pickerType) {
    case Date:
      [self setDayMonthYear:row];
      break;
    case Hour:
      self.hour = row;
      break;
    case Minute:
      self.minute = row;
      break;
    case Second:
      self.second = row;
      break;
    case Millisecond:
      self.millisecond = row;
      break;
  }
  
  TimePickerView *timePicker = (TimePickerView *)pickerView;
  if (!timePicker.onChange) {
    return;
  }
  if (self.isDateShow) {
    timePicker.onChange(@{
                          @"day": [NSNumber numberWithLong:self.day],
                          @"month": [NSNumber numberWithLong:self.month],
                          @"year": [NSNumber numberWithLong:self.year],
                          @"hour": [NSNumber numberWithLong:self.hour],
                          @"minute": [NSNumber numberWithLong:self.minute],
                          @"second": [NSNumber numberWithLong:self.second],
                          @"millisecond": [NSNumber numberWithLong:self.millisecond],
                          });
    return;
  }
  
  timePicker.onChange(@{
                        @"hour": [NSNumber numberWithLong:self.hour],
                        @"minute": [NSNumber numberWithLong:self.minute],
                        @"second": [NSNumber numberWithLong:self.second],
                        @"millisecond": [NSNumber numberWithLong:self.millisecond],
                        });
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
  NSInteger pickerType = [self getPickerTypeBy:component];
  if (pickerType == Date) {
    return 130.0;
  }
  if (pickerType == Millisecond) {
    return 70.0;
  }
  
  return 50.0;
}

@end


