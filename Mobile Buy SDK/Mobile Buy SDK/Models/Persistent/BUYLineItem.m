//
//  _BUYLineItem.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,



//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "BUYLineItem.h"

#import "BUYCartLineItem.h"
#import "BUYProductVariant.h"

@implementation BUYLineItem

/**
 *  Have model manager responsible for instantiation, and allow deprecated
 *  initializers for backwards compatability
 */
- (instancetype)initWithCartLineItem:(BUYCartLineItem *)cartLineItem
{
	BUYLineItem *lineItem = [[BUYLineItem alloc] initWithModelManager:cartLineItem.modelManager JSONDictionary:nil];
	[lineItem updateWithLineItem:cartLineItem];
	return lineItem;
}

- (instancetype)initWithVariant:(BUYProductVariant *)variant
{
	BUYLineItem *lineItem = [[BUYLineItem alloc] initWithModelManager:variant.modelManager JSONDictionary:nil];
	[lineItem updateWithVariant:variant];
	return lineItem;
}

- (void)updateWithVariant:(BUYProductVariant *)variant
{
	self.variantId = variant.identifier;
	self.quantity = variant ? [NSDecimalNumber one] : [NSDecimalNumber zero];
	self.price = variant.price ?: [NSDecimalNumber zero];
	self.title = variant.title ?: @"";
	self.requiresShipping = variant.requiresShipping;
	self.compareAtPrice = variant.compareAtPrice;
	self.grams = variant.grams;
}

- (void)updateWithLineItem:(BUYCartLineItem *)lineItem
{
	[self updateWithVariant:lineItem.variant];
	self.quantity = lineItem.quantity;
}

- (NSString *)lineItemIdentifier
{
	return self.identifier;
}

@end

@implementation BUYModelManager (BUYLineItemCreation)

- (BUYLineItem *)lineItemWithVariant:(BUYProductVariant *)variant
{
	BUYLineItem *lineItem = [self insertLineItemWithJSONDictionary:nil];
	[lineItem updateWithVariant:variant];
	return lineItem;
}

- (BUYLineItem *)lineItemWithCartLineItem:(BUYCartLineItem *)cartLineItem
{
	BUYLineItem *lineItem = [self insertLineItemWithJSONDictionary:nil];
	[lineItem updateWithLineItem:cartLineItem];
	return lineItem;
}

@end
