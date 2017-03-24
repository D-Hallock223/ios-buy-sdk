//
//  ProductsViewController.swift
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
import Buy

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: StorefrontCollectionView!
    
    var graph:      Graph!
    var collection: CollectionViewModel!
    
    fileprivate let columns:  Int = 2
    fileprivate var products: PageableArray<ProductViewModel>!
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.paginationDelegate = self
        
        Graph.shared.fetchProducts(in: self.collection) { products in
            if let products = products {
                self.products = products
                self.collectionView.reloadData()
            }
        }
    }
}

// ----------------------------------
//  MARK: - PaginationDelegate -
//
extension ProductsViewController: StorefrontCollectionViewDelegate {
    
    func collectionViewShouldBeginPaging(_ collectionView: StorefrontCollectionView) -> Bool {
        return self.products?.hasNextPage ?? false
    }
    
    func collectionViewWillBeginPaging(_ collectionView: StorefrontCollectionView) {
        if let products = self.products,
            let lastProduct = products.items.last {
            
            Graph.shared.fetchProducts(in: self.collection, after: lastProduct.cursor) { products in
                if let products = products {
                    self.products.appendPage(from: products)
                    
                    self.collectionView.reloadData()
                    self.collectionView.completePaging()
                }
            }
        }
    }
    
    func collectionViewDidCompletePaging(_ collectionView: StorefrontCollectionView) {
        
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDataSource -
//
extension ProductsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.className, for: indexPath) as! ProductCell
        let product = self.products.items[indexPath.item]
        
        cell.configureFrom(product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.layer.cornerRadius  = 4.0
        cell.layer.masksToBounds = true
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout         = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing    = layout.minimumInteritemSpacing * CGFloat(self.columns - 1)
        let sectionSpacing = layout.sectionInset.left + layout.sectionInset.right
        let length         = (collectionView.bounds.width - itemSpacing - sectionSpacing) / CGFloat(self.columns)
        
        return CGSize(
            width:  length,
            height: length + 78.0
        )
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDelegate -
//
extension ProductsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.products.items[indexPath.item]
        
        let detailsController: ProductDetailsViewController = self.storyboard!.instantiateViewController()
        detailsController.product = product
        self.navigationController!.pushViewController(detailsController, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
