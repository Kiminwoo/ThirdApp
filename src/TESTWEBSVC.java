import iros.gsb.constant.UserType;
import iros.gsb.constant.WebSvcType;
import iros.gsb.sbe.api.IntegrationClientAPI;

import java.io.File;
import java.util.Map;

import org.apache.commons.io.FileUtils;

/**
 * 웹서비스(SOAP, REST) 호출 Example
 * 
 * @author Administrator
 * 
 */
public class TESTWEBSVC {

	public static void main(String[] args) throws Exception {
		IntegrationClientAPI api = new IntegrationClientAPI(
				"C:\\esbclient.properties");
		/* esbclient.properties 파일 설정 */
		String filename = "";

		// 웹 서비스 활용자 인증처리를 한다.
		System.out.println("---------------------------------------------");
		api.auth(UserType.USER);

		// 웹 서비스 활용자를 위한 서비스 인증키가 생성된다.
		String madesskey = api.makeSessionKey();

		// 웹 서비스 활용자를 위한 서비스 인증키(session key)를 발행한 후 인증 서버에 등록한다.
		api.sendSessionKey(madesskey);

		System.out
				.println("===========================[Session Key Result]===========================");
		System.out.println("[INFO] made SessionKey : " + madesskey);
		System.out.println();

		WebSvcType wstype = WebSvcType.REST; // REST Type
		String URI = "http://localhost:8080/iros_eaptl_websvc/customerservice/customerservice/customers"; // URI을
																											// 설정한다.
		String reqStr = "<Customer><name>567</name></Customer>";// Request
																// Message를
																// 설정한다.

		// REST 일 경우에는 Message Header를 설정한다.
		// SOAP 일 경우에는 SOAP 메시지에 Message Header를 작성한다.
		Map headerCnt = api.setHeaderCnt("serviceKey", "requestTime",
				"callbackURI", "reqMsgID");

		// REST 웹 서비스를 호출한다.
		String retval = api.send(wstype, URI, reqStr, headerCnt);

		// 반환값을 출력한다.
		System.out
				.println("===========================[REST POST Request Result]===========================");
		System.out.println(retval);

		wstype = WebSvcType.REST; // REST Type
		URI = "http://localhost:8080/iros_eaptl_websvc/customerservice/customerservice/customers/123"; // URI을
																										// 설정한다.
		reqStr = null;// GET 메소드는 Request Message가 필요없다.

		// REST 일 경우에는 Message Header를 설정한다.
		// SOAP 일 경우에는 SOAP 메시지에 Message Header를 작성한다.
		headerCnt = api.setHeaderCnt("serviceKey", "requestTime",
				"callbackURI", "reqMsgID");

		// REST 웹 서비스를 호출한다.
		retval = api.send(wstype, URI, reqStr, headerCnt);

		// 반환값을 출력한다.
		System.out
				.println("===========================[REST GET Request Result]===========================");
		System.out.println(retval);

		wstype = WebSvcType.SOAP; // SOAP Type
		URI = "http://192.168.0.50:8092/PersonService/"; // URI을 설정한다.
		filename = "request.xml"; // SOAP 메시지는 직접 SOAP 요청 메시지를 작성해야 함
		reqStr = FileUtils.readFileToString(new File(filename)); // xml 파일을
																	// String으로
																	// 변환한다

		// SOAP 일 경우에는 SOAP 메시지에 Message Header를 작성하므로 headerCnt 를 null 로 설정한다.
		headerCnt = null;

		// REST 웹 서비스를 호출한다.
		retval = api.send(wstype, URI, reqStr, headerCnt);

		// 반환값을 출력한다.
		System.out
				.println("===========================[SOAP Request Result]===========================");
		System.out.println(retval);

	}
}