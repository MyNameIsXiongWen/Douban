import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:hhh/utils/common.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kAppKey = '844c3025fa90c45e';
const String kAppSecret = 'B62E6C010EEF6E93563FE13582CA4B52';
const String kAppVersion = '1.0.0';

//聚合数据
const String kApiKey = '8a5aba4cc818913e4681afe9db1eaa16';
const String kCityId = '10';

const String kContentTypeJson = 'application/json';
const String kContentTypeForm = 'application/x-www-form-urlencoded';

class HttpManager {

  static get(String url, String path, Function successCallBack, {Function errorCallBack}) async {
    Options option = Options(
      headers: getRequestHeaders(),
      connectTimeout: 30,
      // contentType: ContentType.json,
      // responseType: ResponseType.json
    );

    Dio dio = new Dio();
    var response = await dio.get(
      (url.length>0 ? url : Util.kMainUrl) + '?' + path,
      queryParameters: null,
      options: option
    );
    if (response.statusCode == HttpStatus.ok) {
      if (response.data['error_code'] == 0) {
        successCallBack(response.data['result']);
      }
      else {
        errorCallBack(response.data['reason']);
      }
    }
    else {
      errorCallBack('请求失败');
    }
  }

  static post(String url, String path, Map<String, dynamic> params, Function successCallBack, {Function errorCallBack}) async {
    Options option = Options(
      headers: getRequestHeaders(),
      connectTimeout: 15000,
    );
    var dio = new Dio();
    var response = await dio.post(
      (url.length>0 ? url : Util.kMainUrl) + path,
      queryParameters: params,
      options: option
    );
    if (response.statusCode == HttpStatus.ok) {
      if (int.parse(response.data['returnCode']) == 000000) {
        successCallBack(response.data['data']);
      }
      else {
        errorCallBack(response.data['returnMsg']);
      }
      // if (response.data['error_code'] == 0) {
      //   successCallBack(response.data['result']);
      // }
      // else {
      //   errorCallBack(response.data['reason']);
      // }
    }
    else {
      errorCallBack('请求失败');
    }
  }

  static Map<String, String> getRequestHeaders() {
    String randomString = getRandomString();
    String timeString = getCurrentTimeMillis();
    Map<String, String> requestHeader = {
      // 'Content-Type': kContentTypeForm,
      'signature': sortRequestParams(randomString, timeString),
      'noncestr': randomString,
      'timestamp': timeString,
      'authorization': kAppKey,
      'version': kAppVersion,
      'token': Util.token,
      'shopid': Util.shopId
    };
    return requestHeader;
  }

  static String getCurrentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String getRandomString() {
    String alphabet = '0123456789QWERTYUIOPASDFGHJKLZXCVBNM';
    int strlenght = 32; /// 生成的字符串固定长度
    String randomStr = '';
    for (var i = 0; i < strlenght; i++) {
      randomStr = randomStr + alphabet[Random().nextInt(alphabet.length)];
    }
    return randomStr;
  }

  static String sortRequestParams(String randomStr, String timeStr) {
    Map<String, String> params = SplayTreeMap<String, String>();
    params['noncestr'] = randomStr;
    params['timestamp'] = timeStr;
    params['authorization'] = kAppKey;
    params['version'] = kAppVersion;
    params['token'] = Util.getSharePreference('token').toString();
    params['shopid'] = Util.getSharePreference('shopId').toString();

    List<String> paramList = List();
    params.forEach((key, value) {
      if (value.length > 0) {
        String str = key.toString() + '=' + value.toString();
      paramList.add(str);
      }
    });

    String signatureString = paramList.join('&') + '&key=$kAppSecret';
    print('signatureString=$signatureString   MD5=' + getMD5String(signatureString).toUpperCase());
    return getMD5String(signatureString).toUpperCase();
  }

  static String getMD5String(String target) {
    return md5.convert(utf8.encode(target)).toString();
  }
}