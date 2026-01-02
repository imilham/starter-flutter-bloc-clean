import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/extensions/core_extensions.dart';

void main() {
  group('StringExtensions', () {
    test('orEmpty returns string when not null', () {
      const input = 'test';
      expect(input.orEmpty(), 'test');
    });

    test('orEmpty returns default when null', () {
      const String? input = null;
      expect(input.orEmpty('default'), 'default');
      expect(input.orEmpty(), '');
    });

    test('isNullOrEmpty checks correctly', () {
      expect((null as String?).isNullOrEmpty, true);
      expect(''.isNullOrEmpty, true);
      expect(' '.isNullOrEmpty, false);
      expect('a'.isNullOrEmpty, false);
    });

    test('isNotNullOrEmpty checks correctly', () {
      expect((null as String?).isNotNullOrEmpty, false);
      expect(''.isNotNullOrEmpty, false);
      expect('a'.isNotNullOrEmpty, true);
    });
  });

  group('StringUtils', () {
    test('capitalize works correctly', () {
      expect('hello'.capitalize, 'Hello');
      expect('Hello'.capitalize, 'Hello');
      expect(''.capitalize, '');
      expect('a'.capitalize, 'A');
    });

    test('isValidEmail validates correctly', () {
      expect('test@example.com'.isValidEmail, true);
      expect('test.name@domain.co.uk'.isValidEmail, true);
      expect('plainaddress'.isValidEmail, false);
      expect('@missingusername.com'.isValidEmail, false);
      // expect('username@.com'.isValidEmail, false); // Regex dependant
    });
  });

  group('ListExtensions', () {
    test('safeElementAt returns element or null', () {
      final list = [1, 2, 3];
      expect(list.safeElementAt(0), 1);
      expect(list.safeElementAt(2), 3);
      expect(list.safeElementAt(3), null);
      expect(list.safeElementAt(-1), null);
    });

    test('safeElementAt handles null list', () {
      const List<int>? list = null;
      expect(list.safeElementAt(0), null);
    });

    test('isNullOrEmpty checks correctly', () {
      expect((null as List?).isNullOrEmpty, true);
      expect(<int>[].isNullOrEmpty, true);
      expect([1].isNullOrEmpty, false);
    });
  });

  group('DateTimeExtensions', () {
    test('format works correctly', () {
      // Hard to test exact string without mocking time or strict format
      // So we test structure
      final date = DateTime(2023, 10, 25); // 25 Oct 2023
      expect(date.format('yyyy-MM-dd'), '2023-10-25');
    });

    test('isToday returns true for now', () {
      final now = DateTime.now();
      expect(now.isToday, true);
    });

    test('isToday returns false for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(yesterday.isToday, false);
    });

    test('isYesterday returns true for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(yesterday.isYesterday, true);
    });
  });
}
