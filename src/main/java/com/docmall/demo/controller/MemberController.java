package com.docmall.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.demo.domain.MemberVO;
import com.docmall.demo.dto.LoginDTO;
import com.docmall.demo.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor // final 필드만 매개변수가 있는 생성자를 만들어주고 스프링에 의해 생성자 주입을 받게 된다.
@RequestMapping("/member/*")
@Slf4j
public class MemberController {

	// [참고 1] https://dev-coco.tistory.com/70
	// [참고 2] https://azderica.github.io/00-spring-injection/

	// 자동 주입 ─ @RequiredArgsConstructor
	// memberService 필드를 매개변수로 하는 생성자 메서드가 생성
	private final MemberService memberService;

	// public interface PasswordEncoder ─ 인터페이스
	// 생성자로 주입받는 필드에 인터페이스를 사용하는 이유? 유지보수(필드의 다형성)
	private final PasswordEncoder passwordEncoder; // public class BCryptPasswordEncoder implements PasswordEncoder

	// 1. 회원가입 페이지 구현
	@GetMapping("/join")
	public void join() {

		log.info("called...join");
	}

	// Ajax 문법(비동기 방식)으로 호출
	// 아이디 중복 체크 기능 구현
	// ResponseEntity 클래스? httpEntity를 상속받는, 결과 데이터와 HTTP 상태코드를 직접 제어 할 수 있는 클래스이다.
	// 3가지 구성요소 ─ HttpStatus, HttpHeaders, HttpBody
	// Ajax 기능과 함께 사용
	@GetMapping("/idCheck")
	public ResponseEntity<String> idCheck(String mbsp_id) throws Exception {

		log.info("아이디: " + mbsp_id);
		ResponseEntity<String> entity = null;

		// 서비스 메서드 호출 구문 작업
		String idUse = "";
		if (memberService.idCheck(mbsp_id) != null) {
			idUse = "no"; // 아이디가 존재하여 사용 불가능
		} else {
			idUse = "yes"; // 아이디가 존재하지 않아 사용 가능
		}

		entity = new ResponseEntity<String>(idUse, HttpStatus.OK); // HttpStatus.OK: 태코드 200번

		return entity;
	}

	// 2. 회원정보 저장 -> 다른 주소 이름('redirect:/')
	@PostMapping("/join")
	public String join(MemberVO vo, RedirectAttributes rttr) throws Exception { // RedirectAttributes rttr: 이동 시 파라미터로
																				// 추가 작업이 필요할 때

		log.info("회원정보: " + vo);

		// 비밀번호 암호화 처리
		vo.setMbsp_password(passwordEncoder.encode(vo.getMbsp_password()));
		log.info("암호화된 비밀번호: " + vo.getMbsp_password());

		// DB 저장
		memberService.join(vo);
		return "redirect:/member/login";
	}

	// 3. 로그인 폼 페이지
	@GetMapping("/login")
	public void login() {

	}

