
wifi.setmode(wifi.SOFTAP)
print("set mode=SOFTAP (mode="..wifi.getmode()..")\n")

ap_cfg = {
    ssid = "socket",
    channel = 6,
    hidden = false,
    max = 4,
    beacon = 100,
    save = false
}
wifi.ap.config(ap_cfg)

print("Chip ID: ", node.chipid(), "\n")
print("Heap Size: ", node.heap(), "\n")
print("MAC Address: ", wifi.ap.getmac(), "\n")

print("Configuring IP...\n")
ip_cfg = {
    ip = "192.168.1.1",
    netmask = "255.255.255.0",
    gateway = "192.168.1.1"
}
wifi.ap.setip(ip_cfg)

dhcp_config = {start = "192.168.1.100"}
wifi.ap.dhcp.config(dhcp_config)

print("Starting DHCP Service...\n")
wifi.ap.dhcp.start()

wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED, function(T)
    print("\n\tAP - STATION CONNECTED".."\n\tMAC: "..T.MAC.."\n\tAID: "..T.AID)
end)

wifi.eventmon.register(wifi.eventmon.AP_STADISCONNECTED, function(T)
    print("\n\tAP - STATION DISCONNECTED".."\n\tMAC: "..T.MAC.."\n\tAID: "..T.AID)
end)
