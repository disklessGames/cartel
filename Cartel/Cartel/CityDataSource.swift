
import Foundation
import UIKit

extension BoardData: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return city.count
        } else {
            return pocket.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        let block = city[indexPath.row]!
        
        cell.configure(block, rotation: cardRotations[indexPath.row], isPlayable: playableLocation[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
}

extension BoardData: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = collectionView.dataSource as! BoardData
        let width = (collectionView.frame.width - CGFloat(data.width*5))/CGFloat(data.width)
        let height = CGFloat(150 * width/100)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
            cell.imageView.transform = cell.imageView.transform.rotated(by: CGFloat(Double.pi/2))
            cardRotations[indexPath.row] = cell.imageView.transform
        }
    }
}
