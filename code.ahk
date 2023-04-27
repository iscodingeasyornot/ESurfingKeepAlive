CoordMode "Mouse", "Screen"
setTimer initCheck, 30000
Thread "NoTimers", 1
initCheck()

clickDialButton(){
        MouseMove 959, 562, 0
        Click
        MouseClick "left", 959, 562
}

initCheck(){
    if (!checkConnection(1000)){
        if (!checkConnection(2000)){
            if (!checkConnection(1000)){
                restartAndDial()
            }
        }
    }
}

restartAndDial(){
    try processClose("ESurfingClient.exe")
    try processClose("SelfDebugTool.exe")
    run "C:\Program Files (x86)\Chinatelecom_JSPortal\ESurfingClient.exe"
    sleep(5000)
    clickDialButton()
    c := 0
    sleep(5000)
    while ((!checkConnection(2000)) & (c<18)){
        clickDialButton()
        sleep(3000)
        c := c + 1
    }
}

checkConnection(timeOut){
    statusCode := 0
    Captive := ComObject("WinHttp.Winhttprequest.5.1")
    Captive.open("GET","http://119.29.29.29")
    Captive.setTimeouts(timeOut,timeOut,timeOut,timeOut)
    try {
        Captive.send()
        statusCode := Captive.Status
    }
    if (statusCode = 404){
        return 1
    }
    else{
        return 0
    }
}
