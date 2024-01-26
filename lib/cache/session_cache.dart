import 'package:mathgptpro_mclient_flutter/model/session_history_dto.dart';

SessionCache globalSessionCache = SessionCache();

class SessionCache {
  List<SessionHistoryDto> sessionHistoryDtoList = [];
}
