void starkStart() {
  print("started main");
  functionOne();
  print("finished main");
}

void functionOne() {
  print("started F01");
  try {
  functionTwo();
  } catch (exception, stackTrace) {
    print(exception);
    print(stackTrace);
    rethrow;
  } finally {
    print("chegou no finally");
  }
  print("finished F01");
}

void functionTwo() {
  print("started F02");
  for(int i = 1; i<= 5; i++){
    print(i);
    double amount = double.parse("Not a number");
    
  }

  print("finshed F02");
}
