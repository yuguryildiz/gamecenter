import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamecenter/gamecenter.dart';

void main() {
  const MethodChannel channel = MethodChannel('gamecenter');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await GameCenter.connect, '42');
  });
}
