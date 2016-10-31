app = require("app")  
config = require("config")  
wifi_config = require("wifi_config")
system = require("system")
user_config = require("user_config")

GPIO = config.GPIO

if (user_config.test_configmode() == true) then
    user_config.start()
else
    wifi_config.start() 
end
