# ios-observe-list-threaded
Observe a list in multithreaded mode, the change happens in a background thread

# What it demonstrate
- It is an Objective-C application
- Usage of Grand Central Dispatch
- Simple MVVM structure (not clean code because ViewModel interacts directly with datasource, this makes the code hard to edit, because each object must have only a single responsibility because if more than two classes do the same thing but in different ways, you can easily switch between them in a particular line of code)
- Key-Value Observation

# Use
- Can be easily edited and used in real-time applications
- Must be extended (BaseDatasource is made parameterized for this reason, real applications should use something other than NSString)

# TODO
- Clean the architecture, distribute responsibilities to classes as one responsibility for each class.
- Swiftify manually
