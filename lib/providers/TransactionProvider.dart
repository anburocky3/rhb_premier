import 'package:flutter/material.dart';
import 'package:rhb_premier/models/Transaction.dart';
import 'package:rhb_premier/providers/AuthProvider.dart';
import 'package:rhb_premier/services/api.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transaction = [];
  late ApiService apiService;
  late AuthProvider authProvider;
  bool _isLoaded = false;

  TransactionProvider(AuthProvider authProvider){
    this.authProvider = authProvider;

    resetOnLoad();
  }

  bool get isLoaded => _isLoaded;

  List<Transaction> get transactionList => _transaction;

  setTransactionList(List<Transaction> transaction){
    _transaction = transaction;
    _isLoaded = true;
    notifyListeners();
  }

  resetOnLoad() {
    _isLoaded = false;
    _transaction = [];
    notifyListeners();
  }

}