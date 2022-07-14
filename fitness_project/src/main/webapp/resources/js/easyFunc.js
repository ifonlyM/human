/**
 * 2021-10-22 문현석 작성
 * 간단한 기능을 하는 함수들 모임
 */

//오늘 날짜를 yyyy-mm-dd 형식으로 출력
function getToday(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}

// 키 입력 이벤트 발생시 마우스 오른쪽 버튼인지 확인
function isRightButton(e){
	// 파라미터 e(이벤트 객채)가 undefine인 경우 window.event가 e로 반환
	e = e || window.event;
	
	// 이벤트 객체 e의 which속성이 있는 경우
	if("which" in e) {
		// 이벤트발생시 활성화된 버튼(e.which)이 마우스 우클릭버튼(3)인 경우 다음코드를 실행안함        			
		if(e.which == 3) return true;
		else return false;	
	}
	else{
		// which속성을 확인 할수 없는 경우 다음코드를 실행안함
		return true;
	}
}

// css seconds(0.3s)를 ms(300)로 변환
function css_seconds_to_milliSeconds(css_seconds) {
	css_seconds = css_seconds.replace("s", "");
	return css_seconds * 1000;
}

// 10보다 작은 수 앞에 0을 붙임
function leftPad(value) {
    if (value >= 10) {
        return value;
    }

    return `0${value}`;
}

function isEmptyObj(obj) {
	if(obj.constructor === Object && Object.keys(obj).length === 0){
		return true;
	}
	return false;
}