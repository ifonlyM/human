package co.kr.humankdh.security.domain;

import java.util.stream.Collectors; 

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import co.kr.humankdh.domain.MemberVo;
import lombok.Getter;

@Getter
public class CustomUser extends User{
	private MemberVo member;
	
	public CustomUser(MemberVo vo) {
		super(vo.getUserid(), vo.getUserpw(),
				vo.getAuths()
				.stream()
				.map(a -> new SimpleGrantedAuthority(a.getAuth()))
				.collect(Collectors.toList()));
		
		this.member = vo;
	}
}
