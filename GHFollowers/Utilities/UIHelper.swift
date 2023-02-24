import UIKit

struct UIHelper {
    
    // static sayesinde UIHelper.createThreeColumnFlowLayout yazarak bunu kullanabiliyoruz 
    static func createThreeColumnFlowLayout(view: UIView) -> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let avaliableWidth = width - (2 * padding) - (2 * minimumItemSpacing)
        let itemWidth = avaliableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
