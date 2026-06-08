import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

void main() {
  final controller = PagingController<int, String>(
    getNextPageKey: (state) => null,
    fetchPage: (key) async => [],
  );
  print('Value type: ${controller.value.runtimeType}');
}
