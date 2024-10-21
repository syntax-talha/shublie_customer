import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shublie_customer/api/api_service.dart'; // Import API service
import 'package:shublie_customer/api/auth_service.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/components/x_heading.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/utils/configs.dart';
import 'package:shublie_customer/utils/validation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final String receiverId; // Use final to ensure it's assigned once
  final String name; // Use final to ensure it's assigned once

  ChatScreen({Key? key, required this.receiverId, required this.name})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<dynamic> messages = [];
  bool isLoading = true;
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late IO.Socket socket; // Add this line

  @override
  void initState() {
    super.initState();
    _initializeSocket(); // Initialize the socket connection
    _fetchMessages();
  }

  void _initializeSocket() {
    socket = IO.io(chatUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected to socket');
      // Emit an event to join the chat room
      socket.emit('join', auth.id!);
    });

    socket.on('message', (data) {
      print('Received message: $data');

      // Handle incoming messages
      setState(() {
        messages.add(data); // Add the new message to the list
      });
      _scrollToBottom(); // Scroll to the bottom when a new message arrives
    });

    socket.onDisconnect((_) => print('Disconnected from socket'));
  }

  Future<void> _fetchMessages() async {
    try {
      final response = await api.getMessages(widget.receiverId);
      if (response.statusCode == 200) {
        setState(() {
          messages = jsonDecode(response.body);
          isLoading = false;
        });
        _scrollToBottom();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _sendMessage(String content) async {
    if (content.isNotEmpty) {
      // Emit the message to the server
      socket.emit('send_message', {
        'receiver_id': widget.receiverId,
        'content': content,
        'sender_id': auth.id!,
      });
      setState(() {
        messages.add({
          'receiver_id': widget.receiverId,
          'content': content,
          'sender_id': auth.id!,
        }); // Add the new message to the list
      });
      if (content.isNotEmpty) {
        // Here you would call your API to send the message
        final response = await api.sendMessage(widget.receiverId, content);
        print(response.body);
        if (response.statusCode == 200) {
          messageController.clear(); // Clear input field after sending
        }
      }

      messageController.clear(); // Clear input field after sending
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    socket.dispose(); // Disconnect the socket
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                _showProfileImage(context);
              },
              child: CircleAvatar(
                radius: 16.0,
                backgroundImage: AssetImage('assets/images/profile-1.png'),
              ),
            ),
            SizedBox(width: 4.0),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              XHeading(
                text: widget.name,
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.green, size: 10.0),
                  SizedBox(width: 4.0),
                  XText(
                    text: 'Online',
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ])
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0.0,
        leadingWidth: 40,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final messageData = messages[index];
                      bool isMe = (messageData['sender_id'] == auth.id!);
                      return ChatBubble(
                        message: messageData['content'] ?? "",
                        isMe: isMe,
                        timestamp: formatTimestamp(messageData['created_at'] ??
                            "2024-09-28T09:21:15.000000Z"),
                        imageUrl: isMe
                            ? 'assets/images/profile.png'
                            : 'assets/images/profile-1.png',
                      );
                    },
                  ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          CircleAvatar(
            radius: 24.0,
            backgroundColor: primaryColor,
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () {
                _sendMessage(messageController.text);
                _scrollToBottom();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showProfileImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset(
                    'assets/images/profile-1.png'), // Add your profile image
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String timestamp;
  final String imageUrl;

  ChatBubble({
    required this.message,
    required this.isMe,
    required this.timestamp,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage(imageUrl),
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 6.0),
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color:
                      isMe ? primaryColor.withOpacity(0.85) : Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isMe ? 15 : 0),
                    topRight: Radius.circular(isMe ? 0 : 15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: XText(
                  text: message,
                  fontSize: 14.0,
                  color: isMe ? Colors.white : Colors.black87,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: isMe ? 0 : 12.0, right: isMe ? 12.0 : 0),
                child: XText(
                  text: timestamp,
                  fontSize: 10.0,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        if (isMe)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage(imageUrl),
            ),
          ),
      ],
    );
  }
}
