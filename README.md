# protobufjs-qml
This is a port of [protobufjs minimal](https://github.com/dcodeIO/protobuf.js/tree/master/dist/minimal) for QML excluding Services support.

## Usage

Build your .proto files in a static mode using [pbjs](https://github.com/dcodeIO/protobuf.js/tree/master/cli) (removes function wrap which prevents QML exposing the JS logic)

```
pbjs -t static -w closure -o proto.js message.proto
```

Add QML import to `proto.js` at the top (QML can't import in lowercase) and provide the needed
reference:

```
.import "protobuf.js" as Protobuf
var $protobuf = Protobuf
```

Send a protobuf message using HTTP:

```
.import "proto.js" as PROTO

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

// QML doesn't support binary data in XMLHTTPREQUEST send method as browsers do
xhr.send(String.fromCharCode.apply(null, buffer))

```
## Notes

For porters and future work.

 - QML doesn't support module.exports or require
 - Uint8Array is not properly implemented(replaced with Array)
