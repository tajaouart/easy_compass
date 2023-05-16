# EasyCompass

A Flutter package for accessing and displaying compass heading information. This package provides a
simple and convenient way to retrieve the compass heading using the device's magnetometer sensor and
display it visually.

<img src="https://raw.githubusercontent.com/tajaouart/easy_compass/master/easy_compass_demo.gif" height="600"/>

## Features

- Stream compass events with heading information

## Getting Started

To use this package, add `easy_compass` as a dependency in your `pubspec.yaml` file.

## Usage

Import the `easy_compass` package:

```dart
import 'package:easy_compass/easy_compass.dart';
```

### Stream Compass Events

Use the `EasyCompass.stream` getter to access the compass event stream. The stream
emits `CompassEvent` objects with the heading information.

```dart

Stream<CompassEvent> compassStream = EasyCompass().stream;
```

### Display Compass Heading

Subscribe to the compass event stream and update your UI to display the compass heading. For
example, you can use the `Transform.rotate` widget to rotate an image based on the heading:

```dart
StreamBuilder<CompassEvent>(
  stream: compassStream,
  builder: (context, snapshot) {
  final heading = snapshot.data?.heading ?? 0;

  return Transform.rotate(
    angle: -heading * (math.pi / 180),
    child: Image.asset('assets/compass.jpg'),
  );
},
)
```

## Additional Information

For more information about the EasyCompass package, please refer to
the [documentation](https://pub.dev/documentation/easy_compass/latest/).

## Contribution

We welcome contributions! If you find a bug or have a feature request,
please [open an issue](https://github.com/tajaouart/easy_compass/issues) on GitHub. If you would like to
contribute code, create a [pull request](https://github.com/tajaouart/easy_compass/pulls) with your
changes.

## License

This package is licensed under the [MIT License](https://opensource.org/licenses/MIT).
