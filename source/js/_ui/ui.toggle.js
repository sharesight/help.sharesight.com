(function () {
  const el = document.querySelector('.side-menu');

  if (el) {
    targets = el.getElementsByTagName('h4');
    for (let i = 0; i < targets.length; i++) {
      targets[i].addEventListener('click', function () {
        if (this.getAttribute('data-toggle') == 0) {
          for (let i = 0; i < targets.length; i++) {
            targets[i].setAttribute('data-toggle', 0);
          }
          this.setAttribute('data-toggle', 1);
        } else {
          this.setAttribute('data-toggle', 0);
        }
      });
    }
  }
})();
