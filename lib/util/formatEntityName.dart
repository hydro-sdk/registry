String formatEntityName(String str) =>
    str.trim().split(RegExp("\\s")).join("-").toLowerCase();
