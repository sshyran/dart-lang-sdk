// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/src/error/codes.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../dart/resolution/driver_resolution.dart';
import '../dart/resolution/with_null_safety_mixin.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(NonBoolNegationExpressionTest);
    defineReflectiveTests(NonBoolNegationExpressionWithNullSafetyTest);
  });
}

@reflectiveTest
class NonBoolNegationExpressionTest extends DriverResolutionTest {
  test_nonBool() async {
    await assertErrorsInCode(r'''
f() {
  !42;
}
''', [
      error(StaticTypeWarningCode.NON_BOOL_NEGATION_EXPRESSION, 9, 2),
    ]);
  }
}

@reflectiveTest
class NonBoolNegationExpressionWithNullSafetyTest extends DriverResolutionTest
    with WithNullSafetyMixin {
  test_null() async {
    await assertErrorsInCode(r'''
m() {
  Null x;
  !x;
}
''', [
      error(HintCode.UNUSED_LOCAL_VARIABLE, 13, 1),
      error(StaticTypeWarningCode.NON_BOOL_NEGATION_EXPRESSION, 19, 1),
    ]);
  }
}
