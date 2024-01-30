final url = "http://192.168.70.1:8000";
final ws = "ws://192.168.70.1:8080";

//user
final register = url + "/api/user/register";
final login = url + "/api/user/login";
final updateName = url + "/api/user/updateName";
final updatePassword = url + "/api/user/updatePassword";
final updateImage = url + "/api/user/updateImage";
final getUserById = url + "/api/user/get";
final removeUser = url + "/api/user/remove";
final getAllUsers = url + "/api/user/all";

//messages

final sendMessageToUser = url + "/api/messages/sendToUser";
final sendTMessageoRoom = url + "/api/messages/sendToRoom";
final allMessagesUser = url + "/api/messages/AllMessagesUser";
final allMessagesRoom = url + "/api/messages/AllMessagesRoom";

//rooms
final createRoom = url + "/api/room/create";
final joinRoom = url + "/api/room/join";
final infoRoom = url + "/api/room/info";
final allRooms = url + "/api/room/all";
final leaveRoom = url + "/api/room/leave";
