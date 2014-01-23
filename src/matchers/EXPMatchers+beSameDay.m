#import "EXPMatchers+beSameDay.h"

EXPMatcherImplementationBegin(beSameDay, (NSDate *expected)) {

  BOOL actualIsNil = (actual == nil);
  BOOL expectedIsNil = (expected == nil);

  prerequisite(^BOOL{
    return !(actualIsNil || expectedIsNil);
  });

  match(^BOOL{
    NSDateComponents *actualDateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate: actual];
    NSUInteger actualYear = [actualDateComponents year];
    NSUInteger actualMonthOfYear = [actualDateComponents month];
    NSUInteger actualDayOfMonth = [actualDateComponents day];
    
    NSDateComponents *expectedDateComponents = [[NSCalendar currentCalendar] components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate: expected];
    NSUInteger expectedYear = [expectedDateComponents year];
    NSUInteger expectedMonthOfYear = [expectedDateComponents month];
    NSUInteger expectedDayOfMonth = [expectedDateComponents day];
    
    BOOL isWithinSameDay = (actualYear == expectedYear &&
                            actualMonthOfYear == expectedMonthOfYear &&
                            actualDayOfMonth == expectedDayOfMonth);
    
    return isWithinSameDay;
  });

  failureMessageForTo(^NSString * {
    if(actualIsNil) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";

    NSString *message = [NSString stringWithFormat: @"expected: %@ to be on same date as %@", actual, expected];
    return message;
  });

  failureMessageForNotTo(^NSString * {
    if(actualIsNil) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";
    
    NSString *message = [NSString stringWithFormat: @"expected: %@ to not be on same date as %@", actual, expected];
    return message;
  });
  
}

EXPMatcherImplementationEnd