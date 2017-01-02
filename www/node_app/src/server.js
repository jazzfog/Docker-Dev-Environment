var http = require('http');

const PORT=3000;

function handleRequest(request, response){
    response.end('\
    	<html style="text-align: center;">\
			<img src="/images/node_logo.png" style="zoom: 50%;">\
			<h1>Welcome to a node app</h1> \
			<h2>Requested URL: ' + request.url + ' </h2> \
			' + JSON.stringify(process.versions) + ' \
		</html>'
	);
}

var server = http.createServer(handleRequest);

server.listen(PORT, function(){
    console.log("Server listening on: http://localhost:%s", PORT);
});