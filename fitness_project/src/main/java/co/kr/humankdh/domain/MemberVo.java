package co.kr.humankdh.domain;

import java.util.List;  

import org.apache.ibatis.type.Alias;

import lombok.Data;



@Data @Alias("member")
public class MemberVo { 
	// varchar2 : id, pwd, name, phone, address, email
	// number : height, weight
	// char : gender, category, rating
	// 기본정보
	private String userid;
	private String userpw;
	private String userName;
	private String gender;
	private String phone;
	private String email;
	// 추가정보
	private String address;
	private String category;
	private String rating;
	private Integer height;
	private Integer weight;
	private String auth;
	
	
	private boolean enabled;
	
	private List<AuthVo> auths;
	
}