	// 1) 로그인 인증 성공 -> 메인 페이지(/) 주소 이동
	// 2) 로그인 인증 실패 -> 로그인 폼 주소로 이동
	// <input type="text" name="mbsp_id"> <input type="text" name="mbsp_password">
	// LoginDTO 클래스가 아닌 String mbsp_id, String mbsp_password를 파라미터로 사용해도 됨
	@PostMapping("/login")
	public String login(LoginDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {

		log.info("로그인: " + dto);

		MemberVO db_vo = memberService.login(dto.getMbsp_id());

		String url = "";
		String msg = "";

		if (db_vo != null) {
			// 아이디가 일치하는 경우 실행
			// 사용자가 입력한 비밀번호(평문 텍스트)와 DB에서 가져온 암호화된 비밀번호 일치 여부 검사
			// passwordEncoder.matches(rawPassword, encodedPassword)
			if (passwordEncoder.matches(dto.getMbsp_password(), db_vo.getMbsp_password())) {
				// 로그인 성공 결과로 서버 측의 메모리를 사용하는 세션 형태 작업
				db_vo.setMbsp_password(null); // 보안상 비밀번호는 사용할 일이 없어 이렇게 처리할 수도 있음(11월 24일 추가)
				session.setAttribute("loginStatus", db_vo);

				// 23.10.30. 추가분: 로그인 시간 업데이트 작업: 휴면 계정 등 관리
				memberService.loginTimeUpdate(dto.getMbsp_id());

				// 인증이 없는 상태에서 인증이 필요한 URI 요청 주소를 가지고 있을 때
				if(session.getAttribute("targetUrl") != null) {
					// UserInterceptor -> getTargetUrl의 request.getSession().setAttribute("targetUrl", targetUrl);
					url = (String) session.getAttribute("targetUrl"); 
				} else {
					url = "/"; // 메인 페이지 주소
				}
				
			} else {
				url = "/member/login"; // 로그인 폼 주소
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg", msg); // 로그인 폼인 login.jsp 파일에서 사용 목적
			}
		} else {
			// 아이디가 일치하지 않는 경우
			url = "/member/login"; // 로그인 폼 주소
			msg = "아이디가 일치하지 않습니다.";
			rttr.addFlashAttribute("msg", msg); // // 로그인 폼인 login.jsp 파일에서 사용 목적
		}

		return "redirect:" + url;
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();

		return "redirect:/";
	}

	// ---------- 23.10.30. 추가분 ----------

	// 회원수정 페이지로 이동 전 인증 확인 폼
	@GetMapping("/confirmPw")
	public void confirmPw() {

		log.info("회원수정 전 confirm 확인");
	}

	// 회원수정 페이지로 이동 전 인증 확인
	@PostMapping("/confirmPw")
	public String confiremPw(LoginDTO dto, RedirectAttributes rttr) throws Exception {
		log.info("회원수정 전 인증 재확인: " + dto);

		MemberVO db_vo = memberService.login(dto.getMbsp_id());

		String url = "";
		String msg = "";

		if (db_vo != null) {
			// 아이디가 일치하는 경우 실행
			// 사용자가 입력한 비밀번호(평문 텍스트)와 DB에서 가져온 암호화된 비밀번호 일치 여부 검사
			// passwordEncoder.matches(rawPassword, encodedPassword)
			if (passwordEncoder.matches(dto.getMbsp_password(), db_vo.getMbsp_password())) {
				// 로그인 성공 결과로 서버 측의 메모리를 사용하는 세션 형태 작업
				// session.setAttribute("loginStatus", db_vo);
				url = "/member/modify"; // 회원수정 폼 주소
			} else {
				url = "/member/confirmPw"; // 비밀번호 확인(confirmPw) 폼 주소
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg", msg); // 로그인 폼인 login.jsp 파일에서 사용 목적
			}
		} else {
			// 아이디가 일치하지 않는 경우
			url = "/member/confirmPw"; // 로그인 폼 주소
			msg = "아이디가 일치하지 않습니다.";
			rttr.addFlashAttribute("msg", msg); // // 로그인 폼인 login.jsp 파일에서 사용 목적
		}

		return "redirect:" + url;
	}

	// 회원수정 폼: 인증 사용자의 회원가입 정보를 뷰(View)에 출력
	@GetMapping("/modify")
	public void modify(HttpSession session, Model model) throws Exception {

		// 인터셉터를 사용하지 않을 경우 아래와 같은 코드를 중복 작성해야 함
		/*
		if(session.getAttribute("loginStatus") == null) {
			// 로그인 페이지로 이동
		}
		*/
		
		String mbsp_id = ((MemberVO) session.getAttribute("loginStatus")).getMbsp_id();
		MemberVO db_vo = memberService.login(mbsp_id);

		model.addAttribute("memberVO", db_vo);
	}

	@PostMapping("/modify")
	public String modify(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {

		log.info("정보 수정: " + vo);

		// 로그인 시 인증 목적으로 세션 작업을 한 정보에서 아이디를 받아온다.
		MemberVO db_vo = (MemberVO) session.getAttribute("loginStatus");

		String mbsp_id = db_vo.getMbsp_id();

		vo.setMbsp_id(mbsp_id);

		memberService.modify(vo);

		// header.jsp에서 전자우편이 수정된 내용으로 반영이 안 되기 때문
		db_vo.setMbsp_email(vo.getMbsp_email()); // 수정 작업

		session.setAttribute("loginStatus", db_vo);

		rttr.addFlashAttribute("msg", "success");

		return "redirect:/";
	}

	// 마이페이지
	@GetMapping("/mypage")
	public void mypage(HttpSession session, Model model) throws Exception {

	}

	// 회원탈퇴 폼
	@GetMapping("/delConfirmPw")
	public void delConfirmPw() {

	}

	// 회원탈퇴
	@PostMapping("/delete")
	public String delete(LoginDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {

		MemberVO db_vo = memberService.login(dto.getMbsp_id());

		String url = "";
		String msg = "";

		if (db_vo != null) {
			// 아이디가 일치하는 경우 실행
			// 사용자가 입력한 비밀번호(평문 텍스트)와 DB에서 가져온 암호화된 비밀번호 일치 여부 검사
			if (passwordEncoder.matches(dto.getMbsp_password(), db_vo.getMbsp_password())) {
				url = "/"; 
				session.invalidate(); // 세션 소멸
				
				// 회원탈퇴 작업할 것
				memberService.delete(dto.getMbsp_id());
				
			} else {
				url = "/member/delConfirmPw"; // 비밀번호 확인(confirmPw) 폼 주소
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg", msg); // 로그인 폼인 login.jsp 파일에서 사용 목적
			}
		} else {
			// 아이디가 일치하지 않는 경우
			url = "/member/delConfirmPw"; // 로그인 폼 주소
			msg = "아이디가 일치하지 않습니다.";
			rttr.addFlashAttribute("msg", msg); // // 로그인 폼인 login.jsp 파일에서 사용 목적
		}

		return "redirect:" + url;
	}

}
