import 'dart:async';

import 'package:flutter/services.dart';

class Smssdk {
  static const MethodChannel channel = const MethodChannel('smssdk');

  static Future<void> init(String appKey, String appSecret) async {
    await channel.invokeMethod('init', {'appKey': appKey, 'appSecret': appSecret});
  }

  static Future<Result> getCode(String phone) async {
    final Map<dynamic, dynamic> getCode = await channel.invokeMethod('getCode', {'phone': phone});
    Result result = new Result();
    result.status = getCode["status"];
    result.msg = getCode["msg"];
    return result;
  }

  static Future<Result> commitCode(String phone, String code) async {
    final Map<dynamic, dynamic> getCode = await channel.invokeMethod('commitCode', {'phone': phone, 'code': code});
    Result result = new Result();
    result.status = getCode["status"];
    result.msg = getCode["msg"];
    return result;
  }
}

class Result {
  int status;
  String msg;
}
