# ScrollBottomNavigationBar

Hide or show bottom navigation bar while scrolling.

## Usage

### Getting started

Add `scroll_bottom_navigation_bar` package to your project. You can do this following [this steps](https://pub.dev/packages/scroll_bottom_navigation_bar#-installing-tab-).

### Basic implementation

First, you need a `ScrollBottomNavigationBarController` instance. If you need a custom `ScrollController`, you can pass the instance on constructor.

```dart
final controller = ScrollBottomNavigationBarController(); 
```

Now, you can use the `ScrollBottomNavigationBar` widget in a `Scaffold` widget, and atach `ScrollController` instance in your scrollable widget on body.

For simplify your code, you can use the `ScrollBody` widget as yout scrollable widget. This widget takes care of exchanging items from the bottom bar.

> **_NOTE:_**  Showing only essencial code. See [example](#example) section to a complete implementation.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: ScrollBody(
      scrollBottomNavigationBarController: controller,
      builder: (context, index) => container(index),
    ),
    bottomNavigationBar: ScrollBottomNavigationBar(
      scrollBottomNavigationBarController: controller,
      items: items,
    ),
  );
}
```

### Example

You can also check the [example](./example) for additional information.

## Snapshots

![snapshot](./screenshots/page_view.gif)