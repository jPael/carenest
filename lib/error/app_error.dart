String errorMessage(String code) {
  String errorMessage = "An error occurred. Please try again.";

  switch (code) {
    case 'email-already-in-use':
      errorMessage = "The email address is already in use by another account.";
      break;
    case 'invalid-email':
      errorMessage = "The email address is invalid.";
      break;
    case 'weak-password':
      errorMessage = "The password is too weak.";
      break;
    case 'user-not-found':
      errorMessage = "No user found with this email address.";
      break;
    case 'wrong-password':
      errorMessage = "Incorrect password.";
      break;
    case 'too-many-requests':
      errorMessage = "Too many requests. Please try again later.";
      break;
    case 'operation-not-allowed':
      errorMessage = "This operation is not allowed.";
      break;
    default:
      errorMessage = "An unknown error occurred.";
      break;
  }

  return errorMessage;
}
