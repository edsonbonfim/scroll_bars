# ScrollBottomNavigationBar

Hide or show bottom navigation bar while scrolling.

Simple scroll | Snap behavior
:-----------: | :-----------:
<img width="497" alt="n1" src="https://user-images.githubusercontent.com/8020047/80665813-da338080-8a70-11ea-9cc7-95cf5d99b7aa.gif"> | <img width="497" alt="n2" src="https://user-images.githubusercontent.com/8020047/80665810-d9025380-8a70-11ea-84ae-609d75a24033.gif">

## Roadmap

This is currently our roadmap, **please feel free to request additions/changes**.

| Feature             | Progress |
| :------------------ | :------: |
| Simple scroll       |    ✅     |
| Snap behavior       |    ✅     |
| Pin/unpin           |    ✅     |
| FAB supported       |    ✅     |
| Snackbar supported  |    ✅     |
| Gradient background |    ✅     |

> **NOTE:** Try use this package with [scroll_app_bar](https://pub.dev/packages/scroll_app_bar) package to a [better user experience](https://github.com/EdsonOnildoJR/scroll_bars).

## Usage

### Getting started

Add `scroll_bottom_navigation_bar` package to your project. You can do this following [this steps](https://pub.dev/packages/scroll_bottom_navigation_bar#-installing-tab-).

### Basic implementation

First, you need a `ScrollController` instance.

```dart
final controller = ScrollController(); 
```

Now, you can use the `ScrollBottomNavigationBar` widget in a `Scaffold` widget, and attach `ScrollController` instance in your scrollable main widget.

> **NOTE:**  Showing only essencial code. See [example](#example) section to a complete implementation.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: ValueListenableBuilder<int>(
      valueListenable: controller.bottomNavigationBar.tabNotifier,
      builder: (context, tabIndex, child) => ListView.builder(
        controller: controller,
        itemBuilder: ...,
      ),
    ),
    bottomNavigationBar: ScrollBottomNavigationBar(
      controller: controller,
      items: ...,
    ),
  );
}
```

### Snap behavior

To enable the snap behavior, you need just wrap the main scrollable widget with a `Snap` widget and attach controller.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: ValueListenableBuilder<int>(
      valueListenable: controller.bottomNavigationBar.tabNotifier,
      builder: (context, tabIndex, child) => Snap(
        controller: controller.bottomNavigationBar,
        child: ListView.builder(
          controller: controller,
          itemBuilder: ...,
        ),
      ),
    ),
    bottomNavigationBar: ScrollBottomNavigationBar(
      controller: controller,
      items: ...,
    ),
  );
}
```

### Example

See a [complete example](./example/lib/main.dart).

## API Reference

```dart
// Returns the total height of the bar
controller.bottomNavigationBar.height;

// Notifier of the visible height factor of bar
controller.bottomNavigationBar.heightNotifier;

// Notifier of the pin state changes
controller.bottomNavigationBar.isPinned;

// Returns [true] if the bar is pinned or [false] if the bar is not pinned
controller.bottomNavigationBar.pinNotifier;

// Set a new pin state
controller.bottomNavigationBar.setPinState(state);

// Toogle the pin state
controller.bottomNavigationBar.tooglePinState();

// Notifier of the active page index
controller.bottomNavigationBar.tabNotifier;

// Register a closure to be called when the tab changes
controller.bottomNavigationBar.tabListener(listener);

// Set a new tab
controller.bottomNavigationBar.setTab(tabIndex);

// Discards resource
controller.bottomNavigationBar.dispose();
```

## Change log

Please see [CHANGELOG](./CHANGELOG.md) for more information on what has changed recently.

## Contributing

Please send feature requests and bugs at the issue tracker.

## Credits

- [Edson Onildo](https://github.com/EdsonOnildoJR)
- [All Contributors](../../contributors)

## License

BSD 3-Clause License. Please see [License File](./LICENSE) for more information.