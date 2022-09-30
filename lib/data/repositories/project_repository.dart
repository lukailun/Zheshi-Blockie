import 'package:blockie_app/app/modules/event/models/event.dart';
import 'package:blockie_app/app/modules/registration_info/models/registration_info.dart';
import '../../utils/http_request.dart';

class ProjectRepository {
  final HttpRequest client;

  ProjectRepository({required this.client});

  Future<Event> getEvent(String ID) => client.getEvent(ID);

  Future<RegistrationInfo> getRegistrationInfo(String ID) =>
      client.getRegistrationInfo(ID);

  Future<bool> updateRegistrationInfo(String ID, String number) =>
      client.updateRegistrationInfo(ID, number);
}
