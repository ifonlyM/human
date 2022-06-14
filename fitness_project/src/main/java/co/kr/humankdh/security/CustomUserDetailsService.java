package co.kr.humankdh.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import co.kr.humankdh.domain.MemberVo;
import co.kr.humankdh.mapper.MemberMapper;
import co.kr.humankdh.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class CustomUserDetailsService implements UserDetailsService {
	@Autowired @Setter
	private MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String arg0) throws UsernameNotFoundException {
		log.warn(arg0);
		
		MemberVo vo = mapper.read(arg0);
		return vo == null ? null : new CustomUser(vo);
	}
}
