import 'package:starter/app/app.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/utils/utils.dart';

void main() {
  bootstrap(() => const StarterApp(), environment: AppEnvironment.production);
}
