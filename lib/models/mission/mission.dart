import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission.g.dart';

@JsonSerializable()
class Mission {
  Mission(this.mission_id, this.answer);

  factory Mission.fromJson(Map<String, dynamic> json) =>
      _$MissionFromJson(json);

  factory Mission.fromDynamic(dynamic data) =>
      Mission.fromJson(data as Map<String, dynamic>);

  final String mission_id;
  final String answer;

  Map<String, dynamic> toJson() => _$MissionToJson(this);
}
