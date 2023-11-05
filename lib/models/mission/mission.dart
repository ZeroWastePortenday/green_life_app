import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_life_app/models/mission/post_mission.dart';

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

  // copy
  Mission copyWith({
    int? mission_id,
    int? user_mission_id,
    String? content,
    String? stage,
    String? answer,
  }) {
    return Mission(
      mission_id: mission_id ?? this.mission_id,
      user_mission_id: user_mission_id ?? this.user_mission_id,
      content: content ?? this.content,
      stage: stage ?? this.stage,
      answer: answer ?? this.answer,
    );
  }

  static Map<String, dynamic> makeMissionListToMap(List<Mission?> missionList) {
    final map = <String, dynamic>{};

    for (var i = 0; i < missionList.length; i++) {
      final mission = PostMission(
        '${missionList[i]?.mission_id}',
        missionList[i]?.answer,
      );

      map['${i + 1}'] = mission.toJson();
    }

    return map;
  }
}
