import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission.g.dart';

@JsonSerializable(explicitToJson: true)
class Mission {
  Mission({
    required this.mission_id,
    required this.user_mission_id,
    required this.content,
    required this.stage,
    required this.answer,
  });

  factory Mission.empty() => Mission(
        mission_id: 0,
        user_mission_id: 0,
        content: '',
        stage: '',
        answer: '',
      );

  factory Mission.fromJson(Map<String, dynamic> json) =>
      _$MissionFromJson(json);

  factory Mission.fromDynamic(dynamic data) =>
      Mission.fromJson(data as Map<String, dynamic>);

  final int mission_id;
  final int? user_mission_id;
  final String content;
  final String stage;
  final String? answer;

  Map<String, dynamic> toJson() => _$MissionToJson(this);

  bool get hasTrue => answer == 'Y' && answer != null;
  bool get hasFalse => answer == 'N' && answer != null;
}
