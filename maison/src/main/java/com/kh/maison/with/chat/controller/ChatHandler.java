package com.kh.maison.with.chat.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.maison.with.model.service.WithBoardService;
import com.kh.maison.with.model.vo.WithAsk;

@Controller
@Component
public class ChatHandler extends TextWebSocketHandler {
	
	private static List<WebSocketSession> list = new ArrayList<WebSocketSession>();
	
	@Autowired
	private WithBoardService service;
	
	private int realNo;
	
	@RequestMapping("/with/msgData.do")
	@ResponseBody
	public int withMsgData(@RequestParam int wbNo) {
		realNo = wbNo;
		return 1;
	}
	
	//클라이언트가 접속 했을 때 호출될 메소드 
	@Override 
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		list.add(session);
		System.out.println("하나의 클라이언트가 연결됨");
	}
	
	//클라이언트가 메시지를 보냈을 때 호출되는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session,
	TextMessage message) throws Exception{
		// 전송된 메시지를 List의 모든 세션에 전송
		
		String msg = message.getPayload();
		for(WebSocketSession s : list) {
			
				s.sendMessage(new TextMessage(session.getAcceptedProtocol()+msg));
				if(msg.contains(":")) {
					int target = msg.indexOf(":");
					//:를 기준으로 +1만큼 뒤에랑 앞에 가져오는데. 
					String id = msg.substring(0,target-1);
					String content = msg.substring(target+2); 
					
					//클래스변수로 선언한 realNo, id, content를 가지고 삽입을 하자.
					WithAsk wa = new WithAsk();
					wa.setWbNo(realNo);
					wa.setMemberId(id);
					wa.setWaContent(content);
					service.insertWithask(wa);
				}	
				
		}
	}
	
	//클라이언트의 접속이 해제 되었을 때 호출되는 메소드 
	@Override
	public void afterConnectionClosed(WebSocketSession session,
			CloseStatus status) throws Exception {
		System.out.println("클라이언트와 연결 해제됨");
		list.remove(session);
	}

}
