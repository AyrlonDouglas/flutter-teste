import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expenses/models/transaction.dart';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    final mediaQuery = MediaQuery.of(context);

    return MaterialApp(
      home: const MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18 * mediaQuery.textScaleFactor,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20 * mediaQuery.textScaleFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: Random().nextDouble().toString(),
        title: 'Água',
        value: 130.00,
        date: DateTime.now()),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Energia',
      value: 150.76,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Restaurante',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Mercado',
      value: 415.66,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Loja',
      value: 45.66,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Foto',
      value: 5.98,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Celular',
      value: 86,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];
  bool _showChart = true;
  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _openTrasactionFormModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(onPressed: fn, icon: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = [
      if (isLandScape)
        _getIconButton(
            _showChart ? iconList : iconChart,
            () => setState(() {
                  _showChart = !_showChart;
                })),
      _getIconButton(Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _openTrasactionFormModal(context)),
    ];
    final appBar = AppBar(
      title: const Text('Despesas pessoais'),
      actions: actions,
    );
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandScape)
              SizedBox(
                height: availableHeight * (isLandScape ? 0.7 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandScape)
              SizedBox(
                height: availableHeight * (isLandScape ? 1 : 0.7),
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas pessoais'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: actions),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                    ),
                    onPressed: () => _openTrasactionFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
