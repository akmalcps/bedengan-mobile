import 'package:flutter_test/flutter_test.dart';
import 'package:bedengan_mobile/main.dart';

void main() {
  testWidgets('App smoke test - verifies SplashScreen renders', (WidgetTester tester) async {
    // Build BedenganApp and trigger a frame.
    await tester.pumpWidget(const BedenganApp());

    // Verify Bedengan Xplore branding and explore button are present
    expect(find.text('BEDENGAN '), findsOneWidget);
    expect(find.text('XPLORE'), findsOneWidget);
    expect(find.text('Mulai Eksplorasi'), findsOneWidget);
  });
}
