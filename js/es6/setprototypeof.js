let target = {};
let proxy = new Proxy(target, {
  getPrototypeOf(trapTarget) {
    return null;
  },
  setPrototypeOf(trapTarget, proto) {
    return false;
  }
});

let targetProto = Object.getPrototypeOf(target);
let proxyProto = Object.getPrototypeOf(proxy);

console.log(targetProto === Object.prototype);
console.log(proxyProto === Object.prototype);
console.log(proxyProto);

// succeeds
Object.setPrototypeOf(target, {});

// throws error
Object.setPrototypeOf(proxy, {});

