import 'package:flutter/material.dart';

class BankConnectionPopupMenu extends StatelessWidget {
  const BankConnectionPopupMenu({
    super.key,
    required this.onPlaidSelected,
    required this.onBasiqSelected,
    required this.isLoading,
    this.icon,
  });

  final VoidCallback onPlaidSelected;
  final VoidCallback onBasiqSelected;
  final bool isLoading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              ),
            )
          : icon ?? const Icon(Icons.add),
      onSelected: (String value) {
        if (isLoading) return;

        if (value == 'plaid') {
          onPlaidSelected();
        } else if (value == 'basiq') {
          onBasiqSelected();
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'plaid',
          child: Text('Other Bank Accounts'),
        ),
        const PopupMenuItem<String>(
          value: 'basiq',
          child: Text('Connect to Australian bank account'),
        ),
      ],
      enabled: !isLoading,
    );
  }
}
