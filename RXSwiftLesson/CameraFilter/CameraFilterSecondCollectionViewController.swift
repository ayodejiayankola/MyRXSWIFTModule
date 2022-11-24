//
//  CameraFilterSecondCollectionViewController.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 10/10/2022.
//

import Foundation
import UIKit
import Photos
import RxSwift

class CameraFilterSecondCollectionViewController: UICollectionViewController  {
	
	private let selectedPhotoSubject = PublishSubject<UIImage>()
	
	var selectedPhoto: Observable<UIImage> {
		return selectedPhotoSubject.asObservable()
	}
	
	private var images = [PHAsset]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		populatePhotos()
		
	}
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.images.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let selectedAsset = self.images[indexPath.row]
		PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] image, info in
			guard let info = info else {return}
			print("This is \(info)")
			
			let isDegardedImage = info["PHImageResultIsDegradedKey"] as! Bool
			
			
			if !isDegardedImage {
				if let image = image {
					self?.selectedPhotoSubject.onNext(image)
					print("This is \(image)")
					self?.dismiss(animated: true, completion: nil)
				}
			}
		}
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else  { fatalError(" PhotoCollectionViewCell not found") }
		
		let asset = self.images[indexPath.row]
		
		let manager = PHImageManager.default()
		
		manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
			DispatchQueue.main.async {
				cell.photoImageView?.image = image
			}
		}
			
		return cell
	}
	
	
	private func populatePhotos() {
		PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
			if status == .authorized {
				
				let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
				
				assets.enumerateObjects { object, count, stop in
					self?.images.append(object)
				}
				// Most recent image is always at the end
				self?.images.reverse()
				DispatchQueue.main.async {
					self?.collectionView.reloadData()
				}
			} else {
				
			}
		}
	}
	
}
