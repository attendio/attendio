import 'package:hooks_riverpod/hooks_riverpod.dart';

final tabTypeProvider =
    AutoDisposeStateProvider<TabType>((ref) => TabType.Profile);

enum TabType {
  Events,
  Profile,
  CheckIn,
}
