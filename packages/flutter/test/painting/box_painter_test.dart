// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/painting.dart';

void main() {
  test('BorderSide control test', () {
    final BorderSide side1 = const BorderSide();
    final BorderSide side2 = side1.copyWith(
      color: const Color(0xFF00FFFF),
      width: 2.0,
      style: BorderStyle.solid,
    );

    expect(side1, hasOneLineDescription);
    expect(side1.hashCode, isNot(equals(side2.hashCode)));

    expect(side2.color, equals(const Color(0xFF00FFFF)));
    expect(side2.width, equals(2.0));
    expect(side2.style, equals(BorderStyle.solid));

    expect(BorderSide.lerp(side1, side2, 0.0), equals(side1));
    expect(BorderSide.lerp(side1, side2, 1.0), equals(side2));
    expect(BorderSide.lerp(side1, side2, 0.5), equals(new BorderSide(
      color: Color.lerp(const Color(0xFF000000), const Color(0xFF00FFFF), 0.5),
      width: 1.5,
      style: BorderStyle.solid,
    )));

    final BorderSide side3 = side2.copyWith(style: BorderStyle.none);
    BorderSide interpolated = BorderSide.lerp(side2, side3, 0.2);
    expect(interpolated.style, equals(BorderStyle.solid));
    expect(interpolated.color, equals(side2.color.withOpacity(0.8)));

    interpolated = BorderSide.lerp(side3, side2, 0.2);
    expect(interpolated.style, equals(BorderStyle.solid));
    expect(interpolated.color, equals(side2.color.withOpacity(0.2)));
  });

  test('Border control test', () {
    final Border border1 = new Border.all(width: 4.0);
    final Border border2 = Border.lerp(null, border1, 0.25);
    final Border border3 = Border.lerp(border1, null, 0.25);

    expect(border1, hasOneLineDescription);
    expect(border1.hashCode, isNot(equals(border2.hashCode)));

    expect(border2.top.width, equals(1.0));
    expect(border3.bottom.width, equals(3.0));

    final Border border4 = Border.lerp(border2, border3, 0.5);
    expect(border4.left.width, equals(2.0));
  });

  test('BoxShadow control test', () {
    final BoxShadow shadow1 = const BoxShadow(blurRadius: 4.0);
    final BoxShadow shadow2 = BoxShadow.lerp(null, shadow1, 0.25);
    final BoxShadow shadow3 = BoxShadow.lerp(shadow1, null, 0.25);

    expect(shadow1, hasOneLineDescription);
    expect(shadow1.hashCode, isNot(equals(shadow2.hashCode)));
    expect(shadow1, equals(const BoxShadow(blurRadius: 4.0)));

    expect(shadow2.blurRadius, equals(1.0));
    expect(shadow3.blurRadius, equals(3.0));

    final BoxShadow shadow4 = BoxShadow.lerp(shadow2, shadow3, 0.5);
    expect(shadow4.blurRadius, equals(2.0));

    List<BoxShadow> shadowList = BoxShadow.lerpList(
        <BoxShadow>[shadow2, shadow1], <BoxShadow>[shadow3], 0.5);
    expect(shadowList, equals(<BoxShadow>[shadow4, shadow1.scale(0.5)]));
    shadowList = BoxShadow.lerpList(
        <BoxShadow>[shadow2], <BoxShadow>[shadow3, shadow1], 0.5);
    expect(shadowList, equals(<BoxShadow>[shadow4, shadow1.scale(0.5)]));
  });

  test('LinearGradient scale test', () {
    final LinearGradient testGradient = const LinearGradient(
      begin: FractionalOffset.bottomRight,
      end: const FractionalOffset(0.7, 1.0),
      colors: const <Color>[
        const Color(0x00FFFFFF),
        const Color(0x11777777),
        const Color(0x44444444),
      ],
    );
    final LinearGradient actual = LinearGradient.lerp(null, testGradient, 0.25);

    expect(actual, const LinearGradient(
      begin: FractionalOffset.bottomRight,
      end: const FractionalOffset(0.7, 1.0),
      colors: const <Color>[
        const Color(0x00FFFFFF),
        const Color(0x04777777),
        const Color(0x11444444),
      ],
    ));
  });

  test('LinearGradient lerp test', () {
    final LinearGradient testGradient1 = const LinearGradient(
      begin: FractionalOffset.topLeft,
      end: FractionalOffset.bottomLeft,
      colors: const <Color>[
        const Color(0x33333333),
        const Color(0x66666666),
      ],
    );

    final LinearGradient testGradient2 = const LinearGradient(
      begin: FractionalOffset.topRight,
      end: FractionalOffset.topLeft,
      colors: const <Color>[
        const Color(0x44444444),
        const Color(0x88888888),
      ],
    );
    final LinearGradient actual = 
        LinearGradient.lerp(testGradient1, testGradient2, 0.5);

    expect(actual, const LinearGradient(
      begin: const FractionalOffset(0.5, 0.0),
      end: const FractionalOffset(0.0, 0.5),
      colors: const <Color>[
        const Color(0x3B3B3B3B),
        const Color(0x77777777),
      ],
    ));
  });
}
