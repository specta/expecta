# Expecta

An Objective-C/Cocoa Matcher Library

## STATUS

Under development. Not quite usable at this point.

## USAGE

>`expect(x).toEqual(y);` compares objects or primitives x and y and passes if they are equivalent
>
>`expect(x).toBeNil();` passes if `x` is `nil`

Every matcher's criteria can be inverted by prepending `.Not`: (It is `Not` with a capital `N` because `not` is a keyword in C++.)

>`expect(x).Not.toEqual(y);` compares objects or primitives `x` and `y` and passes if they are *not* equivalent

## LICENSE

Copyright (c) 2011 Peter Jihoon Kim. This software is licensed under the MIT License.
