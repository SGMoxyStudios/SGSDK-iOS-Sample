# SGSDK-iOS

## SDK 支援的最低 iOS 版本 8.0

## 使用方法
  - 在 Xcode 內點選 General 標籤，找到 "Embedded Binaries"。
  - 點選 "+" 按鈕將 "SGSDK.framework" 加入專案。
  - 加入完成後可在專案裡 import SGSDK。

## 函式
  - func SetListener(listener callBack: @escaping (SGListenResult) -> Void) -> Void
    - 使用 SGSDK 第一步就是，設置 listener，SGSDK 所有非同步的函式，都透過回調監聽來得到結果。
    - listener 參數SGListenResult有三個屬性
      1. Code: Int 回傳 Error Code。
      2. Msg: String 回傳該 Error Code 代表的訊息。
      3. Data: Any? 沒有其他資訊的話會是 nil，有資訊的話根據不同函式回應不同結構。

    ```
    SGSDK.Instance.SetListener(listener: MsgListen)
    ...
    func MsgListen(result: SGListenResult) {
      //print("code: \(result.Code), msg: \(result.Msg)")
    }
    ```
  - func Init(GameKey: String, AppSecret: String) -> Void
    - 使用 SGSDK 第二步就是 Init()，沒有使用的話後面的函式也無法使用。
    - 初始化 SGSDK, 將 GameKey 和 AppSecret 依照順序填入。

  - func Login() -> Void
    - 前置：Init()
    - 調用登入頁面，登入成功後關閉WebView。
    - 右上角會有一個"X"按鈕，可以回主畫面。
    - Login完成後自動開啟一個懸浮按鈕
    - 回調監聽的 Data 參數：SGMember。

  - func Signup() -> Void
    - 調用註冊頁面，註冊成功等同登入然後關閉WebView。
    - 回調監聽的 Data 參數：SGMember。

  - func ForgotPassword() -> Void
    - 調用找回密碼頁面進行重設密碼。

  - func ChangePassword() -> Void
    - 調用變更密碼頁面。

  - func ParentalLock() -> Void
    - 在呼叫帳號設置前需要先呼叫家長安全操作頁面以防孩童誤擊重要功能。
    - 不會有回傳。

  - func MyKid() -> Void
    - 調用新增孩童資料頁面。

  - func MyAccount() -> Void
    - 調用帳號總覽頁面，以瀏覽孩童遊戲紀錄。
    - 不會有回傳。

  - func OpenID() -> Void
    - 回傳：OpenID。

  - func VerifySession(gameKey: String, sessionId: String, openId: String, sign: String) -> Void
    - 使用 SessionID 取得登入帳號資訊。
    - 回調監聽的 Data 參數：SGMember。

  - func LoginByToken(token: String) -> Void
    - 使用 Token 快速登入。
    - 回調監聽的 Data 參數：SGMember。

  - func Logout() -> Void
    - 登出

  - func GameStart() -> Void
    - 開始統計遊戲時間

  - func GameStop() -> Void
    - 結束統計遊戲時間

  - func GetOpenID() -> String?
    - 前置：Login()
    - 會直接回傳結果
      - 成功: OpenID
      - 失敗: nil
    ```
    if let msg = SGSDK.Instance.GetOpenID() {
            print("msg")
        } else {
            print("Please login.")
        }
    ```

  - func GetSessionID() -> String?
    - 前置：Login()
    - 會直接回傳結果
      - 成功: SessionID
      - 失敗: nil
    ```
    if let msg = SGSDK.Instance.GetSessionID() {
            print(msg)
        } else {
            print("Please login.")
        }
    ```

  - func GetToken() -> String?
    - 前置：Login()
    - 會直接回傳結果
      - 成功: Token
      - 失敗: nil
    ```
    if let msg = SGSDK.Instance.GetToken() {
            print(msg)
        } else {
            print("Please login.")
        }
    ```

  - func IsLogin() -> Bool
    - 判斷是否為登入狀態

  - func GetChannelID() -> String
    - 取得平台名稱

  - func ShowFloatingButton(place: eFloatingButtonPlace) -> Void
    - 開啟懸浮按鈕
    - 前置：Init()
    - 開啟後會依照選擇的方位在視窗邊上出現
    - 按鈕可隨意拖拉，放開按鈕後會找最接近的邊吸附
    - 按鈕不動的時候10秒後會自動埋入半顆按鈕再視窗邊上
    - 按下按鈕會開啟孩童資料的畫面

  - func HideFloatingButton() -> Void
    - 關閉懸浮按鈕

  - func Destroy() -> Void
    - 釋放 SGSDK 資源。

  - func IAPInit(productIDs: [String]) -> Void
    - 初始化In-App Purchase
    - 將商品ID輸入
    ```
    productIDs.append("ConsumbleItem")
    productIDs.append("NonConsumable")
    productIDs.append("AutoSubscription")
    productIDs.append("NonAutoSbuscriptions")
    SGSDK.Instance.IAPInit(productIDs: productIDs)
    ```

  - func Pay(payRequest: SGPayRequest) -> Void
    - 購買遊戲內付費商品時調用，向 app store 購買成功後會跟 SG Server 做驗證。
    - SGPayRequest裡的ProductId必填
    - 前置：IAPInit
    - 回調監聽的 Data 參數：SGPayResponse。
    ```
    SGSDK.Instance.Pay(payRequest: initPayReq(productId: "your product id", payMethod: "managed"))
    ...
    func initPayReq(productId: String, payMethod: String) -> SGPayRequest {
        let req = SGSDKPayRequest()
        req.ProductId = productId
        req.PaymentMethod = payMethod
        req.PaymentChannel = "AppStore"
        req.ServerId = "Server ID"
        req.ServerName = "Server Name"
        req.RoleId = "9487"
        req.RoleName = "C8763"
        req.RoleLevel = 99
        return req
    }
    ```

  - func GetOrder(orderId: String, gameKey: String, openId: String, sign: String) -> Void
    - 需傳送購買成功後的簽名(sign)，才能查詢訂單詳細內容。
    - 回調監聽的 Data 參數：SGPayResponse。

  - func RestorePurchase() -> Void
    - 恢復購買，換手機時，只有在商品種類是 Non-Consumable, Auto-renewing subscription 這兩種商品會用到。
    - 前置：IAPInit
