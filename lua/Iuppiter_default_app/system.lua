local system = {}

function system.reboot(message, delay)
    if (message ~= nil) then
        print(message)
    end
    tmr.unregister(config.TIMER_REBOOT)
    tmr.register(config.TIMER_REBOOT, delay or config.WAIT_FOR_RESTART, tmr.ALARM_SINGLE, function() node.restart() end)
    tmr.start(config.TIMER_REBOOT)
end


function system.led(state, led)  

end


return system
