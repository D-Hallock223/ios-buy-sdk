//
//  StorefrontCollectionView.swift
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

protocol StorefrontCollectionViewDelegate: class {
    func collectionViewWillBeginPaging(_ collectionView: StorefrontCollectionView)
    func collectionViewDidCompletePaging(_ collectionView: StorefrontCollectionView)
}

class StorefrontCollectionView: UICollectionView, Paginating {
    
    @IBInspectable private dynamic var cellNibName: String?
    
    weak var paginationDelegate: StorefrontCollectionViewDelegate?
    
    var paginationThreshold: CGFloat             = 500.0
    var paginationState:     PaginationState     = .ready
    var paginationDirection: PaginationDirection = .verical
    
    // ----------------------------------
    //  MARK: - Awake -
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let className = self.value(forKey: "cellNibName") as? String {
            self.register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
        }
    }
    
    // ----------------------------------
    //  MARK: - Layout -
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.trackPaging()
    }
    
    func willBeginPaging() {
        self.paginationDelegate?.collectionViewWillBeginPaging(self)
    }
    
    func didCompletePaging() {
        self.paginationDelegate?.collectionViewDidCompletePaging(self)
    }
}
