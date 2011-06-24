// Expecta - EXPMatchers+toContain.h
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "Expecta.h"

EXPMatcherInterface(_toContain, (id expected));
EXPMatcherInterface(toContain, (id expected)); // to aid code completion
#define toContain(expected) _toContain(EXPObjectify((expected)))
