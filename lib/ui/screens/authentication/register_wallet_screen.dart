import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:handlit_flutter/utils/routes.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:styled_widget/styled_widget.dart';

class RegisterWalletScreen extends ConsumerStatefulWidget {
  const RegisterWalletScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterWalletScreenState();
}

class _RegisterWalletScreenState extends ConsumerState<RegisterWalletScreen> {
  late TextEditingController _walletAddressEditingController;
  late FocusNode _walletAddressFocusNode;

  @override
  void initState() {
    super.initState();
    _walletAddressEditingController = TextEditingController();
    _walletAddressFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _walletAddressFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _walletAddressEditingController.dispose();
    _walletAddressFocusNode.dispose();
  }

  Future<void> pasteWalletAddress() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null) {
      _walletAddressEditingController.text = data.text ?? '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FooterLayout(
        footer: CustomFooterButton(
          title: 'Submit',
          onTap: () {
            context.push('/${HandleItRoutes.telegramPhoneInput.name}');
          },
          isDisabled: _walletAddressEditingController.text.isEmpty,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Text(
                  "Welcome to",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                ).alignment(Alignment.center),
                const SizedBox(height: 24),
                Image.asset('assets/images/logo.png', width: MediaQuery.of(context).size.width * 0.6, fit: BoxFit.fitWidth),
                const SizedBox(height: 24),
                Text(
                  "Manage your web3 friends",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer, fontSize: 16),
                ).alignment(Alignment.center),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AutoSizeText(
                    'Collect your valuable networks! Start by adding your Ethereum address',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: CustomBoxInputFields(
                    contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                    controller: _walletAddressEditingController,
                    focusNode: _walletAddressFocusNode,
                    onChanged: (p0) => setState(() {}),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            'PASTE',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                          ),
                        ).gestures(onTap: pasteWalletAddress),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
