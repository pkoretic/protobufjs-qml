import QtQuick 2.9
import "proto.js" as PROTO

QtObject
{
    Component.onCompleted:
    {
        var data = { hello: "world" }

        var Message = PROTO.$root["Message"]

        var errMsg = Message.verify(data)
        if (errMsg)
            throw Error(errMsg)

        var buffer = Message.encode(Message.create(data)).finish()

        var xhr = new XMLHttpRequest
        xhr.open("POST", 'http://localhost', true)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE)
                console.log(xhr.status, xhr.responseText)
        }

        // .send doesn't support binary data as in browsers
        xhr.send(String.fromCharCode.apply(null, buffer))
    }
}
