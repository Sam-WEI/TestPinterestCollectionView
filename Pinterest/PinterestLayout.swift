//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by WeiShengkun on 2/27/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit


protocol PinterestLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
  
  func collectionView(_ collectionView: UICollectionView, heightForAnnotationAt indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}


class PinterestLayout: UICollectionViewLayout {
  var delegate: PinterestLayoutDelegate!
  
  var numberOfColumns = 2
  var cellPadding: CGFloat = 6.0
  
  private var cache = [UICollectionViewLayoutAttributes]()
  
  
  private var contentHeight: CGFloat = 0.0
  private var contentWidth: CGFloat {
    let insets = collectionView!.contentInset
    return collectionView!.bounds.width - insets.left - insets.right
  }
  
  
  override func prepare() {
    if cache.isEmpty {
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      var xOffset = [CGFloat]()
      for column in 0..<numberOfColumns {
        xOffset.append(CGFloat(column) * columnWidth)
      }
      
      var column = 0
      var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
      
      
      
    }
  }
  
  
}
