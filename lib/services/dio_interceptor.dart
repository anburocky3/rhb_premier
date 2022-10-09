import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rhb_premier/Routes/routes.dart';
import 'package:rhb_premier/providers/AuthProvider.dart';
import 'package:rhb_premier/service_locator.dart';
import 'package:rhb_premier/services/navigation_service.dart';
import 'package:rhb_premier/sharedPreferences/Prefs.dart';

class AppInterceptors extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    if (options.headers.containsKey("requiresToken")) {
      //remove the auxiliary header
      options.headers.remove("requiresToken");

      // gets token from shared_preferences
      final _token = await Prefs.token;
      options.headers.addAll({"Authorization": "Bearer $_token"});
    }

    return handler.next(options);
  }

  @override
  FutureOr<dynamic> onError(DioError err,
      ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await AuthProvider().logout();
        // i want to navigate to logout screen after this.
        // locator<NavigationService>().getContext()?.showToast('Authentication expired! Login again!');
        locator<NavigationService>().navigateTo(PageRoutes.forceLogin);
        // navigatorKey.currentState.pushNamedAndRemoveUntil(
        //     "/", (Route<dynamic> route) => false);
      } catch (e) {
        locator<NavigationService>().navigateTo(PageRoutes.forceLogin);
        print('DIO onError: ${err.message}');
      }
    }

    // if (err.message.contains("ERROR_001")) {
    //   // this will push a new route and remove all the routes that were present
    //   navigatorKey.currentState.pushNamedAndRemoveUntil(
    //       "/login", (Route<dynamic> route) => false);
    // }

    return handler.next(err);
  }

  @override
  FutureOr<dynamic> onResponse(Response response,
      ResponseInterceptorHandler handler) async {
    // print("DIO onResponse: ${response.data}");
    return handler.next(response);
    // return DioError(request: options.request, message: "User is no longer active");
  }
}
