local wifi_config = {}

function wifi_config.wait_dhcp()  
  if (wifi.sta.getip() == nil) then
    uart.write(0, ".")
  else
    tmr.unregister(config.TIMER_DHCPTEST)
    print("\nWIFI: Connected! IP is "..wifi.sta.getip())
    --app.start() 
    WAIT_PERIOD, REPEAT_PERIOD = 1000, 5000
    tmr.alarm(config.TIMER_APPSTART, WAIT_PERIOD, tmr.ALARM_SINGLE, app.start)
    --tmr.alarm(config.TIMER_APPSTART, REPEAT_PERIOD, tmr.ALARM_AUTO, app.start)
  end
end

function wifi_config.connect(list_aps)  
    if list_aps then
        for key,value in pairs(list_aps) do
            if config.SSID and config.SSID[key] then
                print("\n\n====================================")
                wifi.setmode(wifi.STATION);
                wifi.sta.config(key,config.SSID[key])
                wifi.sta.connect()
                wifi.sta.autoconnect(1)
                print("WIFI: connecting to ssid "..key.."/"..config.SSID[key])
                --config.SSID = nil  -- can save memory
                tmr.alarm(config.TIMER_DHCPTEST, 100, tmr.ALARM_AUTO, wifi_config.wait_dhcp)
            end
        end
    else
        print("Error getting AP list")
    end
end

function wifi_config.start()  
    print("Configuring Wifi ...")
    if (file.exists(config.USERCONFIG_FILE) == true) then
        dofile(config.USERCONFIG_FILE)
    end
    wifi.setmode(wifi.STATION);
    wifi.sta.getap(wifi_config.connect)
end


return wifi_config
