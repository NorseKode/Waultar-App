# Navigation

## Useful guides
The navigation is mainly done with Flutter's *Router* and *declarative* approach, with provider allowing global access to the update method in `AppState`

- Flutter dev page: https://docs.flutter.dev/development/ui/navigation
- Implementation guide used: https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade

## How to navigate

Two cases

### Page already exists
If the page already, then it is as simple as the following code

```dart
// Abstract
context.read<AppState>().updateNavigatorState(RoutePath.path());

// Concrete
context.read<AppState>().updateNavigatorState(AppRoutePath.home());
```

### The page doesn't exists
This is a bit more cumbersome. First a new route will need to be added, this is done in the **navigation/router** folder in one of the existing x_route_path.dart files, or a new one can be made.

Here a new constructor with said route name needs to be added, and for good measures also add a new isPage check getter. Here additional data needed can also be retrieved before the view is loaded.
Finally also add the new view to the enum `ViewScreen`

```dart
class AppRoutePath extends RoutePath {
  ViewScreen viewScreen;
  
  AppRoutePath.home()    : viewScreen = ViewScreen.home;
  AppRoutePath.unknown() : viewScreen = ViewScreen.unknown;
  // new one
  AppRoutePath.fancy()   : ViewScreen = ViewScreen.fancy;

  bool get isHomePage => viewScreen == ViewScreen.home;
  bool get isUnknown  => viewScreen == ViewScreen.unknown;
  // new one
  bool get isFancy    => viewScreen == ViewScreen.fancy;
}
```

Finally only the Navigator needs to be updated to include the view, which can be found in the **navigation/app_navigator.dart** file
 
```dart
Navigator getAppNavigator(RoutePath routePath, ValueChanged<RoutePath> _updateState) {
  return Navigator(
    ...
    pages: [
      if (routePath.viewScreen == ViewScreen.fancy)
        const MaterialPage(
          key: ValueKey('Fancy'),
          child: FancyView(),
        ),
    ],
    ...
  );
}
```

All should work now

## Known issues or shortcomings
- `Navigator.pop();` or any other form of go back functionality won't work
- Cannot handle URL's at all. The code is prepped for it, but it haven't been implemented yet
