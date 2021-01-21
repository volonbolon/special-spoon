# special-spoon

Although the architecture could be, in principle, be perceived as a little convoluted, it is not. It is based in [Advanced iOS App Architecture](https://www.raywenderlich.com/books/advanced-ios-app-architecture/v3.0) and, by atomizing different components allow a great deal of detail, separation of concerns, and dependency injection. 

I choose to present the test in such a way for two reasons. Although the actual complexity of the proposed exercise is low, and MVC would be enough, we all know that in real-world apps, complexity is an ever-increasing magnitude. With that in mind, it pays to lay out solid foundations, even if the present requirements are not that hard to fulfill with something else. That's not to say complexity is good, it is not. Simplicity is good, but a solid foundation is required to achieve simplicity. And the cost of refactoring is always something we should take into consideration. The proposed architecture is specially tailored for refactoring. Do we need to change the view of the main view controller? No problem we can do that, without even touching the logic. 

I also choose to build the app using this particular architecture because, well, we all know MVC. It is ok, but, since you want to know me, and I want to know you, perhaps, by spicing up a few things, the conversation afterward would be more inspiring. 

Regarding technologies, I choose to go with Combine, because I decided to limit as much as possible the use of third party libraries, and combine is a great engine to have different portions of the code in sync. I also choose not to go with SwifUI because you are requesting Layout Constraints. 

The use of third party libraries is, obviously, a must. I just refrain to use them here not because I eat my own dogfood, but because, once again, I think you want to see my code. Besides, perhaps AFNetworing would make requests a little easier to use, but for this particular project, third-party libraries wouldn't make much difference.

As for the vies themselves, I am not using xibs, neither storyboards. They tend to be a mess when sc systems, and in production, I try to avoid them as much as possible.  

## Important
The only dependency is a swift package I wrote myself. It is very simple, but bear in mind you need to install packages in order to run the app.

## Protocols
I use them as much as possible. By declaring interfaces that way, is easier to replace components with mocks for tests, or new components in production.

## Structure
The codebase is roughly divided into 4 sections, each one encapsulating different functionalities. They can be easily transformed into frameworks, or even packages to speed up compile time. It is also easier to swap them for different platforms. We can, for instance, replace the iOS module with one for the watch, and because we are only exposing protocols, the core module doesn't need to be touched at all. 

* SpecialSpoon: Main section of the app. Here we have the delegates (Scene and App Delegate). From here we can boot third-party engines. 
* SpecialSpoon_iOS: Here we have all iOS-related code. This is the module that knows how to deal with a UIViewController, iOS way
* SpecialSpoonUIKit: Abstraction over UIKit. We are a little bit further than iOS, but still in UIKit.
* SpecialSpoonKit: Core functionality. Completely agnostic about the platform (works on top of Foundation). 
