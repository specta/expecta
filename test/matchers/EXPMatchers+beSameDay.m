#import "TestHelper.h"

@interface EXPMatchers_beSameDay : TEST_SUPERCLASS {
  NSDate *dateOne;
  NSDate *dateTwo;
  NSDate *dateThree;
}
@end

@implementation EXPMatchers_beSameDay

- (void) setUp {
  dateOne = [NSDate dateWithTimeIntervalSince1970: 1388588400];
  dateTwo = [NSDate dateWithTimeIntervalSince1970: 1388602800];
  dateThree = [NSDate dateWithTimeIntervalSince1970: 1388689200];
}

- (void) test_beSameDate {
  assertPass(test_expect(dateOne).beSameDay(dateTwo));
  NSString *expectedFailMessage = [NSString stringWithFormat: @"expected: %@ to be on same date as %@", dateOne, dateThree];
  assertFail(test_expect(dateOne).beSameDay(dateThree), expectedFailMessage);
}

- (void) test_toNot_beTruthy {
  assertPass(test_expect(dateOne).toNot.beSameDay(dateThree));
  NSString *expectedFailMessage = [NSString stringWithFormat: @"expected: %@ to not be on same date as %@", dateOne, dateTwo];
  assertFail(test_expect(dateOne).toNot.beSameDay(dateTwo),  expectedFailMessage);
}

@end