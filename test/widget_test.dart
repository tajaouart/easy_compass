import 'package:flutter_test/flutter_test.dart';
import 'package:easy_compass/easy_compass.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MockEasyCompass extends EasyCompass {
  @override
  Stream<MagnetometerEvent> getSensorStream() {
    return Stream.fromIterable([
      MockMagnetometerEvent(x: 1, y: 2, z: 0),
      MockMagnetometerEvent(x: 3, y: 4, z: 0),
      MockMagnetometerEvent(x: 5, y: 6, z: 0),
      MockMagnetometerEvent(x: 7, y: 8, z: 0),
      MockMagnetometerEvent(x: 9, y: 10, z: 0),
    ]);
  }
}

class MockMagnetometerEvent extends MagnetometerEvent {
  MockMagnetometerEvent({
    required double x,
    required double y,
    required double z,
  }) : super(x, y, z);
}

void main() {
  group('EasyCompass', () {
    late EasyCompass easyCompass = MockEasyCompass();

    test('stream emits correct compass heading values', () async {
      final expectedHeadings = [333, 323, 320, 319, 318];
      final receivedHeadings = <int>[];

      final subscription = easyCompass.stream.listen((event) {
        receivedHeadings.add(event.heading);
      });

      // Await the completion of the subscription
      await subscription.asFuture();
      expect(receivedHeadings, equals(expectedHeadings));
    });
  });
}
