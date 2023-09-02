import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/repositories/network/auth_network.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:handlit_flutter/utils/data/country_code.dart';
import 'package:handlit_flutter/utils/routes.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:recase/recase.dart';

final countryCodeStateProvider = StateProvider<Map<String, String>?>((ref) => null);
final phoneNumberStateProvider = StateProvider<String?>((ref) => null);

class TelegramPhoneInputScreen extends ConsumerStatefulWidget {
  const TelegramPhoneInputScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TelegramPhoneInputScreenState();
}

class _TelegramPhoneInputScreenState extends ConsumerState<TelegramPhoneInputScreen> {
  late TextEditingController _countryEditingController;
  late TextEditingController _phoneEditingController;
  late FocusNode _countryFocusNode;
  late FocusNode _phoneFocusNode;

  @override
  void initState() {
    super.initState();
    _countryEditingController = TextEditingController();
    _phoneEditingController = TextEditingController();
    _countryFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    Future(
      () {
        ref.read(countryCodeStateProvider.notifier).state = null;
        _showCountryCodeSelector();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _countryEditingController.dispose();
    _phoneEditingController.dispose();
    _countryFocusNode.dispose();
    _phoneFocusNode.dispose();
  }

  void _showCountryCodeSelector() {
    showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(minWidth: double.infinity),
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CountryCodeSelectorBottomSheet(),
    ).then((_) {
      setState(() {
        if (ref.watch(countryCodeStateProvider) != null) {
          _countryEditingController.text = ref.watch(countryCodeStateProvider)?['name'] ?? '';
          _phoneFocusNode.requestFocus();
        }
      });
    });
  }

  Future<void> _sendVerificationCode() async {
    print(_phoneEditingController.text);
    ref.read(phoneNumberStateProvider.notifier).state = ((ref.watch(countryCodeStateProvider)?['dial_code'] ?? '') + _phoneEditingController.text).replaceAll('+', '');
    await ref.read(authNetworkProvider).submitPhoneNumber(ref.read(phoneNumberStateProvider) ?? '').whenComplete(
          () => context.push('/${HandleItRoutes.telegramAuthCodeInput.name}'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: FooterLayout(
          footer: CustomFooterButton(
            title: 'Send verification code',
            isDisabled: false,
            isProgressing: false,
            onTap: _sendVerificationCode,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HandleitCustomHeader(title: 'Telegram verification'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                      Text('Your phone number', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 24),
                      Text(
                        'Please confirm your country code\nand enter your phone number.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: CustomBoxInputFields(
                          focusNode: _countryFocusNode,
                          leading: ref.watch(countryCodeStateProvider) == null
                              ? null
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/flags/${ReCase(ref.watch(countryCodeStateProvider)?['code'] ?? '').dotCase}.png',
                                      width: 24,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ],
                                ),
                          controller: _countryEditingController,
                          readOnly: true,
                          onTap: _showCountryCodeSelector,
                          placeholder: 'Country',
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Theme.of(context).disabledColor,
                            size: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Phone number', style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(height: 4),
                            CustomBoxInputFields(
                              focusNode: _phoneFocusNode,
                              onChanged: (p0) => setState(() {}),
                              leading: ref.watch(countryCodeStateProvider) == null
                                  ? Icon(Icons.add, color: Theme.of(context).disabledColor, size: 16)
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          ref.watch(countryCodeStateProvider)?['dial_code'] ?? '',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
                                        ),
                                      ],
                                    ),
                              controller: _phoneEditingController,
                              trailing: _phoneEditingController.text.isEmpty
                                  ? const SizedBox.shrink()
                                  : InkWell(
                                      onTap: () {
                                        _phoneEditingController.clear();
                                      },
                                      borderRadius: BorderRadius.circular(16),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.close,
                                          color: Theme.of(context).disabledColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryCodeSelectorBottomSheet extends ConsumerWidget {
  const CountryCodeSelectorBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseBottomSheetContainer(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final countryCode = CountryCode.codes[index];
          return ListTile(
            leading: Image.asset(
              'assets/images/flags/${ReCase(countryCode['code'] ?? '').dotCase}.png',
              width: 32,
              height: 32,
            ),
            onTap: () {
              ref.read(countryCodeStateProvider.notifier).state = countryCode;
              Navigator.pop(context);
            },
            title: Text(countryCode['name'] ?? ''),
            subtitle: Text(countryCode['dial_code'] ?? ''),
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
        itemCount: CountryCode.codes.length,
      ),
    );
  }
}
