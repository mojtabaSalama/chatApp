final url = "127.0.0.1:8000";

//user
final register = url + "/api/user/register";
final login = url + "/api/user/login";
final update = url + "/api/user/update";
final updateImage = url + "/api/user/updateImage";
final getUserById = url + "/api/user/get";
final removeUser = url + "/api/user/remove";

//messages

final sendMessageToUser = url + "/api/messages/sendToUser";
final sendTMessageoRoom = url + "/api/messages/sendToRoom";
final allMessagesUser = url + "/api/messages/AllMessagesUser";
final allMessagesRoom = url + "/api/messages/AllMessagesRoom";

//rooms
final createRoom = url + "/api/rooms/create";
final joinRoom = url + "/api/rooms/join";
final infoRoom = url + "/api/rooms/info";
final leaveRoom = url + "/api/rooms/leave";
