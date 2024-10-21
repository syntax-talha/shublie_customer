import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/components/x_heading.dart';
import 'package:shublie_customer/utils/images.dart';
import 'package:shublie_customer/utils/validation.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final double tilePadding = 8.0;
  final ApiService apiService = ApiService();
  List<dynamic> chats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchChats();
  }

  Future<void> _fetchChats() async {
    try {
      final response = await apiService.getChats();
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          chats = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _handleResponseError(response);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _handleUnexpectedError(e);
    }
  }

  void _handleResponseError(response) {
    if (response.statusCode == 422) {
      // Handle validation errors if needed
    } else {
      unexpectedResponse(response, context);
    }
  }

  void _handleUnexpectedError(error) {
    unexpectedError(context, error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: XHeading(
          text: 'Chat',
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : chats.isEmpty
              ? Center(child: Text('No chats available'))
              : ListView.separated(
                  itemCount: chats.length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, color: Colors.grey[300]),
                  itemBuilder: (context, index) {
                    final chat = chats[index] as Map<String, dynamic>;

                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: tilePadding / 2,
                        horizontal: tilePadding,
                      ),
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(default_user),
                            radius: 30,
                            backgroundColor: Colors.white,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: XHeading(
                        text: '${chat['first_name']} ${chat['last_name']}' ??
                            'Unknown',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: XText(
                              text: chat['last_message']["content"] ??
                                  'No message available',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8),
                          XText(
                            text: formatTimestamp(
                                chat['last_message']["created_at"] ?? ''),
                            color: Colors.grey[600],
                            fontSize: 12.0,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/chat-screen',
                          arguments: {
                            'receiverId': chat['id'].toString(),
                            'name':
                                '${chat['first_name']} ${chat['last_name']}' ??
                                    'Unknown',
                          }, // Pass email as argume, // Pass the receiver ID as argument
                        );
                      },
                    );
                  },
                ),
    );
  }
}
