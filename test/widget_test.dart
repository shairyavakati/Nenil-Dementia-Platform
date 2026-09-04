// Nenil — Basic widget smoke test
// Verifies that the app bootstraps without exceptions and renders the initial route.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nenil/main.dart';

void main() {
  testWidgets('Nenil app smoke test — app launches without exceptions', (WidgetTester tester) async {
    // Build the root app widget wrapped in ProviderScope
    await tester.pumpWidget(
      const ProviderScope(
        child: NenilApp(),
      ),
    );

    // Allow initial frames and delayed navigation timer (2s splash delay) to complete
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Verify app renders something (initial route exists)
    expect(find.byType(NenilApp), findsOneWidget);
  });
}
