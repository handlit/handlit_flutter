import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';

class FriendRequestSentScreen extends ConsumerStatefulWidget {
  const FriendRequestSentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendRequestSentScreenState();
}

class _FriendRequestSentScreenState extends ConsumerState<FriendRequestSentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_rounded, size: 60, color: Theme.of(context).colorScheme.onSecondaryContainer),
              const SizedBox(height: 24),
              const Text('Successfully sent!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Start a chat on Telegram', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor.withOpacity(0.7))),
              const SizedBox(
                height: 48,
              ),
              CustomThemeButton(
                borderRadius: 20,
                backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    'Visit Telegram',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.background),
                  ),
                ),
                onTap: () {
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
