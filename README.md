# iOS Assignment CS

## Architecture
This assignment is being followed base on Swift Clean Architecture (VIP). Below is the overview diagram of my assignment's organized code:
![](https://hackernoon.com/hn-images/1*QV4nxWPd_sbGhoWO-X7PfQ.png)
> Refer: https://hackernoon.com/introducing-clean-swift-architecture-vip-770a639ad7bf 

Although this architecture is complicated when started that many of protocol and class are created. By hard stick with separated concern theory, it is easier to scale up when the business requirements become bigger. Each layer has their own responsiblity and it can be tested separately.

## Tech
#### 3rd library
- [Kingfisher](https://github.com/onevcat/Kingfisher) - Asynchronous image downloading and caching

Due to shorted time, I decide to use Kingfisher because it is popular and stable enough.



#### API Integration
The assignment using Combine framework by Apple to fetch data from API. It creates a data pipeline and publish notification to all subscribers when data has changed and update the UI.
The Combine framework provides a declarative Swift API for processing values over time. These values can represent many kinds of asynchronous events. Combine declares publishers to expose values that can change over time, and subscribers to receive those values from the publishers.

- The Publisher protocol declares a type that can deliver a sequence of values over time. Publishers have operators to act on the values received from upstream publishers and republish them.

- At the end of a chain of publishers, a Subscriber acts on elements as it receives them. Publishers only emit values when explicitly requested to do so by subscribers. This puts your subscriber code in control of how fast it receives events from the publishers it’s connected to.

#### Movie duration in list screen
Each time the app received movie list result. It is going to store movies in local and then fetch movie detail one by one in sequence, this is associated with API call saving from client, so the server are not overload by many concurrent requests. The detail information cache in local then notify to UI for updating.



#### Rating view
Due to Apple UIKit does not has circle progress bar. So I have to custom to draw the view by using CoreGraphic. The progress bar drawed in draw() function. Everytime the rating value is updated, refresh the view by calling setNeedDisplay() which re-draw progress view and animation.
