local config = {}

config.GPIO = {}
config.GPIO.N16 = 0
config.GPIO.N5 = 1
config.GPIO.N4 = 2
config.GPIO.N0 = 3
config.GPIO.N2 = 4
config.GPIO.N14 = 5
config.GPIO.N12 = 6
config.GPIO.N13 = 7
config.GPIO.N15 = 8
config.GPIO.N3 = 9
config.GPIO.N1 = 10
config.GPIO.N9 = 11
config.GPIO.N10 = 12

config.LED_GREEN_GPIO = config.GPIO.N4
config.LED_RB1_GPIO = config.GPIO.N15
config.LED_RB2_GPIO = config.GPIO.N13

config.USERCONFIG_FLAG = "userconfig.flag"
config.USERCONFIG_FILE = "userconfig.cfg"
config.AP_NAME = "DevName_CONFIG_"..node.chipid()
config.USERCONFIG_PERIOD = 10*1000
config.USERCONFIG_COUNTER = 3
config.USERCONFIG_RESET = 10

config.TIMER_USERCONFIG = 2
config.TIMER_UC_DISCONNECT = 1
config.TIMER_APPSTART = 1
config.TIMER_REBOOT = 3
config.TIMER_DHCPTEST = 1


config.WAIT_FOR_RESTART = 5*1000

config.SSID = {}  
--config.SSID["IoT_Dobbi"] = "was7thod"
--config.SSID["Mike's spot"] = "9150232120"
--config.SSID["Madrobots.ru"] = "FERG2N76"
--config.SSID["beeline135"] = "0850627249135"


return config  
