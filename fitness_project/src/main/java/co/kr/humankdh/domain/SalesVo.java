package co.kr.humankdh.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data @Alias("sales")
public class SalesVo {
	private Long sno;
	private	String id;
	private String name;
	private Long cost;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date buydate;
	private String trainer;
	private String buycontent;
	private String	payment;
}
