
ws = websocket.createClient()

ws:on("connection", function(ws)
    print('got ws connection', ws)

    if t1 then t1:unregister() end
    t1 = tmr.create()
    math.randomseed(tmr.now())
    t1:register(100, tmr.ALARM_AUTO, 
    function (t)
        ws:send(math.random(2) - 1)
        t:interval(100)
    end)
    t1:start()

end)

ws:on("receive", function(_, msg, opcode)
    print('got message:', msg, opcode)
end)

ws:on("close", function(_, status)
    print('connection closed', status)
    ws = nil
end)

ws:connect('ws://192.168.1.100:8080')

