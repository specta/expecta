# Expecta RDD

## To Be Implemented

### Asynchronous Tests

>`expect(x).isGoing.toEqual(y);` passes if x and y eventually become equivalent
>
>`expect(x).isNotGoing.toEqual(y);` passes if x and y do not eventually become equivalent

### BOOL

>`expect(x).toBeYes();` passes if x is a BOOL value of YES
>
>`expect(x).toBeNo();` passes if x is a BOOL value of NO

### Class

>`expect(x).toConformToProtocol(y);` passes if class or object x conforms to protocol y

### Object

>`expect(x).toConformToProtocol(y);` passes if class or object x conforms to protocol y
>
>`expect(x).toRespondToSelector(y);` passes if class or object x responds to selector y

### Number

>`expect(x).toBeLessThan(y);` passes if x is less than y
>
>`expect(x).toBeLessThanOrEqualTo(y);` passes if x is less than or equal to y
>
>`expect(x).toBeGreaterThan(y);` passes if x is greater than y
>
>`expect(x).toBeGreaterThanOrEqualTo(y);` passes if x is greater than or equal to y
>
>`expect(x).toBeCloseTo(y, z);` passes if x is equal to y to a precision of z decimal places
>
>`expect(x).toBeInTheRangeOf(y, z);` passes if x is in the range of [y, z]

### Exceptions

>`expect(^{ expr; }).toThrow(e);` passes if expr throws an exception e when executed
>
>`expect(^{ expr; }).toChange(x.hello, z);` passes if expr changes x.hello by amount z

### String

>`expect(x).toMatch(y);` compares x to a regex pattern y and passes if they match

### Collection

>`expect(x).toBeEmpty();` passes if x is empty
>
>`expect(x).toHaveCountOf(y);` passes if x contains y number of objects
>
>`expect(x).toHaveCountOfAtLeast(y);` passes if x contains at least y number of objects
>
>`expect(x).toHaveCountOfAtMost(y);` passes if x contains at most y number of objects
