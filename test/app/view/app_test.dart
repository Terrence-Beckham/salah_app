import 'package:flutter_test/flutter_test.dart';
import 'package:salah_app/app/app.dart';
import 'package:salah_app/salah/view/salah_view.dart';

void main() {
  group('App', () {
    testWidgets('renders SalahView page', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(SalahView), findsOneWidget);
    });
  });
}
