# special-spoon

Although the architecture could be, in principle, be perceived as a little convoluted, it is not. It is based in [Advanced iOS App Architecture](https://www.raywenderlich.com/books/advanced-ios-app-architecture/v3.0) and, by atomizing different components allow a great deal of detail, separation of concerns, and dependency injection. 

I choose to present the test in such a way for two reasons. Although the actual complexity of the proposed exercise is low, and MVC would be enough, we all know that in real-world apps, complexity is an ever-increasing magnitude. With that in mind, it pays to lay out solid foundations, even if the present requirements are not that hard to fulfill with something else. That's not to say complexity is good, it is not. Simplicity is good, but a solid foundation is required to achieve simplicity. And the cost of refactoring is always something we should take into consideration. The proposed architecture is specially tailored for refactoring. Do we need to change the view of the main view controller? No problem we can do that, without even touching the logic. 

I also choose to build the app using this particular architecture because, well, we all know MVC. It is ok, but, since you want to know me, and I want to know you, perhaps, by spicing up a few things, the conversation afterward would be more inspiring. 
