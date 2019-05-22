package ddit.finalproject.team2.student.controller.subjectpage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ddit.finalproject.team2.common.service.Ljs_IReplyService;
import ddit.finalproject.team2.util.enumpack.ServiceResult;
import ddit.finalproject.team2.vo.Ljs_ReplyVo;

@RestController
@RequestMapping("/{board_no}/reply")
public class ReplyRestController {
	@Inject
	Ljs_IReplyService service;
	
	@GetMapping(produces="application/json;charset=UTF-8")
	public Map<String, Object> getList(@PathVariable String board_no){
		Map<String, Object> map = new HashMap<>();
		List<Ljs_ReplyVo> list = service.retrieveReplyList(board_no);
		map.put("data", list);
		return map;
	}
	
	@PostMapping("create")
	public String newReply(@RequestBody Ljs_ReplyVo reply){
		String msg = "실패";
		ServiceResult result = service.createReply(reply);
		if(ServiceResult.OK.equals(result)){
			msg = "성공";
		}
		return msg;
	}
	
	@DeleteMapping("remove/{reply_no}")
	public String remove(@PathVariable String board_no, @PathVariable String reply_no){
		String msg = "실패";
		ServiceResult result = service.removeReply(reply_no);
		if(ServiceResult.OK.equals(result)){
			msg = "성공";
		}
		return msg;
	}
	
	@PutMapping("edit/{reply_no}")
	public String edit(@PathVariable String board_no, @PathVariable String reply_no){
		String msg = "실패";
		return msg;
	}
}
