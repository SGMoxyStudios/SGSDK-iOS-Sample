# SgSDK-iOS

## 使用方法
  - 在Xcode內點選General標籤，找到"Embedded Binaries"
  - 點選"+"按鈕將"SgSDK.framework"加入專案
  - 加入完成後可在專案裡import SgSDK

## function
  - func SetListener(listener callBack: @escaping (Int) -> Void)
    - 使用SgSDK第一步就是，設置callBack function
    - 回傳的參數代表成功或失敗
    ```
    SgSDK.Instance.SetListener(listener: MsgListen)
    ........
    func MsgListen(code: Int) {
        switch(code) {
        case 101:
            self.setMessage("init succeed!")
        case 102:
            self.setMessage("init failed")
        case 200:
            print("show login page.")
        case 201:
            self.setMessage("login succeed!")
        case 202:
            self.setMessage("login failed")
        default:
            self.setMessage("Unknow error")
        }
    }
    ```
  - func Init(\_ GameKey: String, \_ AppSecret: String)
    - 初始化SgSDK, 將GameKey和AppSecret依照順序填入
    ```
    SgSDK.Instance.Init("YourGameKey", "YourAppSecret")
    ```

  - func Login()
    - 需要使用Init之後才能使用Login()
    - 使用後會打開登入畫面
    - 左上角會有一個"Back"按鈕，可以回主畫面
    ```
    SgSDK.Instance.Login()
    ```

  - func GetOpenID() -> Int?
    - 需要成功登入後才能使用
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
    - 需要成功登入後才能使用
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
    - 需要成功登入後才能使用
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
