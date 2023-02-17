# MyRXSWIFTModule

RXRelay - Publish relay and behaviour relay comes through this
Segue navigation prevents decoupling and de modulisaration 
Coordinator is a builder pattern type
- Protocols in RXSwift can be used to instantiate view Controller
- Driver is a property that always runs in the main thread - it will always replay the last value without error out


1. Subjects are both observers and observables 
2. Reactive Functional Programming 
3. Functional Programming 
    1. Immuntablity - Variables states cannot be changed against declarative/imperative/ object oriented  programming 
    2. Mutable state - issues around concurrency , race conditions, dead locks - something is waiting /depending on something 
    3. First class and higher order functions - A function that can take a function and return another function. e.g filter, map , reduce .
    4. Pure function - Will always produce the same output when given the same input -  the function creates zero side effects outside of it
    5. Rxswift  = Notification Center + Delegate pattern + Grand Central Dispatch + Closures in an asynchronous manner
    6. Cocoa pod - Dependency manager used to integrate external Framework  with your app
    7. Observables is also a sequence- can emit values - you can subscribe it to and get an event
    8. A tap is also an event that can be emitted from a sequence- The event will eventually finish / error out/ give up - The completed state of the observable 
    9. The whole idea of observable is that I can subscribe to it to get events
    10. For example, I can subscribe to the value of a slider control and when some moves the slider, I can get the updated value
    11. Sequence emitting values, I get them
    12. let observable3 = Observable.of([1,2,3]) // of - observable will function on the array
    13. let observable4 = Observable.from([1,2,3,4,5]) // from -observable will function on the individual elements of the array rather than the whole array
    14. Subscription makes observable useful - subscriptions are created on observables 
    15. Subscription are to  be disposed after use to prevent memory leak



Subjects 

1. They are observable as well as the observer - They get an event and push it to the subscribers 
	Publish subjects
	Behaviour Subjects
		Replay subjects
		variable (Depreciated)    
    Behaviour relay (New Form of Subjects

Weak self - a closure can be called at a point
