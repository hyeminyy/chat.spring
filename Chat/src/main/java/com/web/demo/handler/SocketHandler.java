package com.web.demo.handler;

import java.util.HashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class SocketHandler extends TextWebSocketHandler{

	//웹 소켓 세션을 담아둘 맵
	HashMap<String, WebSocketSession> sessionMap = new HashMap<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//소켓 연결 시
		super.afterConnectionEstablished(session);
		sessionMap.put(session.getId(), session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		//소켓 종료 시
		sessionMap.remove(session.getId());
		super.afterConnectionClosed(session, status);
	}
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) {
	    // 메시지 발송 시
	    String msg = message.getPayload();
	    for (String key : sessionMap.keySet()) {
	        WebSocketSession wss = sessionMap.get(key);
	        try {
	            if (wss.isOpen()) { // 세션 열려 있는지 확인
	                wss.sendMessage(new TextMessage(msg)); // 메시지 전송
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}




}
