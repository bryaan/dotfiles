#!/usr/bin/env babel-node
// chmod u+x bootstrap.js

// npm i -g npx && npm i
// npx babel-node bootstrap.js --presets env



var fs = require('fs');
var path = require('path');
var shell = require('shelljs');

// if (process.argv.length <= 2) {
//     console.log("Usage: " + __filename + " path/to/directory");
//     process.exit(-1);
// }

// var path = process.argv[2];

// fs.readdir(path, function(err, items) {
//     for (var i=0; i<items.length; i++) {
//         var file = path + '/' + items[i];

//         console.log("Start: " + file);
//         fs.stat(file, generate_callback(file));
//     }
// });

// function generate_callback(file) {
//     return function(err, stats) {
//             console.log(file);
//             console.log(stats["size"]);
//         }
// };

// Im thinking the most flexible is also a bit verbose.
// Be 100% imperative.  Tell it which files and how.

const hostname = (hostname) => ({ type: 'hostname', value: hostname })
const os = (osname) => ({ type: 'os', value: osname })

const OS = { Mac: os('mac'), Linux: os('linux') }
const PC = {
	CLASSIFIED: hostname('CLASSIFIED'),
	MacbookAir: hostname('Bryan\'s Air')
}


const schema = [
	{ path: '/my/file', labels: [OS.Mac, PC.MacbookAir] }
]


const src = "~/path/from/home/test.sh"

// const fileName = src subtract home path.
const dst = path.join(process.env.HOME, '.' + fileName)

const template = new Template('link_file #{src} #{dst}');


// shell.exec(`link_file ${src} ${dst}`)




// bootstrap(schema)


