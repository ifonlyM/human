package co.kr.humankdh.service;

import java.util.HashMap;
import java.util.List;
import org.json.simple.JSONObject;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.kr.humankdh.domain.Criteria;
import co.kr.humankdh.domain.MemberVo;
import co.kr.humankdh.mapper.MemberMapper;
import co.kr.humankdh.mapper.PTreserveMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

//@Repository
@Service
@Log4j
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	private MemberMapper memberMapper;
	private PTreserveMapper ptMapper;
	private PasswordEncoder encoder;
	
	// 로그인
	@Override
	public int login(String id, String pwd) {
		// TODO Auto-generated method stub
		return memberMapper.memberLogin(id, pwd);
	}
	// 아이디 중복검사
	public int idChk(String memberId) {
		int result = memberMapper.idChk(memberId);
		return result;
	}

	// 문자보내기
	@Override
	public void certifiedPhoneNumber(String phoneNumber, String numStr) {
		// TODO Auto-generated method stub
		String api_key = "NCSUIPGSJWXJ7ZPU";
	    String api_secret = "GDRIM7P3YPZBQ53U3ZZVATUXGVPPPOUX";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phoneNumber);
	    params.put("from", "01041511531");
	    params.put("type", "SMS");
	    params.put("text", "FITNESS 인증번호를 입력해주세요.[ " + numStr + " ]");
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
//	      System.out.println(obj.toString());
	      log.info(obj.toString());
	    } catch (CoolsmsException e) {
//	      System.out.println(e.getMessage());
	      log.info(e.getMessage());
//	      System.out.println(e.getCode());
	      log.info(e.getCode());
	    }
	}

	// 회원가입
	@Override 
	public void register(MemberVo vo) {
		vo.setUserpw(encoder.encode(vo.getUserpw()));
		memberMapper.insertMember(vo);
		if(vo.getUserid().contains("admin")){
			memberMapper.insertAuth(vo.getUserid(), "ROLE_ADMIN");
		}
		else{
			memberMapper.insertAuth(vo.getUserid(), "ROLE_USER");			
		}
		
	}

	// 회원 목록조회
	@Override
	public List<MemberVo> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return memberMapper.getListWithPaging(cri);
	}
	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return memberMapper.getTotalCount(cri);
	}
	
	// 회원 탈퇴
	@Override @Transactional
	public void remove(String userid) {
		// TODO Auto-generated method stub
		memberMapper.authdeletebyAdmin(userid);
		ptMapper.deleteAllCareer(userid);
		
		for(int s = 0 ;s<memberMapper.findBNObyALL(userid).size(); s++){
			int bno = memberMapper.findBNObyALL(userid).get(s);
			memberMapper.deletereplyAll(bno);
			
		}
		memberMapper.deleteboardAll(userid);
	
		
		memberMapper.delete(userid);
		
	}
	// 회원 조회
	@Override
	public MemberVo get(String userid) {
		// TODO Auto-generated method stub
		return memberMapper.read(userid);
	}
	// 정보 수정
	@Override
	public void modify(MemberVo memberVo) {
		// TODO Auto-generated method stub
		memberMapper.update(memberVo);
		memberMapper.authupdate(memberVo);
	}
	
	//관리자가 회원등록
	@Override
	public void registerAdmin(MemberVo memberVo) {
		// TODO Auto-generated method stub
		memberMapper.insertMemberbyAdmin(memberVo);
		memberMapper.insertAuthByAdmin(memberVo);
		
	}
	
	// 아이디 찾기
	@Override
	public int findId(String id) {
		return memberMapper.findId(id);
	}
	// 인증번호를 비밀번호와 같게 만들기
	@Override
	public String equalPwd(String numStr, String pwd) {
		memberMapper.updatePw("userid", equalPwd(numStr, pwd)); 
		return "";
	}
	
	// 비밀번호 변경
	@Override
	public void setPw(String userid, String userpw) {
		userpw = encoder.encode(userpw);
		memberMapper.updatePw(userid, userpw);
	}
}
