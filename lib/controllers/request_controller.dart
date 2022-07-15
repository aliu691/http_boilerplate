import 'package:my_http_boilerplate/controllers/base_controller.dart';
import 'package:my_http_boilerplate/helpers/environment.dart';
import 'package:my_http_boilerplate/helpers/toast_manager.dart';
import 'package:my_http_boilerplate/service/base_api_client.dart';

class RequestController with BaseController {
  final baseUrl = Environment.apiBaseUrl.toString();

  get() async {
    var response = await BaseApiCall()
        .getRequest(baseUrl, 'posts')
        .catchError(handleError);
    //return nothing if response is null
    if (response == null) return;

    print(response);
    //ToastManager.showSuccessToast("success");
    return response;
  }

  post() async {
    var payload = {"message": "sample"};
    var response = await BaseApiCall()
        .postRequest(baseUrl, "posts", payload)
        .catchError(handleError);

    if (response == null) return;

    print(response);
    return response;
  }
}
