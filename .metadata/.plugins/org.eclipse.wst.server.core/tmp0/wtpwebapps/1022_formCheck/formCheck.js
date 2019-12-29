//	함수의 형식
//	function 함수이름([인수, ...]) {
//		함수가 실행할 문장;
//		...;
//		[return 값;]
//	}

//	moveNext(이벤트가 실행되는 객체, 최대 글자수, 포커스를 넘겨줄 객체)
function moveNext(obj, len, nextObj) {
//	이벤트가 실행되는 객체에 최대 글자수 만큼 문자가 입력되었으면 포커스를 넘겨줄 객체로 포커스를 넘겨준다.
//	value => 객체에 입력된 데이터를 의미한다. 값이 입력되어있으면 true, 그렇치 않으면 false
//	length => 객체에 입력된 문자의 개수를 얻어온다.
	if(obj.value.length == len) {
		nextObj.focus();
	}
}

//	formCheck(검사할 데이터가 입력된 폼)
function formCheck(obj) {
//	obj로 this(폼)가 넘어오므로 obj에는 document.juminForm가 저장된다.

//	주민등록번호 앞 자리에 데이터가 입력되었나 검사해서 입력되지 않았으면 false를 리턴시킨다.
//	!obj.jumin1.value => 아무것도 입력되지 않았는가?
	if(!obj.jumin1.value || obj.jumin1.value.trim().length == 0) {
		alert("주민등록번호 앞 자리를 입력하세요!!!");
		obj.jumin1.value = "";
		obj.jumin1.focus();
		return false;
	}
  
//	주민등록번호 앞 자리에 6글자가 입력되었나 검사해서 입력되지 않았으면 false를 리턴시킨다.
	if(obj.jumin1.value.trim().length != 6) {
		alert("주민등록번호 앞 자리는 6글자를 입력하세요!!!");
		obj.jumin1.value = "";
		obj.jumin1.focus();
	return false;
	}
		
//	주민등록번호 앞 자리에 숫자만 입력되었나 검사해서 숫자만 입력되지 않았으면 false를 리턴시킨다.
//	Number() => 인수로 지정된 문자열을 숫자로 변환한다.
//	isNaN() => NaN(Not a Number), 인수로 지정된 데이터가 숫자가 아니면 true, 숫자이면 false를 리턴한다.
	if(isNaN(Number(obj.jumin1.value.trim()))) {
		alert("주민등록번호 앞 자리는 숫자만 입력해야합니다!!!");
		obj.jumin1.value = "";
		obj.jumin1.focus();
		return false;
	}
		
//	주민등록번호 뒷자리를 검사한다.
	if(!obj.jumin2.value || obj.jumin2.value.trim().length == 0) {
		alert("주민등록번호 뒷 자리를 입력하세요!!!");
		obj.jumin2.value = "";
		obj.jumin2.focus();
		return false;
	}
	if(obj.jumin2.value.trim().length != 7) {
		alert("주민등록번호 뒷 자리는 7글자를 입력하세요!!!");
		obj.jumin2.value = "";
		obj.jumin2.focus();
		return false;
	}
	if(isNaN(Number(obj.jumin2.value.trim()))) {
		alert("주민등록번호 뒷 자리는 숫자만 입력해야합니다!!!");
		obj.jumin2.value = "";
		obj.jumin2.focus();
		return false;
	}
	
//	여기까지 왔다는 것은 입력된 주민등록번호가 13자리의 숫자가 입력되었다는 의미이다. => 유효성을 검사한다.
//	주민등록번호 유효성을 검사하기 위해 주민등록번호를 하나의 문자열로 합친다.
	var jumin = obj.jumin1.value.trim() + obj.jumin2.value.trim();
//	var jumin = Number(obj.jumin1.value.trim()) + Number(obj.jumin2.value.trim());	// 숫자 덧셈
//	javascript는 숫자로만 구성된 문자열을 사칙연산 할 경우 덧셈을 하는 경우만 문자열을 이어주고 덧셈을 제외한 나머지는 지가 알아서
//	숫자로 바꾼 후 연산한다.
//	alert(jumin);
//	주민등록번호 유효성을 검사한다. 가중치 => 234567892345, 둘리 주민등록번호 => 8304221185600 => 가중치와 곱해서 더하면 143
	
	sum = 0;
	for(i = 0; i < 12; i++) {
//		sum += jumin.charAt(i) * (i < 8 ? i + 2 : i - 6);
		sum += jumin.charAt(i) * (i % 8 + 2);
	}
//	alert(sum);

//	가중치와 곱한 합계를 11로 나눈 나머지를 11에서 뺀 결과가 주민등록번호의 마지막 자리와 같아야 한다.
//	가중치와 곱한 합계를 11로 나눈 나머지를 11에서 뺀 결과가 10 이상이면 10으로 나눈 나머지와 비교한다.
	result = (11 - sum % 11) % 10;
//	"=="와 "!="는 변수에 저장된 값을 대충 비교한다. => 문자를 알아서 숫자로 바꿔 비교한다. => "1"과 1을 같은 값으로 취급한다.
//	"==="와 "!=="는 변수에 저장된 값과 자료형을 비교한다. => "1"과 1을 다른 값으로 취급한다.
	if(result != jumin.charAt(12)) {
		alert("주민등록번호가 올바르지 않습니다!!!");
		obj.jumin1.value = "";
		obj.jumin2.value = "";
		obj.jumin1.focus();
		return false;
	}
		
	alert("올바른 주민등록번호 입니다!!!");
//	폼에 오류없이 여기까지 실행되면 정상적인 데이터가 입력된 것이므로 true를 리턴한다.
	return true;
}
