# Expecta

An Objective-C/Cocoa Matcher Library

## STATUS

Under development. Not quite usable at this point.

## USAGE

>`expect(x).toEqual(y);` compares objects or primitives x and y and passes if they are equivalent
>
>`expect(x).toBeNil();` passes if `x` is `nil`
>
>`expect(x).toBeInstanceOf([Foo class]);` passes if `x` is an instance of a class `Foo`
>`expect(x).toBeAnInstanceOf([Foo class]);`
>`expect(x).toBeMemberOf([Foo class]);`
>`expect(x).toBeAMemberOf([Foo class]);`
>
>`expect(x).toBeKindOf([Foo class]);` passes if `x` is an instance of the class `Foo` or if `x` is an instance of any class that inherits from the class `Foo`.
>`expect(x).toBeAKindOf([Foo class]);`
>
>`expect([Foo class]).toBeSubclassOf([Bar class]);` passes if the class `Foo` is a subclass of the class `Bar` or if the class `Foo` is identical to the class `Bar`.
>`expect([Foo class]).toBeASubclassOf([Bar class]);`
>

Every matcher's criteria can be inverted by prepending `.Not`: (It is `Not` with a capital `N` because `not` is a keyword in C++.)

>`expect(x).Not.toEqual(y);` compares objects or primitives `x` and `y` and passes if they are *not* equivalent

## LICENSE

Copyright (c) 2011 Peter Jihoon Kim. This software is licensed under the MIT License.
