import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transactions.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:expenses/widgets/user_transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransaction = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 69.69, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'New RTX 3080ti VGA',
    //     amount: 39.69,
    //     date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String Txtitle, double Txamount) {
    final newTX = Transaction(
        id: DateTime.now().toString(),
        title: Txtitle,
        amount: Txamount,
        date: DateTime.now());

    setState(() {
      _usertransaction.add(newTX);
    });
  }

  @override
  Widget build(BuildContext context) {
    void _startAddNewTransaction(BuildContext ctx) {
      showModalBottomSheet(
          context: ctx,
          builder: (bCtx) {
            return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_usertransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
