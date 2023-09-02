// ignore_for_file: unused_local_variable, library_prefixes, depend_on_referenced_packages, unnecessary_this, prefer_const_constructors, prefer_interpolation_to_compose_strings, unnecessary_new, avoid_print, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
export 'api_url.dart';
export 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiProvider = Provider<API>((ref) => API(ref));

class API {
  API(this.ref);

  final ProviderRef<API> ref;
  final _baseUrl = dotenv.get('BASE_URL');

  Future<Map<String, dynamic>> requestPost(String url, Map<String, dynamic> params, [String? authToken]) async {
    var uri = Uri.parse("$_baseUrl/$url");
    try {
      http.Response response = await http.post(
        uri,
        headers: {
          ...authToken == null ? {} : {"x-user-token": authToken},
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(params),
      );
      return _handleStatus(response);
    } catch (e) {
      return {
        'error': true,
        'errorName': 'Client Error',
        'errors': [
          {'code': 'clientErr', 'message': '알 수 없는 에러가 발생했어요.'}
        ],
      };
    }
  }

  Future<Map<String, dynamic>> requestPut(String url, Map<String, dynamic> params, [String? authToken]) async {
    var uri = Uri.parse("$_baseUrl/$url");

    try {
      http.Response response = await http.put(
        uri,
        headers: {
          ...authToken == null ? {} : {"x-user-token": authToken},
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(params),
      );
      return _handleStatus(response);
    } catch (e) {
      print(e);

      return {
        'error': true,
        'errorName': '클라이언트 오류',
        'errors': [
          {'code': 'clientErr', 'message': '알 수 없는 에러가 발생했어요.'}
        ],
      };
    }
  }

  Future<Map<String, dynamic>> requestPatch(String url, Map<String, dynamic> params, [String? authToken]) async {
    var uri = Uri.parse("$_baseUrl/$url");

    try {
      http.Response response = await http.patch(
        uri,
        headers: {
          ...authToken == null ? {} : {"x-user-token": authToken},
          "Content-Type": "application/json",
          "Accept": "*/*",
        },
        body: jsonEncode(params),
      );
      return _handleStatus(response);
    } catch (e) {
      print(e);

      return {
        'error': true,
        'errorName': '클라이언트 오류',
        'errors': [
          {'code': 'clientErr', 'message': '알 수 없는 에러가 발생했어요.'}
        ],
      };
    }
  }

  Future<Map<String, dynamic>> requestDelete(String url, Map<String, dynamic> params, [String? authToken]) async {
    var uri = Uri.parse("$_baseUrl/$url");

    try {
      http.Response response = await http.delete(
        uri,
        headers: {
          ...authToken == null ? {} : {"x-user-token": authToken},
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(params),
      );
      return _handleStatus(response);
    } catch (e) {
      print(e);

      return {
        'error': true,
        'errorName': '클라이언트 오류',
        'errors': [
          {'code': 'clientErr', 'message': '알 수 없는 에러가 발생했어요.'}
        ],
      };
    }
  }

  Future<Map<String, dynamic>> requestGet(String url, [String? authToken]) async {
    var uri = Uri.parse("$_baseUrl/$url");

    try {
      http.Response response = await http.get(
        uri,
        headers: {
          ...authToken == null ? {} : {"x-user-token": authToken},
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      print('response.body: ${response.body}');
      return _handleStatus(response);
    } catch (e) {
      print('Request get error: $e');

      return {
        'error': true,
        'errorName': '클라이언트 오류',
        'errors': [
          {'code': 'clientErr', 'message': '알 수 없는 에러가 발생했어요.'}
        ],
      };
    }
  }

  Future<Map<String, dynamic>> requestPostImages(String url, Map<String, dynamic> params, List<File> images, [String? authToken]) async {
    var uri = Uri.parse("$_baseUrl/$url");

    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll({
      ...authToken == null ? {} : {"x-user-token": authToken},
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
      "Accept": "*/*",
    });

    for (var index = 0; index < images.length; index++) {
      request.files.add(
        await http.MultipartFile.fromPath('files', images[index].path, filename: Uri.encodeFull(path.basename(images[index].path))),
      );
    }

    request.fields.addAll(
      params.map((key, value) => MapEntry(key, value.toString())),
    );

    try {
      http.StreamedResponse response = await request.send();

      switch (response.statusCode) {
        case 200:
          print('OK: 요청을 성공적으로 처리함');
          break;
        case 201:
          print('Created: 새 리소스를 성공적으로 생성함. 응답의 Location 헤더에 해당 리소스의 URI가 담겨있다.');
          break;
        case 204:
          print('No Content: 기존 리소스를 성공적으로 수정함.');
          break;
        case 400:
          print('Bad Request: 잘못된 요청을 보낸 경우. 응답 본문에 더 오류에 대한 정보가 담겨있다.');
          break;
        case 404:
          print('Not Found: 요청한 리소스가 없음.');
          break;
        case 500:
          print('Internal Server Error: 서버에 오류가 발생하여 요청을 수행할 수 없음.');
          break;
        default:
      }

      if (response.statusCode < 500) {
        return {
          'error': false,
        };
      } else {
        return {
          'error': true,
          'errorName': 'Server Error',
          'errors': [
            {'code': 500, 'message': 'Something went wrong.'}
          ],
        };
      }
    } catch (e) {
      print(e);

      return {
        'error': true,
        'errorName': 'Client Error',
        'errors': [
          {'code': 'clientErr', 'message': 'Something went wrong.'}
        ],
      };
    }
  }

  Map<String, dynamic> _handleStatus(http.Response response) {
    switch (response.statusCode) {
      case 200:
        print('OK: 요청을 성공적으로 처리함');
        break;
      case 201:
        print('Created: 새 리소스를 성공적으로 생성함. 응답의 Location 헤더에 해당 리소스의 URI가 담겨있다.');
        break;
      case 204:
        print('No Content: 기존 리소스를 성공적으로 수정함.');
        break;
      case 400:
        print('Bad Request: 잘못된 요청을 보낸 경우. 응답 본문에 더 오류에 대한 정보가 담겨있다.');
        break;
      case 404:
        print('Not Found: 요청한 리소스가 없음.');
        break;
      case 500:
        print('Internal Server Error: 서버에 오류가 발생하여 요청을 수행할 수 없음.');
        break;
      default:
    }

    print(response.body);
    final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    print(jsonResponse);
    return jsonResponse;
  }
}
