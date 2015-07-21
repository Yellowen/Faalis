function redirect_to(target) {
  console.log("Redirecting to: %s", target);
  Turbolinks.visit(target, {
    cacheRequest: false,
    keep: ['flash-alert']
  });
}
