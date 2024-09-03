import 'package:bet_pos/common/abstract/json_serializable.dart';
import 'package:bet_pos/common/di/service_locator.dart';
import 'package:bet_pos/common/helper/extension/json.dart';
import 'package:bet_pos/fight/data/di/fight_service_locator.dart';
import 'package:equatable/equatable.dart';

part '../data_source/remote/event_remote_source.dart';
part '../model/base_model/event_input.dart';
part '../model/input/create_event_input.dart';
part '../model/input/update_event_input.dart';
part '../model/output/event_output.dart';
part '../model/output/current_event_and_fight_output.dart';
part '../repository/event_repository.dart';
part '../repository/event_repository_interface.dart';

final eventRemoteSource = EventRemoteSource(networkManager);
final eventRepository = EventRepository(
  eventRemoteSource,
);
