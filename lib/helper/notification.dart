
import 'package:flipr/helper/shared_pref_manager.dart';

import '../model/notification_model.dart';
import '../model/response_body.dart';
import 'api_model.dart';

class Notification1 {
  List<ApiModel> notifications = [];

  SharedPrefManager sharedData = SharedPrefManager();

  Future<List<ApiModel>> getNotifications(
      ) async {
    var empID = await sharedData.getEmpID();
    Api apiCall = Api();
    ResponseNotification responseBody =
    await apiCall.getnotifications(empID);

    if (responseBody.response!=[]) {
      List<dynamic> result = responseBody.response;

      for (var i = 0; i < result.length; i++) {
        if (result[i]['description'] != null && result[i]['type'] != null && result[i]['time_taken']!=null) {
          ApiModel apiModel =
          ApiModel(description: result[i]['description'], time: result[i]['time_taken'],type: result[i]['type']);
          notifications.add(apiModel);
        }
      }

      return notifications;
    } else {
      print('Api request fail');
    }

    return notifications;
  }
}
