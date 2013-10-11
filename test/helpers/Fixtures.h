#import <Foundation/Foundation.h>

@protocol Protocol <NSObject> @end

@interface Foo : NSObject; @end;
@interface Bar : Foo; @end;
@interface Baz : NSObject <Protocol>; @end;
