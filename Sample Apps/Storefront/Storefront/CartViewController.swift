//
//  CartViewController.swift
//  Storefront
//
//  Created by Shopify.
//  Copyright (c) 2017 Shopify Inc. All rights reserved.
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

import UIKit
import Pay

class CartViewController: ParallaxViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    
    private var totalsViewController: TotalsViewController!
    
    fileprivate let payController = PayController(merchantID: "greats-clone.myshopify.com")
    
    // ----------------------------------
    //  MARK: - Segue -
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier! {
        case "TotalsViewController":
            self.totalsViewController          = segue.destination as! TotalsViewController
            self.totalsViewController.delegate = self
        default:
            break
        }
    }
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureParallax()
        self.configureTableView()
        
        self.updateSubtotal()
        
        self.registerNotifications()
    }
    
    deinit {
        self.unregisterNotifications()
    }
    
    private func configureParallax() {
        self.layout       = .headerAbove
        self.headerHeight = self.view.bounds.width * 0.5 // 2:1 ratio
        self.multiplier   = 0.0
    }
    
    private func configureTableView() {
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        
        if self.traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: self.tableView)
        }
    }
    
    // ----------------------------------
    //  MARK: - Notifications -
    //
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(cartControllerItemsDidChange(_:)), name: Notification.Name.CartControllerItemsDidChange, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private dynamic func cartControllerItemsDidChange(_ notification: Notification) {
        self.updateSubtotal()
    }
    
    // ----------------------------------
    //  MARK: - Update -
    //
    func updateSubtotal() {
        self.totalsViewController.subtotal  = CartController.shared.subtotal
        self.totalsViewController.itemCount = CartController.shared.itemCount
    }
    
    // ----------------------------------
    //  MARK: - View Controllers -
    //
    func productDetailsViewControllerWith(_ product: ProductViewModel) -> ProductDetailsViewController {
        let controller: ProductDetailsViewController = self.storyboard!.instantiateViewController()
        controller.product = product
        return controller
    }
}

// ----------------------------------
//  MARK: - Actions -
//
extension CartViewController {
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// ----------------------------------
//  MARK: - TotalsControllerDelegate -
//
extension CartViewController: TotalsControllerDelegate {
    
    func totalsController(_ totalsController: TotalsViewController, didRequestPaymentWith type: PaymentType) {
        
        let cartItems = CartController.shared.items
        Graph.shared.createCheckout(with: cartItems) { checkout in
            if let checkout = checkout {
                
                let payCurrency = PayCurrency(currencyCode: "CAD", countryCode: "CA")
                let payItems    = checkout.lineItems.edges.map {
                    PayLineItem(price: $0.node.variant?.price ?? 0.0, quantity: Int($0.node.quantity))
                }
                
                let payCheckout = PayCheckout(
                    lineItems:       payItems,
                    shippingAddress: nil,
                    shippingRate:    nil,
                    discountAmount:  0.0,
                    subtotalPrice:   checkout.subtotalPrice,
                    needsShipping:   checkout.requiresShipping,
                    totalTax:        checkout.totalTax,
                    paymentDue:      checkout.paymentDue
                )
                
                self.payController.delegate = self
                self.payController.authorizePaymentUsing(payCheckout, currency: payCurrency)
                
            } else {
                print("Failed to create checkout")
            }
        }
        
    }
}

// ----------------------------------
//  MARK: - PayControllerDelegate -
//
extension CartViewController: PayControllerDelegate {
    
    func payController(_ payController: PayController, didRequestShippingRatesFor address: PayPostalAddress, provide: @escaping  (PayCheckout, [PayShippingRate]) -> Void) {
        
        let start = Date(timeIntervalSince1970: Date().timeIntervalSince1970 + 86400 * 3)
        let end   = Date(timeIntervalSince1970: Date().timeIntervalSince1970 + 86400 * 5)
        
        let shippingRates: [PayShippingRate] = [
            PayShippingRate(handle: "123", title: "FedEx Express", price: 14.00, deliveryRange: .init(from: start, to: end)),
            PayShippingRate(handle: "234", title: "UPS Regular", price: 13.00, deliveryRange: .init(from: start, to: end)),
            PayShippingRate(handle: "345", title: "Canada Post", price: 7.50, deliveryRange: .init(from: start, to: end)),
            PayShippingRate(handle: "456", title: "United States Postal Service", price: 5.00, deliveryRange: .init(from: start, to: end)),
        ]
        
        print("Getting shipping rates...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print("Fetched shipping rates.")
            provide(payController.checkout!, shippingRates)
        }
    }
    
    func payController(_ payController: PayController, didSelectShippingRate shippingRate: PayShippingRate, provide: @escaping  (PayCheckout) -> Void) {
        
        print("Selecting shipping rate...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print("Selected shipping rate.")
            provide(payController.checkout!)
        }
    }
    
    func payController(_ payController: PayController, didCompletePayment token: Data, checkout: PayCheckout, completeTransaction: @escaping (PayController.TransactionStatus) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completeTransaction(.success)
        }
    }
    
    func payControllerDidFinish(_ payController: PayController) {
        
    }
}

// ----------------------------------
//  MARK: - UIViewControllerPreviewingDelegate -
//
extension CartViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let tableView = previewingContext.sourceView as! UITableView
        if let indexPath = tableView.indexPathForRow(at: location) {
            
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
            
            let cell    = tableView.cellForRow(at: indexPath) as! CartCell
            let product = cell.viewModel!.model.product
            
            return self.productDetailsViewControllerWith(product)
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController!.show(viewControllerToCommit, sender: self)
    }
}

// ----------------------------------
//  MARK: - CartCellDelegate -
//
extension CartViewController: CartCellDelegate {
    
    func cartCell(_ cell: CartCell, didUpdateQuantity quantity: Int) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            
            let didUpdate = CartController.shared.updateQuantity(quantity, at: indexPath.row)
            if didUpdate {
                
                self.tableView.beginUpdates()
                self.tableView.reloadRows(at: [indexPath], with: .none)
                self.tableView.endUpdates()
            }
        }
    }
}

// ----------------------------------
//  MARK: - UITableViewDataSource -
//
extension CartViewController: UITableViewDataSource {
    
    // ----------------------------------
    //  MARK: - Data -
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartController.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell     = tableView.dequeueReusableCell(withIdentifier: CartCell.className, for: indexPath) as! CartCell
        let cartItem = CartController.shared.items[indexPath.row]
        
        cell.delegate = self
        cell.configureFrom(cartItem.viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            tableView.beginUpdates()
            
            CartController.shared.removeAllQuantities(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        default:
            break
        }
    }
}

// ----------------------------------
//  MARK: - UITableViewDelegate -
//
extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateParallax()
    }
}
