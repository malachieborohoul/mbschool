const {ONE_SIGNAL_CONFIG}= require("../config/app.config")
async function SendNotification(data, callback){
    var headers ={
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Basic " + ONE_SIGNAL_CONFIG.API_KEY
    };

    var options={
        host: "onesignal.com",
        port: 443,
        path: "/api/v1/notifications",
        method: "POST",
        headers: headers
    };

    var https= require("https") 

    var req = https.request(options,function(res){
        res.on("data", function(data){
           console.log(JSON.parse(data)) 
            return callback(null, JSON.parse(data))
        });
    } );

    req.on("error", function (e){
        return callback({
            message: e
        });
    });

    req.write(JSON.stringify(data));
    req.end();
}

module.exports={
    SendNotification
}