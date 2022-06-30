import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList({Key? key, required this.transactions, required this.deleteTx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size.width;
    return transactions.isEmpty
        ? LayoutBuilder(
          builder:(ctx, height)=> Column(
      children: <Widget>[
          Text(
            'No transactions added yet!',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: height.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              )),
      ],
    ),
        )
        : ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                  child: Text('\$${transactions[index].amount}'),
                ),
              ),
            ),
            title: Text(
              transactions[index].title,
              style: Theme.of(context).textTheme.headline3,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(transactions[index].date),
            ),
            trailing: mq > 360 ?
            TextButton.icon(
              icon: Icon(Icons.delete, color: Theme.of(context).errorColor,),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
              ),
              label: const Text(
                'Delete',
              ),
              onPressed: () => deleteTx(transactions[index].id),
            )
              :
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => deleteTx(transactions[index].id),
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
