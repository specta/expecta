// Expecta - EXPMatchers+toEqual.h
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "Expecta.h"
#define toEqual(expected) _toEqual(EXPObjectify((expected)))

EXPMatcherInterface(_toEqual, (id expected));
