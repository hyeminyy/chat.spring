<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <meta charset="UTF-8">
    <title>채팅 WEB</title>
    <style>
        body {
            background-color: #f2f2f2;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .chat-container {
            background-color: #f2f2f2;
            border: 1px solid #ddd;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        .chat-header {
            background-color: #00a8ff;
            color: #fff;
            padding: 10px;
            text-align: center;
            font-weight: bold;
            border-bottom: 1px solid #ddd;
        }

        .chat-messages {
            max-height: 400px;
            overflow-y: auto;
            padding: 10px;
        }

        .message {
            border-radius: 10px;
            padding: 1px;
            margin: 1px 0;
            position: relative;
        }

        .message.sent .message-text {
            background-color: #007bff; /* You가 보낸 메시지 배경색 */
            color: #fff;
            margin-left: auto;
            border-top-right-radius: 0;
        }

        .message.received .message-text {
            background-color: #fff; /* Friend가 보낸 메시지 배경색 */
            color: #000;
            margin-right: auto;
            border-top-left-radius: 0;
        }

        .message .message-text {
            margin: 0;
            padding: 10px;
            border-radius: 10px;
            margin: 10px 0;
        }

        .message .message-sender {
            font-size: 12px;
            color: #777;
            padding: 2px 8px;
            border-radius: 5px;
            display: none;
        }

       .message-input {
    background-color: #fff;
    border-radius: 15px;
    margin-top: 20px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
}

.message-input input[type="text"] {
    flex-grow: 1;
    border: none;
    padding: 10px;
    border-radius: 15px;
    outline: none; 
}

.message-input button {
    border: none;
    background-color: #00a8ff;
    color: #fff;
    padding: 10px 20px;
    border-radius: 15px;
    cursor: pointer;
    outline: none; 
}

    </style>
</head>

<script type="text/javascript">
    var ws;

    function wsOpen() {
        ws = new WebSocket("ws://" + location.host + "/chating");
        wsEvt();
    }

    function wsEvt() {
        ws.onopen = function (data) {
            // 소켓이 열리면 초기화 세팅
        }

        ws.onmessage = function (data) {
            var msg = data.data;
            if (msg != null && msg.trim() != '') {
                appendMessage(msg);
            }
        }

        document.addEventListener("keypress", function (e) {
            if (e.keyCode == 13) {
                send();
            }
        });

    }

    function chatName() {
        var userName = $("#userName").val();
        if (userName == null || userName.trim() == "") {
            alert("사용자 이름을 입력해주세요.");
            $("#userName").focus();
        } else {
            wsOpen();
            $("#yourName").hide();
            $("#yourMsg").show();
        }
    }

    function send() {
        var uN = $("#userName").val();
        var msg = $("#chatting").val();
        ws.send(uN + " : " + msg);
        $('#chatting').val("");
    }

    function appendMessage(message) {
        var chatMessages = $(".chat-messages");
        var messageDiv = $("<div class='message'></div>");
        var messageText = $("<p class='message-text'></p>").text(message);
        var messageSender = $("<p class='message-sender'></p>");

        if (message.startsWith("You")) {
            messageText.css({
                backgroundColor: "#007bff",
                color: "#fff"
            });
        } else {
            messageText.css({
                backgroundColor: "#fff",
                color: "#000"
            });
        }

        messageDiv.append(messageSender);
        messageDiv.append(messageText);
        chatMessages.append(messageDiv);
        chatMessages.scrollTop(chatMessages[0].scrollHeight);
    }
</script>

<body>
    <div class="container">
        <div class="chat-container">
            <div class="chat-header">
                cahtting !!
            </div>
            <div class="chat-messages">
            </div>
            <div id="yourName">
                <table class="table table-bordered">
                    <tr>
                        <th>닉네임</th>
                        <td><input class="form-control form-control-sm" type="text" name="userName" id="userName"></td>
                        <td><button class="btn btn-sm btn-primary" onclick="chatName()" id="startBtn">시작</button></td>
                    </tr>
                </table>
            </div>
            <div id="yourMsg" style="display: none;">
                <div class="message-input">
                    <input class="form-control form-control-sm" id="chatting" placeholder="메시지를 입력하세요">
                    <button class="btn btn-sm btn-primary" onclick="send()" id="sendBtn">보내기</button>
                </div>
            </div>
        </div>
    </div>
</body>

</html>







