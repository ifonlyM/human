package co.kr.humankdh.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data @AllArgsConstructor
public class ReplyCriteria extends Criteria {
	private long lastRno = 0L;
	
	public ReplyCriteria() {
		this(10);
	}
	
	public ReplyCriteria(int amount) {
		setAmount(10);
	}
	
	public ReplyCriteria(Long lastBno, int amount) {
		this(lastBno);
		setAmount(amount);
	}
}
