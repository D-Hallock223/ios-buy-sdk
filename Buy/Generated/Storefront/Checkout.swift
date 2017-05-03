// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Checkout

		@discardableResult
		open func appliedGiftCards(aliasSuffix: String? = nil, _ subfields: (AppliedGiftCardQuery) -> Void) -> CheckoutQuery {
			let subquery = AppliedGiftCardQuery()
			subfields(subquery)

			addField(field: "appliedGiftCards", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func availableShippingRates(aliasSuffix: String? = nil, _ subfields: (AvailableShippingRatesQuery) -> Void) -> CheckoutQuery {
			let subquery = AvailableShippingRatesQuery()
			subfields(subquery)

			addField(field: "availableShippingRates", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func completedAt(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "completedAt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func createdAt(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "createdAt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func currencyCode(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "currencyCode", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func customAttributes(aliasSuffix: String? = nil, _ subfields: (AttributeQuery) -> Void) -> CheckoutQuery {
			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "customAttributes", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func customer(aliasSuffix: String? = nil, _ subfields: (CustomerQuery) -> Void) -> CheckoutQuery {
			let subquery = CustomerQuery()
			subfields(subquery)

			addField(field: "customer", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func email(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "email", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func lineItems(aliasSuffix: String? = nil, first: Int32, after: String? = nil, reverse: Bool? = nil, _ subfields: (CheckoutLineItemConnectionQuery) -> Void) -> CheckoutQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CheckoutLineItemConnectionQuery()
			subfields(subquery)

			addField(field: "lineItems", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func note(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "note", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func order(aliasSuffix: String? = nil, _ subfields: (OrderQuery) -> Void) -> CheckoutQuery {
			let subquery = OrderQuery()
			subfields(subquery)

			addField(field: "order", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func orderStatusUrl(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "orderStatusUrl", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func paymentDue(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "paymentDue", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func ready(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "ready", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func requiresShipping(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "requiresShipping", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func shippingAddress(aliasSuffix: String? = nil, _ subfields: (MailingAddressQuery) -> Void) -> CheckoutQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)

			addField(field: "shippingAddress", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func shippingLine(aliasSuffix: String? = nil, _ subfields: (ShippingRateQuery) -> Void) -> CheckoutQuery {
			let subquery = ShippingRateQuery()
			subfields(subquery)

			addField(field: "shippingLine", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func subtotalPrice(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "subtotalPrice", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func taxExempt(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "taxExempt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func taxesIncluded(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "taxesIncluded", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func totalPrice(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "totalPrice", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func totalTax(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "totalTax", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func updatedAt(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "updatedAt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func vaultUrl(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "vaultUrl", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func webUrl(aliasSuffix: String? = nil) -> CheckoutQuery {
			addField(field: "webUrl", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class Checkout: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = CheckoutQuery

		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "appliedGiftCards":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try AppliedGiftCard(fields: $0) }

				case "availableShippingRates":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try AvailableShippingRates(fields: value)

				case "completedAt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "currencyCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "customAttributes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try Attribute(fields: $0) }

				case "customer":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Customer(fields: value)

				case "email":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lineItems":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutLineItemConnection(fields: value)

				case "note":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "order":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Order(fields: value)

				case "orderStatusUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "paymentDue":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "ready":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "requiresShipping":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "shippingAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try MailingAddress(fields: value)

				case "shippingLine":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ShippingRate(fields: value)

				case "subtotalPrice":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "taxExempt":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "taxesIncluded":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "totalPrice":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "totalTax":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "vaultUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "webUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "Checkout" }

		open var appliedGiftCards: [Storefront.AppliedGiftCard] {
			return internalGetAppliedGiftCards()
		}

		func internalGetAppliedGiftCards(aliasSuffix: String? = nil) -> [Storefront.AppliedGiftCard] {
			return field(field: "appliedGiftCards", aliasSuffix: aliasSuffix) as! [Storefront.AppliedGiftCard]
		}

		open var availableShippingRates: Storefront.AvailableShippingRates? {
			return internalGetAvailableShippingRates()
		}

		func internalGetAvailableShippingRates(aliasSuffix: String? = nil) -> Storefront.AvailableShippingRates? {
			return field(field: "availableShippingRates", aliasSuffix: aliasSuffix) as! Storefront.AvailableShippingRates?
		}

		open var completedAt: Date? {
			return internalGetCompletedAt()
		}

		func internalGetCompletedAt(aliasSuffix: String? = nil) -> Date? {
			return field(field: "completedAt", aliasSuffix: aliasSuffix) as! Date?
		}

		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: aliasSuffix) as! Date
		}

		open var currencyCode: Storefront.CurrencyCode {
			return internalGetCurrencyCode()
		}

		func internalGetCurrencyCode(aliasSuffix: String? = nil) -> Storefront.CurrencyCode {
			return field(field: "currencyCode", aliasSuffix: aliasSuffix) as! Storefront.CurrencyCode
		}

		open var customAttributes: [Storefront.Attribute] {
			return internalGetCustomAttributes()
		}

		func internalGetCustomAttributes(aliasSuffix: String? = nil) -> [Storefront.Attribute] {
			return field(field: "customAttributes", aliasSuffix: aliasSuffix) as! [Storefront.Attribute]
		}

		open var customer: Storefront.Customer? {
			return internalGetCustomer()
		}

		func internalGetCustomer(aliasSuffix: String? = nil) -> Storefront.Customer? {
			return field(field: "customer", aliasSuffix: aliasSuffix) as! Storefront.Customer?
		}

		open var email: String? {
			return internalGetEmail()
		}

		func internalGetEmail(aliasSuffix: String? = nil) -> String? {
			return field(field: "email", aliasSuffix: aliasSuffix) as! String?
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var lineItems: Storefront.CheckoutLineItemConnection {
			return internalGetLineItems()
		}

		open func aliasedLineItems(aliasSuffix: String) -> Storefront.CheckoutLineItemConnection {
			return internalGetLineItems(aliasSuffix: aliasSuffix)
		}

		func internalGetLineItems(aliasSuffix: String? = nil) -> Storefront.CheckoutLineItemConnection {
			return field(field: "lineItems", aliasSuffix: aliasSuffix) as! Storefront.CheckoutLineItemConnection
		}

		open var note: String? {
			return internalGetNote()
		}

		func internalGetNote(aliasSuffix: String? = nil) -> String? {
			return field(field: "note", aliasSuffix: aliasSuffix) as! String?
		}

		open var order: Storefront.Order? {
			return internalGetOrder()
		}

		func internalGetOrder(aliasSuffix: String? = nil) -> Storefront.Order? {
			return field(field: "order", aliasSuffix: aliasSuffix) as! Storefront.Order?
		}

		open var orderStatusUrl: URL? {
			return internalGetOrderStatusUrl()
		}

		func internalGetOrderStatusUrl(aliasSuffix: String? = nil) -> URL? {
			return field(field: "orderStatusUrl", aliasSuffix: aliasSuffix) as! URL?
		}

		open var paymentDue: Decimal {
			return internalGetPaymentDue()
		}

		func internalGetPaymentDue(aliasSuffix: String? = nil) -> Decimal {
			return field(field: "paymentDue", aliasSuffix: aliasSuffix) as! Decimal
		}

		open var ready: Bool {
			return internalGetReady()
		}

		func internalGetReady(aliasSuffix: String? = nil) -> Bool {
			return field(field: "ready", aliasSuffix: aliasSuffix) as! Bool
		}

		open var requiresShipping: Bool {
			return internalGetRequiresShipping()
		}

		func internalGetRequiresShipping(aliasSuffix: String? = nil) -> Bool {
			return field(field: "requiresShipping", aliasSuffix: aliasSuffix) as! Bool
		}

		open var shippingAddress: Storefront.MailingAddress? {
			return internalGetShippingAddress()
		}

		func internalGetShippingAddress(aliasSuffix: String? = nil) -> Storefront.MailingAddress? {
			return field(field: "shippingAddress", aliasSuffix: aliasSuffix) as! Storefront.MailingAddress?
		}

		open var shippingLine: Storefront.ShippingRate? {
			return internalGetShippingLine()
		}

		func internalGetShippingLine(aliasSuffix: String? = nil) -> Storefront.ShippingRate? {
			return field(field: "shippingLine", aliasSuffix: aliasSuffix) as! Storefront.ShippingRate?
		}

		open var subtotalPrice: Decimal {
			return internalGetSubtotalPrice()
		}

		func internalGetSubtotalPrice(aliasSuffix: String? = nil) -> Decimal {
			return field(field: "subtotalPrice", aliasSuffix: aliasSuffix) as! Decimal
		}

		open var taxExempt: Bool {
			return internalGetTaxExempt()
		}

		func internalGetTaxExempt(aliasSuffix: String? = nil) -> Bool {
			return field(field: "taxExempt", aliasSuffix: aliasSuffix) as! Bool
		}

		open var taxesIncluded: Bool {
			return internalGetTaxesIncluded()
		}

		func internalGetTaxesIncluded(aliasSuffix: String? = nil) -> Bool {
			return field(field: "taxesIncluded", aliasSuffix: aliasSuffix) as! Bool
		}

		open var totalPrice: Decimal {
			return internalGetTotalPrice()
		}

		func internalGetTotalPrice(aliasSuffix: String? = nil) -> Decimal {
			return field(field: "totalPrice", aliasSuffix: aliasSuffix) as! Decimal
		}

		open var totalTax: Decimal {
			return internalGetTotalTax()
		}

		func internalGetTotalTax(aliasSuffix: String? = nil) -> Decimal {
			return field(field: "totalTax", aliasSuffix: aliasSuffix) as! Decimal
		}

		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: aliasSuffix) as! Date
		}

		open var vaultUrl: URL {
			return internalGetVaultUrl()
		}

		func internalGetVaultUrl(aliasSuffix: String? = nil) -> URL {
			return field(field: "vaultUrl", aliasSuffix: aliasSuffix) as! URL
		}

		open var webUrl: URL {
			return internalGetWebUrl()
		}

		func internalGetWebUrl(aliasSuffix: String? = nil) -> URL {
			return field(field: "webUrl", aliasSuffix: aliasSuffix) as! URL
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "appliedGiftCards":

				return .ObjectList

				case "availableShippingRates":

				return .Object

				case "completedAt":

				return .Scalar

				case "createdAt":

				return .Scalar

				case "currencyCode":

				return .Scalar

				case "customAttributes":

				return .ObjectList

				case "customer":

				return .Object

				case "email":

				return .Scalar

				case "id":

				return .Scalar

				case "lineItems":

				return .Object

				case "note":

				return .Scalar

				case "order":

				return .Object

				case "orderStatusUrl":

				return .Scalar

				case "paymentDue":

				return .Scalar

				case "ready":

				return .Scalar

				case "requiresShipping":

				return .Scalar

				case "shippingAddress":

				return .Object

				case "shippingLine":

				return .Object

				case "subtotalPrice":

				return .Scalar

				case "taxExempt":

				return .Scalar

				case "taxesIncluded":

				return .Scalar

				case "totalPrice":

				return .Scalar

				case "totalTax":

				return .Scalar

				case "updatedAt":

				return .Scalar

				case "vaultUrl":

				return .Scalar

				case "webUrl":

				return .Scalar

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "availableShippingRates":
				return internalGetAvailableShippingRates()

				case "customer":
				return internalGetCustomer()

				case "lineItems":
				return internalGetLineItems()

				case "order":
				return internalGetOrder()

				case "shippingAddress":
				return internalGetShippingAddress()

				case "shippingLine":
				return internalGetShippingLine()

				default:
				break
			}
			return nil
		}

		override open func fetchChildObjectList(key: String) -> [GraphQL.AbstractResponse] {
			switch(key) {
				case "appliedGiftCards":
				return internalGetAppliedGiftCards()

				case "customAttributes":
				return internalGetCustomAttributes()

				default:
				return []
			}
		}

		open func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach({
				key in
				switch(key) {
					case "appliedGiftCards":
					internalGetAppliedGiftCards().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "availableShippingRates":
					if let value = internalGetAvailableShippingRates() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customAttributes":
					internalGetCustomAttributes().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "customer":
					if let value = internalGetCustomer() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "lineItems":
					response.append(internalGetLineItems())
					response.append(contentsOf: internalGetLineItems().childResponseObjectMap())

					case "order":
					if let value = internalGetOrder() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shippingAddress":
					if let value = internalGetShippingAddress() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shippingLine":
					if let value = internalGetShippingLine() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					default:
					break
				}
			})
			return response
		}

		open func responseObject() -> GraphQL.AbstractResponse {
			return self as GraphQL.AbstractResponse
		}
	}
}
