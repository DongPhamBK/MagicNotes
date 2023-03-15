class DataResponse {
  int? code;
  String? status;
  dynamic? data;
  dynamic? message;

  DataResponse({
    this.code,
    this.status,
    this.data,
    this.message,
  });

  DataResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }

  @override
  String toString() {
    return 'DataResponse{code: $code, status: $status, data: $data, message: $message}';
  }
}
