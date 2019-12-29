package kr.koreait.onlinepoll;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class PollRead {

//	텍스트 파일이 저장된 경로와 이름을 넘겨받아 텍스트 파일에 저장된 데이터를 읽어 ArrayList에 저장시킨 후 리턴하는 메소드
	public static ArrayList<String> pollRead(String filename) {
		
//		읽어들인 텍스트 파일의 데이터를 저장해 리턴시킬 ArrayList를 선언한다.
		ArrayList<String> poll = null;
//		텍스트 파일의 데이터를 읽어들일 Scanner를 선언한다.
		Scanner scanner = null;
		
		try {
//			텍스트 파일에서 데이터를 읽어들을 스캐너 객체를 선언한다.
			scanner = new Scanner(new File(filename));
//			텍스트 파일에서 데이터를 읽어들일 스캐너가 정상적으로 생성되었으므로 텍스트 파일의 데이터를 읽어서 저장할 ArrayList를
//			생성한다.
			poll = new ArrayList<String>();
			
//			텍스트 파일의 끝까지 반복한다.
			while(scanner.hasNextLine()) {
//				텍스트 파일을 읽어 ArrayList에 저장한다.
				String str = scanner.nextLine().trim();
				if(str.length() > 0) {
					poll.add(str);
				}
			}
		} catch (FileNotFoundException e) {
			System.out.println("디스크에 파일이 존재하지 않습니다.");
//			e.printStackTrace();
		} finally {
			if(scanner != null) { scanner.close(); }
		}
		
//		텍스트 파일에서 읽어들인 데이터가 저장된 ArrayList를 리턴시킨다.
		return poll;
		
	}
	
}
















