#import "EXPExpect.h"
#import "NSObject+Expecta.h"
#import "Expecta.h"
#import "EXPUnsupportedObject.h"
#import "EXPMatcher.h"
#import "EXPBlockDefinedMatcher.h"
#import <libkern/OSAtomic.h>

@interface EXPExpect ()

@property(nonatomic) NSMutableArray *failureMessages;

@end

@implementation EXPExpect

@dynamic
  actual,
  to,
  toNot,
  notTo,
  will,
  willNot;

@synthesize
  actualBlock=_actualBlock,
  testCase=_testCase,
  negative=_negative,
  asynchronous=_asynchronous,
  collection=_collection,
  lineNumber=_lineNumber,
  fileName=_fileName;

- (id)initWithActualBlock:(id)actualBlock testCase:(id)testCase lineNumber:(int)lineNumber fileName:(const char *)fileName {
  self = [super init];
  if(self) {
    self.actualBlock = actualBlock;
    self.testCase = testCase;
    self.negative = NO;
    self.asynchronous = NO;
    self.lineNumber = lineNumber;
    self.fileName = fileName;
  }
  return self;
}

- (void)dealloc
{
  self.actualBlock = nil;
  [super dealloc];
}

+ (EXPExpect *)expectWithActualBlock:(id)actualBlock testCase:(id)testCase lineNumber:(int)lineNumber fileName:(const char *)fileName {
  return [[[EXPExpect alloc] initWithActualBlock:actualBlock testCase:(id)testCase lineNumber:lineNumber fileName:fileName] autorelease];
}

#pragma mark -

- (EXPExpect *)elements;
{
  self.collection = YES;
  return self;
}

- (EXPExpect *)to {
  return self;
}

- (EXPExpect *)toNot {
  self.negative = !self.negative;
  return self;
}

- (EXPExpect *)notTo {
  return [self toNot];
}

- (EXPExpect *)will {
  self.asynchronous = YES;
  return self;
}

- (EXPExpect *)willNot {
  return self.will.toNot;
}

#pragma mark -

- (id)actual {
  if(self.actualBlock) {
    return self.actualBlock();
  }
  return nil;
}

- (void)applyMatcher:(id<EXPMatcher>)matcher
{
  id actual = [self actual];
  self.failureMessages = [NSMutableArray array];
  
  if([actual isKindOfClass:[EXPUnsupportedObject class]]) {
    EXPFail(self.testCase, self.lineNumber, self.fileName,
            [NSString stringWithFormat:@"expecting a %@ is not supported", ((EXPUnsupportedObject *)actual).type]);
    return;
  }
  
  if([matcher respondsToSelector:@selector(meetsPrerequesiteFor:)] && ![matcher meetsPrerequesiteFor:actual]) {
    [self collectFailureWithMatcher:matcher
                             actual:actual
           failureMessageDecoration:nil];
  } else {
    NSTimeInterval timeOut = [Expecta asynchronousTestTimeout];
    NSDate *expiryDate = [NSDate dateWithTimeIntervalSinceNow:timeOut];
    while(1) {
      [self evaluateWithMatcher:matcher actual:actual];
      if(!self.asynchronous || self.failureMessages.count == 0 || ([(NSDate *)[NSDate date] compare:expiryDate] == NSOrderedDescending)) {
        break;
      }
      [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
      OSMemoryBarrier();
      actual = [self actual];
      [self.failureMessages removeAllObjects];
    }
  }
  if(self.failureMessages.count > 0) {
    EXPFail(self.testCase, self.lineNumber, self.fileName, [self.failureMessages componentsJoinedByString:@", "]);
  }
  self.negative = NO;
}

- (void)evaluateWithMatcher:(id<EXPMatcher>)matcher
                     actual:(id)actual;
{
  if(self.collection) {
    if(!actual && self.asynchronous) {
      [self collectFailureWithMatcher:matcher actual:nil failureMessageDecoration:nil];
      return;
    }
    
    if ([actual isKindOfClass:[NSArray class]] || [actual isKindOfClass:[NSOrderedSet class]]) {
      [actual enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self collectFailureIfRequiredWithMatcher:matcher
                                           actual:obj
                         failureMessageDecoration:^(NSString *matcherString){
                           return [NSString stringWithFormat:@"(%lu)=> %@", idx, matcherString];
                         }];
      }];
    } else if ([actual isKindOfClass:[NSSet class]]) {
      [(NSSet *)actual enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [self collectFailureIfRequiredWithMatcher:matcher
                                           actual:obj
                         failureMessageDecoration:^(NSString *matcherString){
                           return [NSString stringWithFormat:@"(element)=> %@", matcherString];
                         }];
      }];
    }
    
  } else {
    [self collectFailureIfRequiredWithMatcher:matcher
                                       actual:actual
                     failureMessageDecoration:nil];
  }
}

- (void)collectFailureIfRequiredWithMatcher:(id<EXPMatcher>)matcher
                                     actual:(id)actual
                   failureMessageDecoration:(NSString *(^)(NSString *matcherString))failureMessageDecoration;
{
  if ([matcher matches:actual] != self.negative) {
    return;
  }
  
  [self collectFailureWithMatcher:matcher
                           actual:actual
         failureMessageDecoration:failureMessageDecoration];
}

- (void)collectFailureWithMatcher:(id<EXPMatcher>)matcher
                           actual:(id)actual
         failureMessageDecoration:(NSString *(^)(NSString *matcherString))failureMessageDecoration;
{
  NSString *message = nil;
  
  if(self.negative) {
    if ([matcher respondsToSelector:@selector(failureMessageForNotTo:)]) {
      message = [matcher failureMessageForNotTo:actual];
    }
  } else {
    if ([matcher respondsToSelector:@selector(failureMessageForTo:)]) {
      message = [matcher failureMessageForTo:actual];
    }
  }
  if (message == nil) {
    message = @"Match Failed.";
  }
  
  if (failureMessageDecoration) {
    [self.failureMessages addObject:failureMessageDecoration(message)];
  } else {
    [self.failureMessages addObject:message];
  }
}

#pragma mark - Dynamic predicate dispatch

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
  if ([self.actual respondsToSelector:aSelector]) {
    return [self.actual methodSignatureForSelector:aSelector];
  }
  return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
  if ([self.actual respondsToSelector:anInvocation.selector]) {
    EXPDynamicPredicateMatcher *matcher = [[EXPDynamicPredicateMatcher alloc] initWithExpectation:self selector:anInvocation.selector];
    [anInvocation setSelector:@selector(dispatch)];
    [anInvocation invokeWithTarget:matcher];
    [matcher release];
  }
  else {
    [super forwardInvocation:anInvocation];
  }
}

@end

@implementation EXPDynamicPredicateMatcher

- (id)initWithExpectation:(EXPExpect *)expectation selector:(SEL)selector
{
  if ((self = [super init])) {
    _expectation = expectation;
    _selector = selector;
  }
  return self;
}

- (BOOL)matches:(id)actual
{
  return (BOOL)[actual performSelector:_selector];
}

- (NSString *)failureMessageForTo:(id)actual
{
  return [NSString stringWithFormat:@"expected %@ to be true", NSStringFromSelector(_selector)];
}

- (NSString *)failureMessageForNotTo:(id)actual
{
  return [NSString stringWithFormat:@"expected %@ to be false", NSStringFromSelector(_selector)];
}

- (void (^)(void))dispatch
{
  __block id blockExpectation = _expectation;

  return [[^{
    [blockExpectation applyMatcher:self];
  } copy] autorelease];
}

@end
