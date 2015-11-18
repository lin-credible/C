---
[How to Open Database Connections in a Node.js/Express App](https://medium.com/@tarkus/how-to-open-database-connections-in-a-node-js-express-app-e14b2de5d1f8)

[Some codes](https://gist.github.com/koistya/80eeb10a5b058abebe12#file-server-js)

I'm new to Node.js...:bowtie:
```
node -v
v5.0.0
```
:joy::sob:Here is my errors:
- shell>node server.js       
```
(function (exports, require, module, __filename, __dirname) { import express from 'express';
                                                              ^^^^^^

SyntaxError: Unexpected token import
    at exports.runInThisContext (vm.js:53:16)
    at Module._compile (module.js:404:25)
    at Object.Module._extensions..js (module.js:432:10)
    at Module.load (module.js:356:32)
    at Function.Module._load (module.js:311:12)
    at Function.Module.runMain (module.js:457:10)
    at startup (node.js:136:18)
    at node.js:972:3
```
:broken_heart:
- shell> node --harmony server.js
```
same errors as above
```

- shell>traceur --out server-compiled.js --script server.js
```
Unexpected reserved word import',
...
```

:cherries:

:cherries: Damn... :pray::v:
