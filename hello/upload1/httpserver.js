'use strict';

let path = require('path');
let http = require('http');
const querystring = require('querystring');

let getContentDisposition = function(data) {
    let ss = data.split('\r\n');
    for (let i = 0; i < ss.length; i++) {
        let s = ss[i];
        let index = s.indexOf('name=');

    }
};

let server = http.createServer(function(req, res) {
    console.log(req);

    if (req.url.startsWith('/upload') && req.method.toLowerCase() === 'post') {
        let data = '';

        // 通过req的data事件监听函数，每当接受到请求体的数据，就累加到data变量中
        req.on('data', function(chunk){
            data += chunk;
        });

        // 在end事件触发后，解释请求体，取出sql语句，然后向客户端返回。
        req.on('end', function() {
            let ss = data.match(/(file\.[^]*?[\S]*?--)/g);
            let fileInfo = {};
            ss.map(s => s.replace(/[ \f\n\r\t\v\-]/g, "")).forEach(s => {
                let a = s.split('"');
                if (a.length > 1) {
                    if (a[0] === 'file.size') {
                        fileInfo[a[0]] = Number(a[1]);
                    }
                    else {
                        fileInfo[a[0]] = a[1];
                    }
                }
            });
            res.writeHead(200, {'Content-Type': 'text/plain'});
            res.end("OK, i am ---");
        })
    }
    // var contentDisposition = require('./content-disposition');
    // var disposition = contentDisposition.parse(data);
    // data = querystring.parse(data);

    // var filenameRegex = /file.name[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
    // var matches = filenameRegex.exec(data);
    // var filename = "";
    // if (matches != null && matches[1]) {
    //     filename = matches[1].replace(/['"]/g, '');
    // }

    /*
    let data = "--------------------------fa1b4dc84321a582\n" +
        "Content-Disposition: form-data; name=\"file.name\"\n" +
        "\n" +
        "a1\n" +
        "--------------------------fa1b4dc84321a582\n" +
        "Content-Disposition: form-data; name=\"file.content_type\"\n" +
        "\n" +
        "text/plain\n" +
        "--------------------------fa1b4dc84321a582\n" +
        "Content-Disposition: form-data; name=\"file.path\"\n" +
        "\n" +
        "/tmp/nginx_upload/0000000030\n" +
        "--------------------------fa1b4dc84321a582\n" +
        "Content-Disposition: form-data; name=\"file.md5\"\n" +
        "\n" +
        "c36cb28e18c75cff0c269ecf3806e1d4\n" +
        "--------------------------fa1b4dc84321a582\n" +
        "Content-Disposition: form-data; name=\"file.size\"\n" +
        "\n" +
        "490\n" +
        "--------------------------fa1b4dc84321a582--\n";

     */
    // let fileAttrs = data.match(/(name=\"(file\.[\S]*)\"[$]*?)/m);
    // console.log(fileAttrs);

    // let ss = data.split('\r\n');

    // var contentDisposition = data;
    // var startIndex = contentDisposition.indexOf("file.name") + 10; // Adjust '+ 10' if filename is not the right one.
    // var endIndex = contentDisposition.length - 1; //Check if '- 1' is necessary
    // var filename = contentDisposition.substring(startIndex, endIndex);
    // console.log("filename: " + filename)
    // console.log(filename);

    // res.end("OK, i am ---");
});

// this.route.all(/\/(.){0,}.cgi/, function (req, res) {
//    res.end('Hello World!');
// });

// this.route.all(/^\/upload/, function (req, res) {
//     let form = new formidable.IncomingForm(),
//         files = [],
//         fields = [];
//
//     form.uploadDir = os.tmpdir();
//
//     form
//         .on('field', function(field, value) {
//             console.log(field, value);
//             fields.push([field, value]);
//         })
//         .on('file', function(field, file) {
//             console.log(field, file);
//             files.push([field, file]);
//         })
//         .on('end', function() {
//             console.log('-> upload done');
//             res.writeHead(200, {'content-type': 'text/plain'});
//             res.write('received fields:\n\n '+util.inspect(fields));
//             res.write('\n\n');
//             res.end('received files:\n\n '+util.inspect(files));
//         });
//     form.parse(req);
// });

// this.route.all(/\/(.){0,}.sql/, function (req, res) {
//
//
//     // 定义了一个data变量，用于暂存请求体的信息
//     let data = '';
//
//     // 通过req的data事件监听函数，每当接受到请求体的数据，就累加到data变量中
//     req.on('data', function(chunk){
//         data += chunk;
//     });
//
//     // 在end事件触发后，解释请求体，取出sql语句，然后向客户端返回。
//     req.on('end', function(){
//         // data = querystring.parse(data);
//         data = JSON.parse(data);
//         console.log(data);
//         res.writeHead(200, {'Content-Type': 'text/plain'});
//         res.end();
//     });
//
// });

server.on('checkContinue', function(req, res) {
    let msg = 'step checkContinue' + Date();
    res.writeContinue();
    console.log(msg);
});

server.on('clientError', (err, socket) => {
    let msg = 'step clientError' + Date();
    socket.end('HTTP/1.1 400 Bad Request\r\n\r\n');
    console.log(msg);
});

server.on('close', function() {
    let msg = 'step close' + Date();
    console.log(msg);
});

server.on('connect', function(req, socket, firstBodyChunk) {
    let msg = 'step connect' + Date();
    console.log(msg);
});

server.on('connection', function(connection) {
    let msg = 'step connection' + Date();
    console.log(msg);
});

server.on('upgrade', function(req, socket, head) {
    let msg = 'step upgrade' + Date();
    console.log(msg);
});

server.listen(8080);
console.log('http://localhost:%s', 8080);
