class AppStrings {
  ///====================== Initial ========================
  static const String signInAsWorker = "Sign in as a worker";
  static const String signInAsClient = "Sign in as a client";

  ///====================== Auth ========================
  static const String signUp = "Sign Up";
  static const String email = "Email";
  static const String screen = "screen";

  static const String chooseARole = "Choose a role";

  static const String enterValidEmail = "Enter a valid email";
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String password = "Password";
  static const String passWordMustBeAtLeast =
      "Password must contain at least one uppercase letter, one lowercase letter, one number";
  static RegExp passRegexp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  static const fieldCantNotBeEmpty = "Field can't be empty";
  static const String passwordLengthAndContain =
      "Password must be at least 8 characters long and at least one uppercase letter, one lowercase letter, one number";
  static const String confirmPassword = "Confirm Password";
  static const String byRegistering = "By registering you are agree to our";
  static const String termsOfUse = "terms of use";
  static const String and = "and";
  static const String privacyPolicy = "privacy policy";
  static const String login = "Login";
  static const String phnNumber = "Phome Number";

  static const String forgot = "Forgot";
  static const String alreadyHaveaAccount = "Already have a account?";
  static const String verification = "Verification";

  static const String client = "Client";
  static const String worker = "Worker";
  static const String workingTime = "Working Time";

  static const String enterVerificationCode = "Enter verification code";
  static const String resend = "resend";
  static const String didntRecieveAnyCode = "Didn't recieved any code?";
  static const String go = "Go";
  static const String rememberMe = "Remember me";
  static const String forgotPassword = "Forgot password";
  static const String dontWorryItOccurs =
      "Don’t worry! It Occurs. Please enter the email address linked with your account.";
  static const String sendCode = "Send Code";
  static const String verify = "Verify";
  static const String submit = "Submit";
  static const String dontHaveAAccount = "Don’t have a account? Sign up";

  ///====================== SubsCription ========================
  static const String subscription = "Subscription";
  static const String mySubscription = "My Subscription";
  static const String subscriptionPackages = "Subscription Packages";
  static const String buyNow = "Buy Now";
  static const String payment = "SubPaymentmit";
  static const String paymentOptions = "Payment Options";
  static const String applePay = "Apple pay";
  static const String pay = "Pay";
  static const String confirmPayment = "Confirm Payment";

  static const String couponCode = "Coupon Code";
  static String ifYouUseOurCouponCode(
          {required String price, required String percentage}) =>
      "If you use our coupon code on your total price of $price, you will get $percentage discount.";
  static const String applyCouponCode = "Apply Coupon Code";
  static const String enterYourCouponCode = "Enter your coupon code";

  static const String applyCouponCodeAndPay = "Apply coupon code";

  static String totalPrice({required String price}) => "Total Price $price";
  static const String dontHaveACouponCode =
      "Don’t have coupon code? Go to the Payment";
  static const String apply = "Apply";
  static const String location = "Location: ";
  static const String mapView = "Map View";

  static const String subsCriptionBuying = "Subscription buying";
  static const String subsCriptionEnding = "Subscription ending";
  static const String package = "Package";
  static const String service = "Service";

  ///====================== Home ========================
  static const String orderHistory = "Order History";
  static const String language = "Language";
  static const String chooseALanguage = "Choose a language";

  static const String searchhere = "Search here";
  static const String newOrder = "New Order";
  static const String reload = "Reload";

  static const String spam = "Spam";
  static const String total = "Total";
  static const String taken = "Taken";
  static const String remains = "Remains";
  static const String upcomingDate = "Upcoming";
  static const String current = "Current";
  static const String completed = "Completed";
  static const String reqService = "Request service";
  static const String request = "Request";

  static const String logOut = "Log Out";

  static const String nextDate = "Next Date";
  static const String time = "Time: ";
  static const String addDate = "Add Date";
  static const String noDataFound = "No Data Found";

  static const String history = "History";
  static const String english = "English";
  static const String arabic = "Arabic";

  static const String readAll = "Read all";

  static const String carWashingService = "Car Washing Service";
  static const String cancel = "Cancel";
  static const String start = "Start";
  static const String date = "Date: ";

  static const String contactNumber = "Contact Number: ";
  static const String address = "Address";
  static const String dateOfBirth = "Date of Birth";

  static const String description = "Description:  ";
  static const String startWork = "Start Work";
  static const String startTime = "Start Time";
  static const String endTime = "End Time";
  static const String beforeCleaning = "Before Cleaning";
  static const String afterCleaning = "After Cleaning";
  static const String endWork = "End Work";
  static const String subscribeToGetStarted = "Subscribe to get started";

  ///====================== Profile ========================
  static const String profile = "Profile";
  static const String name = "Name";
  static const String updateProfile = "Update Profile";

  static const String editProfile = "Edit Profile";

  ///====================== Notification ========================
  static const String notification = "Notification";
  static String youHaveNewNotifications({required String count}) =>
      "You have $count new Notifications";

  ///====================== Role ========================
  static const String roleCLIENT = "CLIENT";
  static const String roleWORKER = "WORKER";
}
