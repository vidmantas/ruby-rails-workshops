/*
A simple go program that demonstates websockets. To run it
 1. build it with "go build ws.go" Tested with go version weekly.2012-02-14 +43cf9b39b647
 2. run the program
 3. point chrome to http://localhost:40000 Tested with chrome 17.0.963.56
 4. type some key value pairs in the console of 2 and see them in the browser
 
 The html content must be served by a server and cannot be loaded by a file.
 This is because the web socket protocol must set the Origin property to
 sth meaningful. Notice how elegantly a string is served by go using http
*/
 
package main
 
import (
	"io"
	"fmt"
	"net/http"
	"code.google.com/p/go.net/websocket"
)
 
type Item struct {
	Key string
	Val string
}
 
func ReadAndSendItems(ws *websocket.Conn) {
	var key, val string
	for {
		fmt.Printf("key value: ")
		_, err := fmt.Scan(&key, &val)
		if err == io.EOF {
			return
		}
		if err != nil && err != io.EOF {
			panic(err)
		}
		websocket.JSON.Send(ws, Item{key, val})
	}
}
 
func ItemsServer(ws *websocket.Conn) {
	fmt.Println("opened connection")
	ReadAndSendItems(ws)
	ws.Close()
	fmt.Println("closed connection")
}
 
func main() {
	http.Handle("/items", websocket.Handler(ItemsServer))
	http.Handle("/", page)
	err := http.ListenAndServe(":40000", nil)
	if err != nil {
		panic("ListenAndServe: " + err.Error())
	}
}
 
type Page string
 
func (p Page) ServeHTTP(rw http.ResponseWriter, req *http.Request) {
	io.WriteString(rw, string(p))
}
 
var page Page = `<!DOCTYPE html>
<html>
<head>
    <title>websockets in action</title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script>
        $(function() {
            var ws = new WebSocket("ws://localhost:40000/items");
            ws.onopen = function() {
                $("#status").text("Current Items: Connected");
                $("#items").show();
            };
            ws.onerror = function() {
                $("#items").hide();
                $("#status").text("Current Items: Connection Error");
            };
            ws.onclose = function() {
                $("#items").hide();
                $("#status").text("Current Items: Connection Closed");
            };
	    ws.onmessage = function(msg) {
		var item = JSON.parse(msg.data);
		$("tbody").append("<tr><td>" + item.Key + "</td><td>" + item.Val + "</td></tr>");
            }
        });
    </script>
</head>
<body>
    <h1 id="status">Status</h1>
    <table id="items" hidden="true">
        <thead><tr><th>Key</th><th>Value</th></tr></thead>
        <tbody></tbody>
    </table>
</body>
</html>`
