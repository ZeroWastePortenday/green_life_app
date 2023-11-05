import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_mission.g.dart';

@JsonSerializable()
class PostMission {
  PostMission(this.mission_id, this.answer);

  factory PostMission.fromJson(Map<String, dynamic> json) =>
      _$PostMissionFromJson(json);

  final String? mission_id;
  final String? answer;

  Map<String, dynamic> toJson() => _$PostMissionToJson(this);
}
