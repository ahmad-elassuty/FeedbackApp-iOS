# FeedbackApp-iOS

## Features

**Colleagues List:**

- [x] Show list of colleagues
- [x] Give specific colleague a feedback

**Colleague Profile:**

- [x] Show selected colleague profile (name, profile image)
- [x] List all interactions if any

## Screenshots
[![](https://s10.postimg.org/krf8ykjyx/Simulator_Screen_Shot_-_i_Phone_X_-_2018-02-05_at_01.05.00.png)](https://postimg.org/image/ob16odmol/)
[![](https://s10.postimg.org/3qwcqe72x/Simulator_Screen_Shot_-_i_Phone_X_-_2018-02-05_at_01.05.08.png)](https://postimg.org/image/p0jz18ndh/)
[![](https://s10.postimg.org/b6vmc72i1/Simulator_Screen_Shot_-_i_Phone_X_-_2018-02-05_at_01.06.17.png)](https://postimg.org/image/y8c7hy25h/)
[![](https://s10.postimg.org/4t6j8y5bt/Simulator_Screen_Shot_-_i_Phone_X_-_2018-02-05_at_01.06.47.png)](https://postimg.org/image/6883xo6et/)


## Requirements

- iOS 9.0+
- Xcode 9.1+

## Dependency Manager (CocoaPods)
FeedbackApp uses CocoaPods as a dependency manager and dependecies are not uploaded to github so to install dependencies run `pod install`


Pod           | Usage
:---------------: | -------------
[**Marshal**](https://github.com/utahiosmac/Marshal)  | Mapping JSON data to the application models.
[**Kingfisher**](https://github.com/onevcat/Kingfisher)   | Loading and caching images.
[**Quick**](https://github.com/Quick/Quick) | Behavior-driven development framework for testing
[**Nimble**](https://github.com/Quick/Nimble)  | A Matcher Framework

## Architecture (VIP + Clean Architecture)

The app is splitted into 3 main targets to force modularization and clean architecture rules.

### FeedbackAppDomain:

This target represents the application domain and contains the implementation of the system main models.

Name            | Usage
:---------------:   | -------------
User       | Represents system user entity
Feedback   | Represents system feedback entity

It also defines the system use cases in an abstract way. Currently, we have three use cases:

- Fetch colleagues
- Give a specific colleague feedback
- Fetch colleague data


### FeedbackAppFileStore:

This represents the platform layer, which includes concrete implementation of the previous use cases.

**Fetch colleagues:**

>It loads data from `.json` file included in the target.

**Give a specific colleague feedback:**

>Currently it doesn't persist changes to the file.

**Fetch colleague data:**

>It relies on the implementation of fetch colleagues use case, in order to query the data.

### FeedbackApp:

The application layer is structured by `VIP Architecture`. It has three main components:

**View**

>It has two rules:

>- Presenting the data on the screen
>- Delivering user interactions to the interactor

**Interactor:**

>It is responsible for performing the business logic by using helper objects called `Workers` instead of handling everything in the interactor.

>Workers are shared accross the application and know how to interact with the platform layer to fetch or persist data. Hence, if multiple screens implements the same use case, we can just **reuse** these workers.

>Upon worker results, the interactor creates `response` object and pass it to the presenter.


**Presenter:**

>It is responsible for the presentation logic. Anything that is related to data formatting and restructuring is done in the presenter before passing the data to the view to display it.


Communication between scenes is handled by `routers` which is responsible for routing and injecting the data to the destination scene.

There are also `configurators` which are responsible for building, injecting dependencies and configuring application scenes.


## Improvements

- Add `Realm` as another **platform** to persist the data.
- Increase test coverage. Current: `90% coverage`

---

#### Notes and Assumptions:
- Giving feedback doesn't persist the data, hence show colleague profile scene depends only on the data injected to it by colleagues list router.
- I didn't make any assumptions about the order of the given data.
