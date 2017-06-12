let rejected;

process.on('unhandledRejection', function(reason, promise) {
  console.log(reason.message);
  console.log(rejected === promise);
});

rejected = Promise.reject(new Error('Explosion'));
