import '../../models/base/base_model.dart';
import '../base/get_mixin.dart';

class SendGameScoreService with GetHelper {
  Future<bool> getGameScore({
    required String userId,
    required String gameId,
    required int half,
    required int score,
  }) async {
    var response = await httpGet('/api', queryParameters: {
      'user_id': userId,
      'game_code': gameId,
      'half_type': half,
      'score': score
    });

    BaseModel result = baseModelFromJson(response.body);
    return result.result == 1;
  }

  Future<bool> getGameScoreWithRound({
    required String userId,
    required String gameId,
    required int half,
    required int score,
    required int round
  }) async {
    var response = await httpGet('/api', queryParameters: {
      'user_id': userId,
      'game_code': gameId,
      'half_type': half,
      'score': score,
      'round': round
    });

    BaseModel result = baseModelFromJson(response.body);
    return result.result == 1;
  }

  Future<bool> getGameComplete({
    required String userId,
  }) async {
    var response = await httpGet2('/Complete', queryParameters: {
      'user_id': userId,
    });

    BaseModel result = baseModelFromJson(response.body);
    return result.result == 1;
  }
}
