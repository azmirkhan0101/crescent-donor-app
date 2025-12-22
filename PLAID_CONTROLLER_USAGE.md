# PlaidController Usage Guide

The `PlaidController` is now a reusable controller that handles all Plaid Link integration. You can use it from any page to connect bank accounts.

## Basic Usage

### 1. Import and Initialize

```dart
import 'package:cresent_charge_user_app/features/donation/controllers/plaid_controller.dart';
import 'package:get/get.dart';

class YourPage extends StatefulWidget {
  @override
  State<YourPage> createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  final plaidCtrl = Get.put(PlaidController());
  
  @override
  void initState() {
    super.initState();
    
    // Optional: Set up custom callbacks
    plaidCtrl.onSuccessCallback = (event) {
      // Handle successful bank connection
      print('Bank connected successfully!');
      // Refresh your bank accounts list or navigate
    };
    
    plaidCtrl.onExitCallback = (event) {
      // Handle user exit
      print('User exited Plaid Link');
    };
  }
  
  @override
  void dispose() {
    // Optional: Clear callbacks when leaving page
    plaidCtrl.clearCallbacks();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect Bank Account'),
      ),
      body: Center(
        child: Obx(() {
          return ElevatedButton(
            onPressed: plaidCtrl.isLoadingConfiguration.value
                ? null
                : () => plaidCtrl.createLinkTokenConfiguration(),
            child: plaidCtrl.isLoadingConfiguration.value
                ? CircularProgressIndicator()
                : Text('Connect Bank Account'),
          );
        }),
      ),
    );
  }
}
```

## Features

### Automatic Bank Connection

The controller automatically:

- Generates a Plaid link token
- Creates the link configuration
- Opens the Plaid Link UI
- Handles the public token exchange
- Connects the bank account via API
- Refreshes connected accounts list

### Custom Callbacks

You can set custom callbacks for different events:

```dart
// Success callback - called after bank is successfully connected
plaidCtrl.onSuccessCallback = (LinkSuccess event) {
  print('Public Token: ${event.publicToken}');
  // Navigate or update UI
  context.push('/success');
};

// Exit callback - called when user exits without completing
plaidCtrl.onExitCallback = (LinkExit event) {
  final error = event.error?.description();
  if (error != null) {
    print('Error: $error');
  }
};

// Event callback - called for various Plaid events
plaidCtrl.onEventCallback = (LinkEvent event) {
  print('Event: ${event.name}');
};
```

### Loading States

Monitor the loading state:

```dart
Obx(() {
  if (plaidCtrl.isLoadingConfiguration.value) {
    return CircularProgressIndicator();
  }
  
  if (plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading) {
    return Text('Generating link token...');
  }
  
  return ElevatedButton(
    onPressed: () => plaidCtrl.createLinkTokenConfiguration(),
    child: Text('Connect Bank'),
  );
})
```

## Example: Payment Settings Page

```dart
class PaymentSettingsPage extends StatefulWidget {
  @override
  State<PaymentSettingsPage> createState() => _PaymentSettingsPageState();
}

class _PaymentSettingsPageState extends State<PaymentSettingsPage> {
  final plaidCtrl = Get.put(PlaidController());
  final bankAccountsCtrl = Get.put(GetConnectedBankAccounts());
  
  @override
  void initState() {
    super.initState();
    
    // Load existing accounts
    bankAccountsCtrl.getConnectedBankAccounts();
    
    // Refresh list after successful connection
    plaidCtrl.onSuccessCallback = (event) {
      bankAccountsCtrl.getConnectedBankAccounts();
      ToastMsg.success('Bank account connected successfully!');
    };
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Settings'),
        actions: [
          // Add bank account button
          Obx(() {
            return IconButton(
              icon: plaidCtrl.isLoadingConfiguration.value
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.add),
              onPressed: () => plaidCtrl.createLinkTokenConfiguration(),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (bankAccountsCtrl.isBankConnectionLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        
        final accounts = bankAccountsCtrl.connectedAccountsDataModel;
        
        if (accounts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No bank accounts connected'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => plaidCtrl.createLinkTokenConfiguration(),
                  child: Text('Connect Bank Account'),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            final account = accounts[index];
            return ListTile(
              title: Text(account.accountName),
              subtitle: Text(account.institutionName),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            );
          },
        );
      }),
    );
  }
}
```

## Controller Structure

### PlaidController Methods

- `createLinkTokenConfiguration()` - Main method to start Plaid Link flow
- `openLink()` - Opens Plaid Link UI (called automatically)
- `clearCallbacks()` - Clears all custom callbacks

### PlaidController Properties

- `isLoadingConfiguration` (RxBool) - True when creating Plaid configuration
- `configuration` (LinkTokenConfiguration?) - Current link configuration
- `successObject` (LinkObject?) - Success event data
- `createPlaidTokenCtrl` - Access to token generation controller
- `bankConnectionController` - Access to bank connection controller

### Callbacks

- `onSuccessCallback` - Called when bank link succeeds
- `onExitCallback` - Called when user exits Plaid Link
- `onEventCallback` - Called for Plaid events

## Notes

- The controller automatically connects the bank after successful Plaid Link
- Bank accounts are automatically refreshed after connection
- The controller manages all Plaid event streams internally
- Dispose is handled automatically by GetX
