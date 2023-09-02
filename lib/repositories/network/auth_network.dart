import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNetworkProvider = Provider<AuthNetwork>((ref) => AuthNetwork(ref));

class AuthNetwork {
  final Ref ref;
  const AuthNetwork(this.ref);

  Future<void> submitEthAddress() async {
    // submit eth wallet address to server
  }

  Future<void> submitPhoneNumber() async {
    // submit phone number to server
  }

  Future<void> submitOTP() async {
    // submit OTP to server
  }
}
