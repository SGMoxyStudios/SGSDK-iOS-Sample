# SgSDK-iOS

## 使用方法
  - 在Xcode內點選General標籤，找到"Embedded Binaries"
  - 點選"+"按鈕將"SgSDK.framework"加入專案
  - 加入完成後可在專案裡import SgSDK

## function
  - func SetListener(listener callBack: @escaping (Int, String) -> Void)
    - 使用SgSDK第一步就是，設置listener，沒有設置的話後面的function無法使用
    - listener 帶兩個參數
      1. code: Int 回傳Error Code
      2. msg: String 回傳該Error Code代表的訊息
    ```
    SgSDK.Instance.SetListener(listener: MsgListen)
    ...
    func MsgListen(code: Int, msg: String) {
        self.setMessage("Error code: \(code), msg: \(msg)")
    }
    ```
  - func Init(\_ GameKey: String, \_ AppSecret: String)
    - 使用SgSDK第二步就是Init()，沒有使用的話後面的function也無法使用
    - 初始化SgSDK, 將GameKey和AppSecret依照順序填入
    ```
    SgSDK.Instance.Init("YourGameKey", "YourAppSecret")
    ```

  - func Login()
    - 前置：Init()
    - 使用後會打開登入畫面
    - 左上角會有一個"Back"按鈕，可以回主畫面
    ```
    SgSDK.Instance.Login()
    ```
  - func Signup()
    - 前置：Init()
    - 使用後會打開註冊畫面
    ```
    SgSDK.Instance.Signup()
    ```

  - func ForgotPassword()
    - 前置：Init()
    - 使用後會打開忘記密碼的畫面
    ```
    SgSDK.Instance.ForgotPassword()
    ```

  - func ChangePassword()
    - 前置：Init()
    - 使用後會打開變更密碼的畫面
    ```
    SgSDK.Instance.ChangePassword()
    ```

  - func ParentalLock()
    - 前置：Init()
    - 使用後會打開家長操作的畫面
    - 不會有回傳
    ```
    SgSDK.Instance.ParentalLock()
    ```
  - func MyKid()
    - 前置：Init()
    - 使用後會打開新增孩童資料的畫面
    ```
    SgSDK.Instance.MyKid()
    ```
  - func MyAccount()
    - 前置：Init()
    - 使用後會打開孩童資料的畫面
    - 不會有回傳
    ```
    SgSDK.Instance.MyAccount()
    ```
  - func OpenID(listener callBack: @escaping (Any) -> Void)
    - 前置：Init()
    - 回傳：OpenID
    ```
    SgSDK.Instance.OpenID() {
            (any) -> Void in
            if let openid = any as? Int {
                print("OpenID:\(openid)")
            }
        }
    ```

  - func VerifySession(appId: String, session: String, uid: String, signature: String, listener callBack: @escaping (Any) -> Void)
    - 前置：Init()
    - Session ID登入驗證
    - 回傳：Account, OpenID, Password, EMail
    ```
    SgSDK.Instance.VerifySession(appId: "YourAppId", session: "SessionID", uid: "UID", signature: "Signature") {
            (any) -> Void in
            if let verify = any as? Verify {
                print("VerifySession, Account: \(verify.Account), OpenID: \(verify.OpenID), Password: \(verify.Password), Email: \(verify.EMail)")
            }
        }
    ```

  - public func VerifyToken(token: String, listener callBack: @escaping (Any) -> Void)
    - 前置：Init()
    - Token 登入驗證
    - 回傳：Account, OpenID, Password, EMail
    ```
    SgSDK.Instance.VerifyToken(token: "Token") {
            (any) -> Void in
            if let verify = any as? Verify {
                print("VerifyToken, Account: \(verify.Account), OpenID: \(verify.OpenID), Password: \(verify.Password), Email: \(verify.EMail)")
            }
        }
    ```

  - func Logout()
    - 前置：Init()
    - 登出
    - 不會有回傳
    ```
    SgSDK.Instance.Logout()
    ```

  - func GameStart()
    - 前置：Init()
    - 開始統計遊戲時間
    - 不會有回傳
    ```
    SgSDK.Instance.GameStart()
    ```

  - func GameStop()
    - 前置：Init()
    - 結束統計遊戲時間
    ```
    SgSDK.Instance.GameStop()
    ```

  - func GetOpenID() -> Int?
    - 前置：Login()
    - 會直接回傳結果
      - 成功的話會得到一個Int?
      - 失敗的話會得到一個nil
    ```
    if let msg = SgSDK.Instance.GetOpenID() {
            setMessage("\(msg)")
        } else {
            setMessage("Please login.")
        }
    ```

  - func GetSessionID() -> String?
    - 前置：Login()
    - 會直接回傳結果
      - 成功的話會得到一個String?
      - 失敗的話會得到一個nil
    ```
    if let msg = SgSDK.Instance.GetSessionID() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    ```

  - func GetToken() -> String?
    - 前置：Login()
    - 會直接回傳結果
      - 成功的話會得到一個String?
      - 失敗的話會得到一個nil
    ```
    if let msg = SgSDK.Instance.GetToken() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    ```
  - func IsLogined() -> Bool
    - 判斷是否為登入狀態
    ```
    self.setMessage("Is login? \(SgSDK.Instance.IsLogined())")
    ```
