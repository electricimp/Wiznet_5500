device.on("response", function(data) {
    server.log(http.jsonencode(data));
});
