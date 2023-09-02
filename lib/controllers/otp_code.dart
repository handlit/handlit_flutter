import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/repositories/api/exception/exception_wrapper.dart';
import 'package:handlit_flutter/repositories/network/auth_network.dart';

final otpCodeAsyncController = StateNotifierProvider<OtpCodeAsyncNotifier, AsyncValue<Map<String, dynamic>?>>((ref) => OtpCodeAsyncNotifier(ref));

class OtpCodeAsyncNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  OtpCodeAsyncNotifier(this.ref) : super(const AsyncValue.data(null));

  final StateNotifierProviderRef<OtpCodeAsyncNotifier, AsyncValue<Map<String, dynamic>?>> ref;

  Future<void> submitOTP(String otpCode) async {
    state = const AsyncValue.loading();
    final responseObj = await ref.read(authNetworkProvider).submitOTP(otpCode);
    if (responseObj.error) {
      state = AsyncValue.error(
          CustomException(
            code: responseObj.errors?[0].code ?? '',
            message: responseObj.errorName,
            substring: responseObj.errors![0].message.toString(),
          ),
          StackTrace.fromString(responseObj.errors.toString()));
    } else {
      state = AsyncValue.data(responseObj.value);
    }
  }
}
