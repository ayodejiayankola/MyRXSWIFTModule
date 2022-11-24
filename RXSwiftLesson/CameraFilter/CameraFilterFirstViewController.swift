//
//  CameraFilterFirstViewController.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 10/10/2022.
//

import Foundation
import UIKit
import RxSwift

class CameraFilterFirstViewController: UIViewController {
	
	@IBOutlet weak var applyFilterButton: UIButton?
	@IBOutlet weak var photoImage: UIImageView?
	
	let disposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.prefersLargeTitles = true
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let navVC = segue.destination as? UINavigationController,
		let photosCVC = navVC.viewControllers.first as? CameraFilterSecondCollectionViewController
		else { fatalError("Segue destination is not found") }
		
		photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
			DispatchQueue.main.async {
				self?.updateUI(with: photo)
			}
		}).disposed(by: disposeBag)
	}
	
	@IBAction func applyFilterButtonPressed() {
		guard let sourceImage = self.photoImage?.image else {
			return
		}
//		FiltersService().applyFilter(to: sourceImage) { [weak self] filteredImage in
//			DispatchQueue.main.async {
//				self?.photoImage?.image = filteredImage
//
//			}
//		}
		FiltersService().applyFilter(to: sourceImage).subscribe(onNext: {   [weak self] filteredImage in
			DispatchQueue.main.async {
				self?.photoImage?.image = filteredImage
		}
		}).disposed(by: disposeBag)
	}
	
	private func updateUI(with image: UIImage){
		self.photoImage?.image = image
		self.applyFilterButton?.isHidden = false
	}
	

}
