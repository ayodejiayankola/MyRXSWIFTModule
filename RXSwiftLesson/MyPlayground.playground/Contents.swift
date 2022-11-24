import UIKit
import RxSwift
import RxCocoa

var greeting = "Hello, playground"

// Transforming Operators - Allows us to change the observable data  to a new sequence
// e.g from A webservice to a tableview

//MARK: - TOArray - Converts a sequence to an Array

let disposeBag = DisposeBag()

//Observable.of(1,2,3)
//	.toArray().subscribe(onNext: {
//		print($0) // [1,2,3]
//	}
//	).disposed(by: disposeBag)
//
//
//
//// MAP
//
//Observable.of(1,2,3).map {
//	return $0 * 2
//
//}.subscribe(onNext: {
//	print($0) // [2, 4, 6]
// }
// ).disposed(by: disposeBag)


// FlatMap - flattens values of an observable down to a traget observable - changes internal observables, flattens it and returns an observable


struct Student {
	var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 90))
let tosin = Student(score: BehaviorRelay(value: 100))



let student = PublishSubject<Student>()
student.asObserver().flatMap{$0.score.asObservable()}
	.subscribe(onNext: {
		print($0)
	}).disposed(by: disposeBag)





student.onNext(john) //90

// Subscription is fired everytime value changes
john.score.accept(190) //190


student.onNext(tosin) // 100
tosin.score.accept(200) // 200

john.score.accept(10) //10









// Flatmap latest // observables latest observables not the history of the observable

student.asObservable().flatMapLatest{$0.score.asObservable()}
	.subscribe(onNext: {
		print($0)
	}).disposed(by: disposeBag)


john.score.accept(190) //190


student.onNext(tosin) // 100
tosin.score.accept(200) // 200

john.score.accept(10) // nil


// MARK: -- COMBINING OPERATORS

//  MARK: - StartWith

let number  = Observable.of(5, 6, 8)

let numberTwo  = Observable.of(1, 2, 3)

//  MARK: - Concat

//let observ = number.startWith(3)
let observ = Observable.concat([number, numberTwo])

observ.subscribe(onNext: {
	print($0) // 3, 5, 6, 8
}).disposed(by: disposeBag)



//  MARK: - Merge
//
//let left = PublishSubject<Int>()
//let right = PublishSubject<Int>()
//
//let source = Observable.of(left.asObservable(), right.asObservable())
//
//let observableMerge = source.merge()
//
//observableMerge.subscribe (onNext: {
//	print($0) // 1, 8, 5, 9
//}).disposed(by: disposeBag)
//
//left.onNext(1)
//left.onNext(8)
//right.onNext(5)
//left.onNext(9)
//// Result


//  MARK: - Combine Latest - You always get the latest value from the left and right sequence


let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let source = Observable.of(left.asObservable(), right.asObservable())

let observableMerge = Observable.combineLatest(left, right) { lastLeft, lastRight in
	"\(lastLeft) \(lastRight)"
}

observableMerge.subscribe (onNext: { value in
	print(value) //
//	1, 5
//	8, 5
//	9, 5
}).disposed(by: disposeBag)

left.onNext(1)
left.onNext(8)
right.onNext(5)
left.onNext(9)
// Result


// MARK: - WithLastestFrom - Allows you to get the latest value from a sequence

let button = PublishSubject<Void>()
let textField = PublishSubject<String>()

let observableWithLastestFrom = button.withLatestFrom(textField)
let disposabel = observableWithLastestFrom.subscribe(onNext: {
		print($0) // swift swift
}

)

textField.onNext("Sw")
textField.onNext("Swi")
textField.onNext("Swift")

button.onNext(())
button.onNext(())

// MARK: - Reduce - makes a sequence a single value as an output

let sourceTwo = Observable.of(1,2,3)


sourceTwo.reduce(0, accumulator: +)
	.subscribe(onNext: {
		print($0) // 6
	}).disposed(by: disposeBag)

// Preferred
sourceTwo.reduce(0, accumulator: { summary, newValue in
	return summary + newValue
}).subscribe(onNext: {
			print($0) // 6
}).disposed(by: disposeBag)

// MARK: - Scan - allow you to scan through sequence based on the condition of the body of the scan u providing


let sourceThree = Observable.of(1,2,3)


sourceThree.scan(0, accumulator: +)
	.subscribe(onNext: {
		print($0) // 1, 3, 6
	}).disposed(by: disposeBag)

// Preferred
sourceTwo.scan(0)  { summary, newValue in
	return summary + newValue
}.subscribe(onNext: {
			print($0) //  1, 3, 6
}).disposed(by: disposeBag)
