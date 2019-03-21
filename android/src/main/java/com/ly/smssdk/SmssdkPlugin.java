package com.ly.smssdk;

import com.mob.MobSDK;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

import cn.smssdk.EventHandler;
import cn.smssdk.SMSSDK;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class SmssdkPlugin implements MethodCallHandler {

  private Registrar registrar;

  private SmssdkPlugin(Registrar registrar) {
    this.registrar = registrar;
  }

  private Handler handler = new Handler();

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "smssdk");
    channel.setMethodCallHandler(new SmssdkPlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
      case "init":
        String appKey = call.argument("appKey");
        String appSecret = call.argument("appSecret");
        MobSDK.init(registrar.activity(), appKey, appSecret);
        SMSSDK.registerEventHandler(handler);
        result.success(null);
        break;
      case "getCode":
        handler.setResult(result);
        String phone = call.argument("phone");
        SMSSDK.getVerificationCode("+86", phone);
        break;
      case "commitCode":
        handler.setResult(result);
        String phone1 = call.argument("phone");
        String code = call.argument("code");
        SMSSDK.submitVerificationCode("+86", phone1, code);
        break;
    }
  }

  private class Handler extends EventHandler {
    private Result result;

    void setResult(Result result) {
      this.result = result;
    }

    @Override
    public void afterEvent(int event, int i, Object data) {
      if (i == SMSSDK.RESULT_COMPLETE) {
        //回调完成
        switch (event) {
          case SMSSDK.EVENT_GET_VERIFICATION_CODE:
            //获取验证码成功
            HashMap<String, Object> get = new HashMap<>();
            get.put("status", 0);
            get.put("msg", "success");
            result.success(get);
            break;
          case SMSSDK.EVENT_SUBMIT_VERIFICATION_CODE:
            HashMap<String, Object> submit = new HashMap<>();
            submit.put("status", 0);
            submit.put("msg", "success");
            result.success(submit);
            break;
          case SMSSDK.EVENT_GET_SUPPORTED_COUNTRIES:
            //返回支持发送验证码的国家列表
            break;
        }
      } else {
        try {
          JSONObject json = new JSONObject(((Throwable) data).getMessage());
          HashMap<String, Object> map = new HashMap<>();
          map.put("status", 1);
          map.put("msg", json.getString("detail"));
          result.success(map);
        } catch (JSONException e) {
          e.printStackTrace();
        }
      }
    }
  }
}
