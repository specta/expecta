// Expecta - EXPMatchers+toEqual.h
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "Expecta.h"

EXPMatcherInterface(_toEqual, (id expected));
EXPMatcherInterface(toEqual, (id expected)); // to aid code completion
#define toEqual(expected) _toEqual(EXPObjectify((expected)))
