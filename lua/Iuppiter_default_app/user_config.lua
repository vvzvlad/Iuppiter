local user_config = {}

function user_config.reset_counter()
    file.open(config.USERCONFIG_FLAG, "w+")
    file.write(tostring(1))
    file.flush()
    file.close()
    tmr.unregister(config.TIMER_USERCONFIG)
end

function user_config.test_configmode()
    tmr.unregister(config.TIMER_USERCONFIG)
    tmr.alarm(config.TIMER_USERCONFIG, config.USERCONFIG_PERIOD, tmr.ALARM_SINGLE, user_config.reset_counter)
    
    if (file.exists(config.USERCONFIG_FLAG) == true) then
        file.open(config.USERCONFIG_FLAG, "r")
        local value = tonumber(file.read(2) or "1")
        file.close()
        print("Reboot counter: "..value)
        file.open(config.USERCONFIG_FLAG, "w+")
        file.write(tostring(value+1))
        file.flush()
        file.close()
        if (value >= config.USERCONFIG_RESET) then
            file.remove(config.USERCONFIG_FLAG)
            file.remove(config.USERCONFIG_FILE)
            system.reboot("User config reset mode reboot")
            return false
        elseif (value >= config.USERCONFIG_COUNTER) then
            print("User config mode")
            return true
        end
    else
        user_config.reset_counter()
    end

    return false
end

function user_config.compare(ssid, password)
    for key, value in pairs(config.SSID) do
        if (key == ssid and value == password) then
            return true
        end
    end
    return false
end

function user_config.start()
    wifi.sta.disconnect()
   
    if (file.exists(config.USERCONFIG_FILE) == true) then
        dofile(config.USERCONFIG_FILE)
    end
    
    wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, 
        function(T) 
            ssid, password = wifi.sta.getconfig()
            print("Connected: "..ssid.."/"..password)
            local status = user_config.compare(ssid, password)
            if (status == false) then
                print("Saved: "..ssid.."/"..password)
                local new_config = 'config.SSID["'..ssid..'"] = "'..password..'" '
                file.open(config.USERCONFIG_FILE, "w+")
                file.write(new_config)
                file.flush()
                file.close()
                wifi.eventmon.unregister(wifi.eventmon.STA_CONNECTED)
                system.reboot("Reboot after user config in an 15s", 15*1000)
            end
        end
    )
    
    wifi.setmode(wifi.STATIONAP)
    wifi.ap.config({ssid=config.AP_NAME, auth=wifi.OPEN})
    enduser_setup.manual(true)
    enduser_setup.start()
    system.led("on")  
end


return user_config
