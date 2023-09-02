class APIUrl {
  // get 기본 정보 조회
  static const USER = 'user';
  // post 지갑주소 등록 (body.address:str)
  static const WALLET = 'user';
  // post 텔레그램 인증 번호 요청 body(phone:str)
  static const TELEGRAM_SEND_CODE = 'telegram/authSendCode';
  // post 텔레그램 인증 번호 확인 body(code:str)
  static const TELEGRAM_SIGN_IN = 'telegram/authSignIn';
  // post 나의 카드 정보 등록 body(name:str, email:str, company:str, title:str, description:str, cardImageBase64:str, faceImageBase64:str)
  static const REGISTER_CARD = 'user/card';
  // get 나의 카드 목록 조회
  static const MY_CARDS = 'user/card';
  // get 카드 이미지 조회 params(cardId:str) ex_ /user/card/:cardId/image
  static const CARD_IMAGE = 'user/card';
  // get 교환한 카드 이미지 조회
  static const EXCHANDED_CARDS = 'user/handleit';
  // post 카드 QR코드 스캔 정보 조회 body(qrData:str)
  static const CARD_QR_CODE = 'user/qr';
  // post 명함 교환, 메시지 전송 body(cardId:str, qrData:str, hiMessage:str, sendMySocialToken:str, photoList:List<String>)
  static const CARD_EXCHANGE = 'user/handleit';
  // get 명함 교환 내역 조회
  static const CARD_EXCHANGE_HISTORY = 'user/handleit';
}
