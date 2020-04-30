# ScrollAppBar

Hide or show app bar while scrolling. This package works without custom scroll views and slivers. So, you can use this widget in a scaffold widget, that turns your code more simple.

Simple scroll | Snap behavior
:-----------: | :-----------:
<img width="497" alt="n1" src="https://user-images.githubusercontent.com/8020047/80651941-3f757a80-8a4d-11ea-973e-c623423d0fad.gif"> | <img width="497" alt="n2" src="https://user-images.githubusercontent.com/8020047/80651979-5ddb7600-8a4d-11ea-87ef-b18ee534a574.gif">

## Roadmap

This is currently our roadmap, **please feel free to request additions/changes**.

| Feature             | Progress |
| :------------------ | :------: |
| Simple scroll       |    ✅     |
| Snap behavior       |    ✅     |
| Pin/unpin           |    ✅     |
| Gradient background |    ✅     |

> **NOTE:** Try use this package with [scroll_bottom_navigation_bar](https://pub.dev/packages/scroll_bottom_navigation_bar) package to a better user experience. [See an example](https://github.com/EdsonOnildoJR/scroll_bars).

## Usage

### Getting started

Add `scroll_app_bar` package to your project. You can do this following [this steps](https://pub.dev/packages/scroll_app_bar#-installing-tab-).

### Basic implementation

First, you need a `ScrollController` instance.

```dart
final controller = ScrollController(); 
```

Now, you can use the `ScrollAppBar` widget in a `Scaffold` widget, and attach `ScrollController` instance in your scrollable main widget.

> **_NOTE:_**  Showing only essencial code. See [example](#example) section to a complete implementation.

```dart
@override
Widget build(BuildContext context) {
  Scaffold(
    appBar: ScrollAppBar(
      controller: controller,
      title: Text("App Bar"),
    ),
    body: ListView.builder(
      controller: controller,
      itemBuilder: ...,
    ),
  );
}
```

### Snap behavior

To enable the snap behavior, you need just wrap the main scrollable widget with a `Snap` widget and attach controller.

```dart
@override
Widget build(BuildContext context) {
  Scaffold(
    appBar: ScrollAppBar(
      controller: controller,
      title: Text("App Bar"),
    ),
    body: Snap(
      controller: controller.appBar,
      child: ListView.builder(
        controller: controller,
        itemBuilder: ...,
      ),
    ),
  );
}
```

### Example

See a [complete example](./example/lib/main.dart).

## API Reference

```dart
// Returns the total height of the bar
controller.appBar.height;

// Notifier of the visible height factor of bar
controller.appBar.heightNotifier;

// Notifier of the pin state changes
controller.appBar.isPinned;

// Returns [true] if the bar is pinned or [false] if the bar is not pinned
controller.appBar.pinNotifier;

// Set a new pin state
controller.appBar.setPinState(state);

// Toogle the pin state
controller.appBar.tooglePinState();

// Discards resource
controller.appBar.dispose();
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