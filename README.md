# Expecta

An Objective-C/Cocoa Matcher Library

## STATUS

Under development. Not quite usable at this point.

## USAGE

>`expect(x).toEqual(y);` compares objects or primitives x and y and passes if they are identical (==) or equivalent (isEqual:).
>
>`expect(x).toBeNil();` passes if x is nil.
>
>`expect(x).toBeTruthy();` passes if x evaluates to true (non-zero).
>
>`expect(x).toBeFalsy();` passes if x evaluates to false (zero).
>
>`expect(x).toBeInstanceOf([Foo class]);` passes if x is an instance of a class Foo.
>
>`expect(x).toBeKindOf([Foo class]);` passes if x is an instance of a class Foo or if x is an instance of any class that inherits from the class Foo.
>
>`expect([Foo class]).toBeSubclassOf([Bar class]);` passes if the class Foo is a subclass of the class Bar or if it is identical to the class Bar.
>

Every matcher's criteria can be inverted by prepending `.Not`: (It is `Not` with a capital `N` because `not` is a keyword in C++.)

>`expect(x).Not.toEqual(y);` compares objects or primitives x and y and passes if they are *not* equivalent.

## LICENSE

Copyright (c) 2011 Peter Jihoon Kim. This software is licensed under the MIT License.
