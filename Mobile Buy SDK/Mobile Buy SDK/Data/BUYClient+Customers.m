//
//  BUYClient+Customers.m
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

#import "BUYClient+Customers.h"
#import "BUYClient+Internal.h"
#import "BUYClient+Routing.h"
#import "NSDateFormatter+BUYAdditions.h"
#import "BUYCustomer.h"
#import "BUYAccountCredentials.h"
#import "BUYAuthenticatedResponse.h"
#import "BUYOrder.h"
#import "BUYShopifyErrorCodes.h"
#import "BUYRouter.h"

@implementation BUYClient (Customers)

#pragma mark - Customer

- (NSURLSessionDataTask *)getCustomerWithID:(NSString *)customerID callback:(BUYDataCustomerBlock)block
{
	NSURL *route = [self urlForCustomersWithID:customerID];
	return [self getRequestForURL:route completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		BUYCustomer *customer = nil;
		if (json && !error) {
			customer = [self.modelManager customerWithJSONDictionary:json];
		}
		block(customer, error);
	}];
}

- (NSURLSessionDataTask *)createCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *route = [self urlForCustomers];
	return [self postRequestForURL:route object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		if (json && !error) {
			[self createTokenForCustomerWithCredentials:credentials customerJSON:json callback:block];
		}
		else {
			block(nil, nil, error);
		}
	}];
}

- (NSURLSessionDataTask *)createTokenForCustomerWithCredentials:(BUYAccountCredentials *)credentials customerJSON:(NSDictionary *)customerJSON callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *route = [self urlForCustomersToken];
	return [self postRequestForURL:route object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		if (json && !error) {
			BUYAuthenticatedResponse *authenticatedResponse = [BUYAuthenticatedResponse responseWithJSON:json];
			self.customerToken = authenticatedResponse.accessToken;
			
			if (!customerJSON) {
				[self getCustomerWithID:authenticatedResponse.customerID callback:^(BUYCustomer *customer, NSError *error) {
					block(customer, self.customerToken, error);
				}];
			}
			else {
				BUYCustomer *customer = [self.modelManager customerWithJSONDictionary:json[@"customer"]];
				block(customer, self.customerToken, error);
			}
		}
		else {
			block(nil, nil, error);
		}
	}];
}

- (NSURLSessionDataTask *)loginCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block
{
	return [self createTokenForCustomerWithCredentials:credentials customerJSON:nil callback:block];
}

- (NSURLSessionDataTask *)recoverPasswordForCustomer:(NSString *)email callback:(BUYDataStatusBlock)block
{
	NSURL *route = [self urlForCustomersPasswordRecovery];
	return [self postRequestForURL:route object:@{@"email": email} completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
		if (!error) {
			error = [self errorFromJSON:json response:response];
		}
		
		block(statusCode, error);
	}];
}

- (NSURLSessionDataTask *)renewCustomerTokenWithID:(NSString *)customerID callback:(BUYDataTokenBlock)block
{
	if (self.customerToken) {
		NSURL *route = [self urlForCustomersTokenRenewalWithID:customerID];
		
		return [self putRequestForURL:route object:nil completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			NSString *accessToken = nil;
			if (json && !error) {
				BUYAuthenticatedResponse *authenticatedResponse = [BUYAuthenticatedResponse responseWithJSON:json];
				accessToken = authenticatedResponse.accessToken;
			}
			
			if (!error) {
				error = [self errorFromJSON:json response:response];
			}
			
			block(accessToken, error);
		}];
	}
	else {
		block(nil, [NSError errorWithDomain:BUYShopifyErrorDomain code:BUYShopifyError_InvalidCustomerToken userInfo:nil]);
		return nil;
	}
}

- (NSURLSessionDataTask *)activateCustomerWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID customerToken:(NSString *)customerToken callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *route  = [self urlForCustomersActivationWithID:customerID parameters:@{
																					@"token": customerToken,
																					}];
	
	return [self putRequestForURL:route object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSString *email = json[@"customer"][@"email"];
		if (email && !error) {
			BUYAccountCredentialItem *emailItem = [BUYAccountCredentialItem itemWithEmail:email];
			[self loginCustomerWithCredentials:[credentials credentialsByAddingItems:@[emailItem]] callback:block];
		}
		else {
			block(nil, nil, error);
		}
	}];
}

- (NSURLSessionDataTask *)resetPasswordWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID customerToken:(NSString *)customerToken callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *route  = [self urlForCustomersPasswordResetWithID:customerID parameters:@{
																					   @"token": customerToken,
																					   }];
	
	return [self putRequestForURL:route object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSString *email = json[@"customer"][@"email"];
		if (email && !error) {
			BUYAccountCredentialItem *emailItem = [BUYAccountCredentialItem itemWithEmail:email];
			[self loginCustomerWithCredentials:[credentials credentialsByAddingItems:@[emailItem]] callback:block];
		}
		else {
			block(nil, nil, error);
		}
	}];
}

- (NSURLSessionDataTask *)getOrdersForCustomerWithCallback:(BUYDataOrdersBlock)block
{
	NSURL *route = [self urlForCustomersOrders];
	return [self getRequestForURL:route completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		if (json && !error) {
			NSArray *orders = [self.modelManager ordersWithJSONDictionary:json];
			block(orders, error);
		} else {
			block(nil, error);
		}
	}];
}

@end
