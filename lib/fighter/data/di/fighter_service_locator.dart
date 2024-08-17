import 'package:bet_pos/common/di/service_locator.dart';
import 'package:bet_pos/common/helper/extension/json.dart';
import 'package:equatable/equatable.dart';

part '../data_source/remote/fighter_remote_source.dart';
part '../model/base_model/fighter_input.dart';
part '../model/input/create_fighter_input.dart';
part '../model/input/update_fighter_input.dart';
part '../model/output/fighter_output.dart';
part '../repository/fighter_repository.dart';
part '../repository/fighter_repository_interface.dart';

final fighterRemoteSource = FighterRemoteSource(networkManager);
final fighterRepository = FighterRepository(
  fighterRemoteSource,
);
