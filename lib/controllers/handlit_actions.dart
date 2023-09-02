import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/repositories/api/exception/exception_wrapper.dart';
import 'package:handlit_flutter/repositories/network/networks.dart';

final handlitActionsAsyncController = StateNotifierProvider<HandlitActionsAsyncNotifier, AsyncValue<dynamic>>((ref) => HandlitActionsAsyncNotifier(ref));

class HandlitActionsAsyncNotifier extends StateNotifier<AsyncValue<dynamic>> {
  HandlitActionsAsyncNotifier(this.ref) : super(const AsyncValue.data(null));

  final StateNotifierProviderRef<HandlitActionsAsyncNotifier, AsyncValue<dynamic>> ref;

  Future<void> sendFriendRequest(String cardId, String qrData, String hiMessage, File? image) async {
    state = const AsyncValue.loading();
    final responseObj = await ref.read(handlitActionsNetworkProvider).sendFriendRequest({
      'cardId': cardId,
      'qrData': qrData,
      'hiMessage': hiMessage,
      'sendMySocialToken': true,
    }, image);
    if (responseObj.error) {
      state = AsyncValue.error(CustomException(code: responseObj.errors?[0].code ?? '', message: responseObj.errorName, substring: responseObj.errors![0].message.toString()),
          StackTrace.fromString(responseObj.errors.toString()));
    } else {
      state = AsyncValue.data(responseObj.value);
    }
  }
}
