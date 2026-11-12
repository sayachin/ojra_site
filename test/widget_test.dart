import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_age_factories/content.dart';
import 'package:new_age_factories/theme.dart';

void main() {
  test('brand content is wired up', () {
    expect(kCompanyName, 'New Age Factories LLC');
    expect(kContactEmail, contains('@'));
    expect(kEmailUri, startsWith('mailto:'));
    expect(kNavSections, isNotEmpty);
  });

  test('Ojra store links point at both live Play listings', () {
    expect(
      kOjraRiderPlayUrl,
      'https://play.google.com/store/apps/details?id=com.ojra.rider',
    );
    expect(
      kOjraDriverPlayUrl,
      'https://play.google.com/store/apps/details?id=com.ojra.driver',
    );
  });

  test('site theme uses the dark brand surface', () {
    final theme = buildTheme();
    expect(theme.brightness, Brightness.dark);
    expect(theme.scaffoldBackgroundColor, Brand.bg);
    expect(theme.colorScheme.primary, Brand.cyan);
  });
}
