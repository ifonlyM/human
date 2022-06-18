package co.kr.humankdh.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data @Alias("reserve")
public class ReserveVo {
	private Long rno;
	private String trainerId;
	private String memberId;
	private String reserveDate;
	private String startTime;
	private String endTime;
}
