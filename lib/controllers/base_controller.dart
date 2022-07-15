import 'package:my_http_boilerplate/helpers/app_exceptions.dart';
import 'package:my_http_boilerplate/helpers/toast_manager.dart';

class BaseController {
  handleError(error) {
    if (error is BadRequestException) {
      var message = error.message;
      ToastManager.showErrorToast(message);
    } else if (error is UnauthorizedException) {
      var message = error.message;
      ToastManager.showErrorToast(message);
    } else if (error is ApiTimeoutException) {
      var message = error.message;
      ToastManager.showErrorToast(message);
    } else if (error is FetchDataException) {
      var message = error.message;
      ToastManager.showErrorToast(message);
    }
  }
}
