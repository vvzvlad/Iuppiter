local app = {}

function data_sub(data)
    local string_len, first_string, i = nil, nil, 0
    repeat 
        i = i + 1
        string_len = string.find(data, "\n") or 0
        first_string = string.sub(data, 0, string_len - 1)
        if (first_string == "[" or string_len == 0) then
            return data
        end
        data = string.sub(data, string_len + 1)
    until (i > 10)
    return data
end

function app.start()
    print("Server starting...")
    
    srv=net.createServer(net.TCP)
    srv:listen(80,function(conn)
        conn:on("receive", function(client,request)
            local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
            if (method == nil) then
                _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
            end
            local _GET = {}
            if (vars ~= nil)then
                for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                    _GET[k] = v
                end
            end
            request = data_sub(request)
            print(request)
    
            buf = "<h1> ESP8266 Web Server</h1>\n";
            client:send(buf);
            client:close();
            collectgarbage();
        end)
    end)
          

end

return app  
