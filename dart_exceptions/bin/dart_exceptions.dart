import 'dart:math';
import 'controllers/bank_controller.dart';
import 'exceptions/bank_controller_exception.dart';
import 'models/account.dart';

void testingNullSafety() {
  Account? myAccount = Account(name: "Lucas", balance: 100, isAuthenticated: true);

  //Simulando uma comunicação externa
  Random rng = Random();

  int randomNumber = rng.nextInt(10);

  if(randomNumber <=5) {
    myAccount.createdAt = DateTime.now();
    if(myAccount.createdAt !=null) {
      print(myAccount.createdAt!.day);
    }
  }

  print(myAccount.runtimeType);
  print(myAccount.createdAt);

  //forma segura de lidar com o null
  if(myAccount != null) {
    print(myAccount.balance);
  }else {
    print("Conta nula");
  }

  //Conversão direta: má prática
  // print(myAccount!.balance);


  //Mesmo tratamento porem com operador ternário.
  print(myAccount != null ? myAccount.balance : "conta nula");


  //Chamada segura é um metodo do print, caso não tenha valor ele printa "null"
  //print(myAccount?.balance);

}

void main() {
  testingNullSafety();

  // Criando o banco
  BankController bankController = BankController();

  // Adicionando contas
  //Account accountTest = Account(name: "Ricarth", balance: -20, isAuthenticated: true);
  bankController.addAccount(
      id: "Ricarth",
      account:
          Account(name: "Ricarth Lima", balance: 400, isAuthenticated: true));

  bankController.addAccount(
      id: "Kako",
      account:
          Account(name: "Caio Couto", balance: 600, isAuthenticated: true));

  // Fazendo transferência
  try {
    bool result = bankController.makeTransfer(
    idSender: "Kako", idReceiver: "Ricarth", amount: 1000);

    // Observando resultado
    if(result){
      //print("Transação concluída com sucesso!");
    }
  } on SenderIdInvalidException catch(e) {
    print(e);
    print("o ID '${e.idSender}' do remetente não é um ID válido");
  } on ReceiverIdInvalidException catch(e) {
    print(e);
    print("o ID '${e.idReceiver}' do destinatario não é um ID válido");
  } on SenderNotAuthenticatedException catch(e) {
    print(e);
    print("O usuario remetente '${e.idSender}' não está autenticado");
  } on SenderBalanceLowerThanAmountException catch(e) {
    print(e);
    print("O usuário de ID '${e.idSender}' tentou enviar ${e.amount} sendo que na sua conta tem apenas ${e.senderBalance}");
  } on Exception {
    print("Algo deu errado!");
  }

}
