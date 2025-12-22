# Stripe Payment Method Integration

## Overview

This implementation adds Stripe card element integration to allow users to securely add payment cards to their account.

## Features Implemented

### 1. **Stripe Card Input UI**

- Custom card input page with Stripe CardField widget
- Real-time card validation
- Card holder name input
- Security indicator
- Loading states and error handling

### 2. **Backend Integration**

Two API endpoints integrated:

- `POST /payment-method/setup-intent` - Creates a setup intent for card payment
- `POST /payment-method` - Saves the payment method to the backend

### 3. **Payment Flow**

1. User clicks "Add Account" or "Add another account"
2. Stripe CardField is displayed for secure card input
3. On submit:
   - Setup intent is created from backend
   - Card is confirmed with Stripe
   - Payment method ID is sent to backend
   - Payment methods list is refreshed

## Files Created/Modified

### Created Files

1. `lib/features/organization/pages/add_card_page.dart` - Stripe card input page
2. `lib/features/organization/models/setup_intent_response.dart` - Setup intent response model
3. `lib/features/organization/models/add_payment_method_request.dart` - Payment method request model

### Modified Files

1. `lib/features/organization/controllers/payment_method_controller.dart`
   - Added `createSetupIntent()` method
   - Added `addPaymentMethod()` method
   - Added `setupCard()` method (orchestrates the full flow)
   - Added `isAddingCard` loading state

2. `lib/features/organization/pages/payment_linked_account_page.dart`
   - Converted from StatelessWidget to StatefulWidget
   - Updated "Add Account" button to navigate to new AddCardPage
   - Added GestureDetector to "Add another account" item

3. `lib/service/api_url.dart`
   - Added `createSetupIntent` endpoint
   - Added `addPaymentMethod` endpoint

4. `lib/main.dart`
   - Added Stripe initialization with publishable key

## Setup Instructions

### 1. Add Stripe Publishable Key

In `lib/main.dart`, replace the placeholder with your actual Stripe publishable key:

```dart
// For testing
Stripe.publishableKey = 'pk_test_YOUR_PUBLISHABLE_KEY';

// For production
Stripe.publishableKey = 'pk_live_YOUR_PUBLISHABLE_KEY';
```

Get your keys from: <https://dashboard.stripe.com/apikeys>

### 2. Test Card Numbers (Stripe Test Mode)

Use these test cards in test mode:

- **Success**: 4242 4242 4242 4242
- **Requires authentication**: 4000 0025 0000 3155
- **Declined**: 4000 0000 0000 9995

Any future expiry date and any 3-digit CVC will work.

## API Request/Response Examples

### Setup Intent Request

```http
POST /payment-method/setup-intent
Content-Type: application/json

{}
```

### Setup Intent Response

```json
{
  "success": true,
  "message": "Setup intent created successfully for card payment!",
  "data": {
    "client_secret": "seti_1SWwAMGWHt6mKfvJxJpyY99G_secret_...",
    "setup_intent_id": "seti_1SWwAMGWHt6mKfvJxJpyY99G"
  }
}
```

### Add Payment Method Request

```http
POST /payment-method
Content-Type: application/json

{
  "stripePaymentMethodId": "pm_1234567890abcdef",
  "cardHolderName": "John Doe",
  "isDefault": true
}
```

## Security Features

1. **PCI Compliance**: Card details never touch your server - handled entirely by Stripe
2. **Encrypted Communication**: All card data is encrypted by Stripe SDK
3. **Setup Intent**: Uses Stripe's setup intent for secure card verification
4. **Client Secret**: Temporary secret used only for this transaction

## User Flow

```
User clicks "Add Account"
        ↓
Add Card Page opens
        ↓
User enters card details
        ↓
User clicks "Add Card"
        ↓
Create Setup Intent (Backend)
        ↓
Confirm Card with Stripe (Frontend)
        ↓
Send Payment Method ID (Backend)
        ↓
Refresh Payment Methods
        ↓
Navigate back with success message
```

## Debug Mode Features

When running in debug mode (`kDebugMode`):

- Card holder name field is pre-filled with "John Doe"
- Console logs for all API operations
- Detailed error messages

## Error Handling

The implementation handles:

- Network errors
- Invalid card details
- API failures
- Stripe confirmation failures
- User-friendly error messages via snackbars

## Dependencies Added

```yaml
flutter_stripe: ^12.1.1  # Latest version
stripe_android: ^12.1.0
stripe_ios: ^12.1.0
stripe_platform_interface: ^12.1.1
```

## Testing Checklist

- [ ] Replace Stripe publishable key with your test key
- [ ] Test adding a card with test card number 4242 4242 4242 4242
- [ ] Verify card appears in payment methods list
- [ ] Test with invalid card number
- [ ] Test with incomplete card details
- [ ] Test error scenarios (network failure, etc.)
- [ ] Test on both iOS and Android

## Notes

- The old `AddCardPage` in `features/auth/pages/` is not modified and can be removed if no longer needed
- The new Stripe-enabled page is in `features/organization/pages/add_card_page.dart`
- Payment methods are automatically refreshed after successful card addition
- The implementation follows the project's GetX pattern and coding standards
