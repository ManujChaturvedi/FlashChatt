import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

final _fireStore= FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  //No need to create a object to use the id because it is now a static field i.e it's same for all the instances of class.
  static const String id = "Chat_Screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;
  //firebase user changed to just user.

  void getCurrentUser() async {

    //gets the current user from auth object . No longer returns a future,
      final user= _auth.currentUser;
      try{
        if(user!=null) loggedInUser=user;
        print(loggedInUser.email);
        // print(loggedInUser);
    }catch(e){
        print(e);
    }
  }

  // void getMessages() async{
  //
  //   final messages=_firestore.collection('messages').get();
  //
  //   messages.then((value){
  //     for (var message in value.docs){
  //       print(message.data());
  //     }
  //   } );

  void getMessagesStream() async {
    // access the correct collection with the name, then get the bunch of query snapshots , we can listen to changes with the help of this
    await for(var snapshot in _fireStore.collection('messages').snapshots()){
      for(var messages in snapshot.docs){
        print(messages.data());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implemented logout functionality
                // getMessagesStream();
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Did something with the user input.
                        messageText=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      messageTextController.clear();
                      _fireStore.collection('messages').add({'text':messageText,'sender':loggedInUser.email});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('messages').snapshots(),
        builder: (context,snapshots){
          List<MessageBubble> messageWidgetList = [];
          if(snapshots.hasData){
            // messages = a list of query document snapshot.
            if(!snapshots.hasData){
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
              );
            }

            final messages=snapshots.data.docs.reversed;
            for(var message in messages){
              final messageText = message.data()['text'];
              final messageSender = message.data()['sender'];
              // to check if you are sending the message or not ??
              final currentUser=loggedInUser;
              final messageWidget=MessageBubble(sender: messageSender,text: messageText,isItMe: currentUser.email==messageSender,);
              messageWidgetList.add(messageWidget);
            }
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              children: messageWidgetList,
            ),
          );
        });
  }
}



class MessageBubble extends StatelessWidget {

  final String text;
  final String sender;
  final bool isItMe;

  MessageBubble({this.text, this.sender,this.isItMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isItMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender,style: TextStyle(color: Colors.white),),
          Material(borderRadius: BorderRadius.only(
              topLeft: isItMe?Radius.circular(30):Radius.circular(0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topRight: isItMe?Radius.circular(0):Radius.circular(30.0),
          ),
            color: isItMe?Colors.white:Colors.lightBlueAccent,child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text('$text',style: TextStyle(color: isItMe?Colors.black:Colors.black,fontSize: 15.0),),
          ),),
        ],
      ),
    );
  }
}
