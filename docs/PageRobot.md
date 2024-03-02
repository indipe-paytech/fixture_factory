# Page Robot
We are using the Page Object pattern / Robot Pattern to make our
tests more readable and maintainable.
References
- Very Good Venture https://verygood.ventures/blog/robot-testing-in-flutter
- Page Object Model: https://www.browserstack.com/guide/page-object-model-in-selenium#:~:text=Page%20Object%20Model%2C%20also%20known,application%20as%20a%20class%20file.

## Usage
```dart

import 'package:flutter_test/flutter_test.dart';
import 'package:indipe_test_core/fixture_factory.dart';

class IntroPageRobot extends PageRobot {
  IntroPageRobot(super.$);

  Future<void> completeIntro() async {
    for (var i = 0; i < 3; i++) {
      /// Clicks the next button
      await tapContinueButton();
    }

    // Continue to Login Page
    await tapContinueButton();
  }

  Future<void> tapContinueButton() async {
    await $(K.onboarding.introContinueButton).tap();
  }
}
```