fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios test_frameworks
```
fastlane ios test_frameworks
```
Run tests on all frameworks
### ios test_unit
```
fastlane ios test_unit
```
Run unit tests on TimeTracker project
### ios test_ui
```
fastlane ios test_ui
```
Run UI tests on TimeTracker project
### ios test
```
fastlane ios test
```
Run all tests
### ios beta
```
fastlane ios beta
```
Create beta test version

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
