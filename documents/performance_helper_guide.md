# Performance Helper Guide

## Code Example
You can probably also get it from the locator

```dart
var performance = PerformanceHelper(pathToPerformanceFile: "file/path");
var isPerformanceMode = true;

toMeasure() {
    // When starting top most data point
    if (isPerformanceMode) {
        performance.init(newParentKey: "Parent key");
        performance.startReading(performance.parentKey);    
    }

    // When starting a child reading
    var key = "anotherFunction";
    if (isPerformanceMode) {
        performance.startReading(key);

    }
    anotherFunction();
    // When finishing and adding a child reading
    if (isPerformanceMode) {
        performance.addReading(performance.parentKey, key, performance.stopReading(key));
    } 

    // When finishing top most data point
    if (isPerformanceMode) {
        performance.addData(
        performance.parentKey,
        duration: performance.stopReading(performance.parentKey),
      );

      performance.summary("Tree Parser Performance Data");
    }
}

anotherFunction() {
    // Does something that takes time...
}
```