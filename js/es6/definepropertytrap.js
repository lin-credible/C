let proxy = new Proxy({}, {
  defineProperty(trapTarget, key, descriptor) {
    return Reflect.defineProperty(trapTarget, key, descriptor);
  },
  getOwnPropertyDescriptor(trapTarget, key) {
    return Reflect.getOwnPropertyDescriptor(trapTarget, key);
  }
});

Object.defineProperty(proxy, 'name', {
  value: 'proxy'
});

console.log(proxy.name);

let descriptor = Object.getOwnPropertyDescriptor(proxy, 'name');

console.log(descriptor.value);

