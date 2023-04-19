import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/Chat%20Screen/chatRoom.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: apBarText('Chat', Colors.white),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ChatRoom();
              }));
            },
            child: ListTile(
              trailing: Text('9:10.AM'),
              subtitle: Text('Thanks'),
              leading: profilePic(),
              title: Text(
                'Username',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }

  Container profilePic() {
    return Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/icons/man.png'))));
  }
}
