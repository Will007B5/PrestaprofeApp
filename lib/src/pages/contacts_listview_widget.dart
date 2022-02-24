import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsListview extends StatelessWidget {

  final List<Contact> contactsList;
  final double textWidth;

  const ContactsListview({
    Key? key, 
    required this.contactsList, 
    required this.textWidth
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final filteredList = contactsList.where((contact){
      return contact.givenName != null && contact.phones!.length > 0;
    }).toList();

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: FittedBox(fit: BoxFit.fitWidth, child: Text('CONTACTOS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: this.textWidth))),
        ),
        body: ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: ( BuildContext context, int index ) => GestureDetector(
            child: ListTile(
              title: Text('${filteredList[index].displayName}'),
              subtitle: Text('${filteredList[index].phones![0].value}'),
              onTap: (){
                Navigator.pop(context, filteredList[index]); //Le mandamos al pop como parametro el contacto
              },
            )
          ),
        ),
      ),
    );
  }
  //contactsList[index].phones![0].value
}