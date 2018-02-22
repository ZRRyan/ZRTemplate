//
//  NSDate+Extension.m
//  Pati
//
//  Created by Ryan on 2017/6/11.
//  Copyright © 2017年 mew. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSString *)formateToStr {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currDate = [NSDate date];
    NSDateComponents *components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currDate];
    NSInteger currYear = components.year;
    NSInteger currMonth = components.month;
    NSInteger currDay = components.day;
    
    NSDateComponents *msgComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: self];
    NSInteger msgYear = msgComponents.year;
    NSInteger msgMonth = msgComponents.month;
    NSInteger msgDay = msgComponents.day;
    
    NSInteger timeInterval = self.timeIntervalSinceNow;
    timeInterval = -timeInterval;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (timeInterval < 60) {
        return @"刚刚";
    } else if (timeInterval < 60 * 60) {
        return [NSString stringWithFormat:@"%ld分钟前", (timeInterval / 60)];
    } else if (currYear == msgYear && currMonth == msgMonth && currDay == msgDay) {
        formatter.dateFormat = @"HH:mm";
    } else if (currYear == msgYear && currMonth == msgMonth && currDay - 1 == msgDay) {
        formatter.dateFormat = @"昨天 HH:mm";
    } else if (currYear == msgYear) {
        formatter.dateFormat = @"MM/dd";
    } else {
        formatter.dateFormat = @"yyyy/MM/dd";
    }
    
    NSString *timeStr = [formatter stringFromDate:self];
    return timeStr;
}

@end
