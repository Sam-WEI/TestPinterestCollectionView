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
      var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
      
      for item in 0..<collectionView!.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)
        
        let width = contentWidth - cellPadding * 2
        
        let pictureHeight = delegate.collectionView(collectionView!, heightForPhotoAt: indexPath, withWidth: width)
        let annoHeight = delegate.collectionView(collectionView!, heightForAnnotationAt: indexPath, withWidth: width)
        
        let height = pictureHeight + annoHeight + cellPadding * 2
        
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        attr.frame = insetFrame
        cache.append(attr)
        
        contentHeight = max(contentHeight, frame.maxY)
        yOffset[column] += height
        
        
        column += 1
        column %= numberOfColumns
        
      }
      
    }
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttrs = [UICollectionViewLayoutAttributes]()
    
    for attr in cache {
      if rect.intersects(attr.frame) {
        layoutAttrs.append(attr)
      }
    }
    
    return layoutAttrs
  }
  
  
  
  
  
}
