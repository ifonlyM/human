package co.kr.humankdh.service;

import java.util.List;

import org.springframework.stereotype.Repository;

import co.kr.humankdh.domain.Criteria;
import co.kr.humankdh.domain.MemberVo;

//@Repository
public interface MemberService {
	
	int login(String id, String pwd);
	
	int idChk(String id);

	void certifiedPhoneNumber(String phoneNumber, String numStr);
	
	List<MemberVo> getList(Criteria cri);
	
	int getTotal(Criteria cri);
	
	void remove(String userid);
	
	MemberVo get(String userid);
	
	void modify(MemberVo memberVo);
	
	void register(MemberVo memberVo);
	
	void registerAdmin(MemberVo memberVo);
	
	int findId(String id);
	
	String equalPwd(String numStr, String pwd);
	
}
