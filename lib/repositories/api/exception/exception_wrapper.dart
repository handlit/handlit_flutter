// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals, avoid_print

class ResponseErrorStatus implements Exception {
  String? code;
  String? message;
  CustomStackTrace? stackTrace;

  ResponseErrorStatus({this.code, this.message, this.stackTrace});

  ResponseErrorStatus.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    stackTrace = CustomStackTrace(json['message']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;

    return data;
  }
}

class CustomStackTrace implements StackTrace {
  String message;
  CustomStackTrace(this.message);

  @override
  String toString() {
    print(this.message);
    return super.toString();
  }
}
