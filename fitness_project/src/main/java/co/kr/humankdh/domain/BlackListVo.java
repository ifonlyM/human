package co.kr.humankdh.domain;

import java.time.LocalDate;
import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data @Alias("blacklist")

public class BlackListVo {
	
	private Long blackno;
	private	String id;
	
	private LocalDate start_date;
	
	private LocalDate end_date;

	private Integer term;
	private String resson;
	
}
