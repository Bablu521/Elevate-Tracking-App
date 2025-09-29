import 'package:equatable/equatable.dart';

class MainHomeStates extends Equatable {
  final int selectedIndex;

  const MainHomeStates({this.selectedIndex = 0});

  MainHomeStates copyWith({int? selectedIndex}) {
    return MainHomeStates(selectedIndex: selectedIndex ?? this.selectedIndex);
  }

  @override
  List<Object?> get props => [selectedIndex];
}
