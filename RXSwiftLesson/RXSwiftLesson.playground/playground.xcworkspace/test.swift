//
//  SendMoneyRootPresenter.swift
//  GoMoney
//

import UIKit
import RxSwift
import RxCocoa

protocol SendMoneyRootPresenter:  LoadablePresenter, ErrorThrowablePresenter {
	var balanceService: BalanceFetchableService { get }
	var isTransactionPinSet: Bool { get set }
	var skipOnboarding: Bool { get set }
	
	var money: BehaviorRelay<Money?> { get }
	var message: BehaviorRelay<String?> { get }
	var gifURL: BehaviorRelay<String?> { get }
	var isNextEnabled: BehaviorRelay<Bool> { get }
	var paymentLinkResponse: BehaviorRelay<PaymentLinkResponse?> { get }
	
	func createRequestLink()
}

final class DefaultSendMoneyRootPresenter: SendMoneyRootPresenter, DisposableContainer {
	var disposable: Disposable?
	
	var money: BehaviorRelay<Money?>
	
	var message: BehaviorRelay<String?>
	
	var gifURL: BehaviorRelay<String?>
	
	var isNextEnabled: BehaviorRelay<Bool>
	
	var isLoading: BehaviorRelay<Bool>
	
	var error: PublishSubject<Error>
	
	var disposeBag: DisposeBag
	
	var paymentLinkResponse = BehaviorRelay<PaymentLinkResponse?>(value: nil)
	
	
	var isTransactionPinSet: Bool {
		get {
			return self.userLocalRepository.getCurrent()?.transactionPin ?? false
		}
		set {
			self.userLocalRepository.updateTransactionPin(newValue)
		}
	}
	
	var skipOnboarding: Bool {
		get {
			return self.preferencesManager[.sendMoneySkipOnboarding] ?? false
		}
		set {
			self.preferencesManager[.sendMoneySkipOnboarding] = newValue
		}
	}
	
	let balanceService: BalanceFetchableService
	
	private let userLocalRepository: UserLocalRepository
	
	private let preferencesManager: PreferencesManager
	
	private let paymentRemoteRepository: PaymentsRemoteRepository
	
	init(
		balanceService: BalanceFetchableService,
		userLocalRepository: UserLocalRepository,
		preferencesManager: PreferencesManager,
		paymentRemoteRepository: PaymentsRemoteRepository
	) {
		self.balanceService = balanceService
		self.userLocalRepository = userLocalRepository
		self.preferencesManager = preferencesManager
		self.paymentRemoteRepository = paymentRemoteRepository
	}
	
	
	
	func createRequestLink() {
		guard let money = money.value, let message = message.value else { return }
		let data = RequestMoneyWithLinkParameters(amount: money, message: message, imageUrl: gifURL.value)
		let observable = paymentRemoteRepository.requestMoneyLink(with: data).map { response in
			self.paymentLinkResponse.accept(response.data)
		}
		
		runObservable(observable: observable)
	}
}
