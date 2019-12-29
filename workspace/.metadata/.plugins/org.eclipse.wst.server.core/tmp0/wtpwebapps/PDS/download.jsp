<%@ page contentType="application;"%>
<%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*,java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");
	String strFilename = request.getParameter("filename");		// 다운로드할 파일의 이름을 받는다.
	String uploadPath = application.getRealPath("./upload");	// 다운로드할 파일이 저장된 실제 경로를 얻어온다.
//	실제 경로와 파일의 이름을 합쳐서 다운로드 할 파일 객체를 만든다.
	File file = new File(uploadPath + "/" + strFilename); 
//	다운로드할 파일의 크기 만큼 바이트 배열을 만든다.
	byte b[] = new byte[(int) file.length()];

//	getHeader("User-Agent") : 사용하는 브라우저의 정보를 얻어온다.
	String header = request.getHeader("User-Agent");
//	브라우저 종류에 따라서 다운 받을 파일의 이름을 http 헤더에 추가한다.
	if(header.contains("MSIE")) {	// 인터넷 익스플로러를 사용해 다운로드를 받는가?
		String docName = URLEncoder.encode(strFilename, "UTF-8").replaceAll("\\+", "%20");
//		Content-disposition 헤더는 본문 부분에 대한 표시 정보를 제공합니다.
//		이 헤더를 첨부 파일에 추가하여 첨부 파일의 본문 부분을 표시할지(inline) 복사할 파일 이름으로 표시할지(attachment) 
//		여부를 지정한다. 
		response.setHeader("Content-Disposition", "attachment; filename=" + docName + ";");
	} else {
		String docName = new String(strFilename.getBytes("UTF-8"), "ISO-8859-1");
		response.setHeader("Content-Disposition", "attachment; filename='" + docName + "'");
	}
	response.setHeader("Content-Type", "application/octet-stream");
	response.setHeader("Content-Length", String.valueOf(file.length()));
	response.setHeader("Content-Transfer-Encoding", "binary;");
	response.setHeader("Pragma", "no-cache;");
	response.setHeader("Expires", "-1;");
	
	if(file.isFile()) {		// 다운로드할 파일이 있는가?
		BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
		int read = 0;
		while ((read = fin.read(b)) != -1) {	// 파일의 끝까지 반복하며 읽는다.
			outs.write(b, 0, read);				// 읽어들인 파일의 내용을 출력한다.
		}
		outs.close();
		fin.close();
	}
%>









