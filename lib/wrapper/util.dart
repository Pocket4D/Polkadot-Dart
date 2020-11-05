String throwReturn(String message) {
  if (message.startsWith("Error:")) {
    throw message;
  } else {
    return message;
  }
}
