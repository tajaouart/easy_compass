/*
 * Copyright (C) 2023 Tajaouart
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Contact: tajaouart.com
 */

import 'dart:async';
import 'dart:math' as math;
import 'package:sensors_plus/sensors_plus.dart';
import 'compass_event.dart';

/// A Flutter package for accessing and displaying compass heading information.
/// This package provides a simple and convenient way to retrieve the compass
/// heading using the device's magnetometer sensor and display it visually.
/// It includes a `EasyCompass` class that streams the compass events and a
/// `CompassEvent` class that represents the compass heading value.
class EasyCompass {
  Stream<CompassEvent> get stream {
    return getSensorStream()
        .map((event) => calculateHeading(event))
        .map((event) => CompassEvent(heading: event.round()))
        .distinct()
        .asBroadcastStream();
  }

  Stream<MagnetometerEvent> getSensorStream() {
    final sensors = Sensors();
    return sensors.magnetometerEvents;
  }

  double calculateHeading(MagnetometerEvent event) {
    final radians = math.atan2(event.y, event.x);

    // Calculate the angle offset to align the zero angle with north
    const angleOffset = math.pi / 2;

    // Convert the angle from radians to degrees and apply the offset
    var heading = (radians - angleOffset) * 180 / math.pi;

    // Normalize the heading to the range [0, 360]
    heading = (heading + 360) % 360;

    return heading;
  }
}
