# shopping
iOS shopping project written in swift.

There is a mock server implemented.
To use it, you have to define MOCK as a flag.
It's defined in the 'Debug' version.



Possible improvements:
- caching of exchange rates response
- multi language support
- undo/redo action on basket
- app icon, detail text and images for products
- enable https connection only (currently there is an exception, because currency layer's free plan only supports http)
- add more error case unit test
- make currency more dynamic
- make ProductBag as a generic Bag
- add more design/style to product cell, product detail and basket views
- add search feature for product list and basket view currency list
- add fastlane to the project
- add continuous integration
- add cocoa pod if there is a 3rd party library needed
- add user management
- setup git flow
- use mock target instead of MOCK flag -> ExchangeRatesServer class can be implemented based on the target type
- dynamic product list (product infos coming form a web service)
