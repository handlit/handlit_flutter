import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/models/user_auth_info.dart';
import 'package:handlit_flutter/repositories/api/exception/exception_wrapper.dart';
import 'package:handlit_flutter/repositories/local_pref.dart';
import 'package:handlit_flutter/repositories/network/auth_network.dart';

final walletConnectAsyncController = StateNotifierProvider<WalletConnectAsyncNotifier, AsyncValue<UserTokenObj?>>((ref) => WalletConnectAsyncNotifier(ref));

class WalletConnectAsyncNotifier extends StateNotifier<AsyncValue<UserTokenObj?>> {
  WalletConnectAsyncNotifier(this.ref) : super(const AsyncValue.data(null));

  final StateNotifierProviderRef<WalletConnectAsyncNotifier, AsyncValue<UserTokenObj?>> ref;

  Future<void> submitWalletAddress(String walletAddress) async {
    state = const AsyncValue.loading();
    final responseObj = await ref.read(authNetworkProvider).submitWalletAddress(walletAddress);

    if (responseObj.error) {
      state = AsyncValue.error(CustomException(code: responseObj.errors?[0].code ?? '', message: responseObj.errorName, substring: responseObj.errors![0].message.toString()),
          StackTrace.fromString(responseObj.errors.toString()));
    } else {
      (await ref.read(sharedPrefProvider)).setString('x-user-token', responseObj.value?.userToken ?? '');
      (await ref.read(sharedPrefProvider)).setString('wallet', walletAddress);
      state = AsyncValue.data(responseObj.value);
    }
  }
}
