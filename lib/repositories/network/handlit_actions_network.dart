import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/models/base_response.dart';
import 'package:handlit_flutter/repositories/api/apis.dart';
import 'package:handlit_flutter/repositories/local_pref.dart';

final handlitActionsNetworkProvider = Provider<HandlitActionsNetwork>((ref) => HandlitActionsNetwork(ref));

class HandlitActionsNetwork {
  final Ref ref;
  const HandlitActionsNetwork(this.ref);

  Future<BaseResponseObject<dynamic>> sendFriendRequest(Map<String, dynamic> params, File? image) async {
    // submit eth wallet address to server
    final response = await ref.read(apiProvider).requestPostImages(
          APIUrl.EXCHANDED_CARDS,
          params,
          image == null ? [] : [image],
          (await ref.read(sharedPrefProvider)).getString('x-user-token') ?? '',
        );
    return BaseResponseObject<dynamic>.fromJson(
      response,
      (json) => json as Map<String, dynamic>,
    );
  }
}
