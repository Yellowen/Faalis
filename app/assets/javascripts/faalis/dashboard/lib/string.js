String.prototype.readable = function() {
  return this.replace(/::/g, ' ').humanize();
};
