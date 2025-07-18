(function (d, w) {
  const hamburger = d.getElementById('js-hamburger');
  const close = d.getElementById('js-close');
  const sliding_menu = d.getElementById('js-sliding-menu');
  const menu_mask = d.getElementById('menu_mask');
  const menu_wrapper = d.getElementById('menu_wrapper');
  const keys = { 37: 1, 38: 1, 39: 1, 40: 1 };

  if (sliding_menu) {
    sliding_menu.style.display = 'none';
  }
  if (hamburger) {
    hamburger.onfocus = function (event) {
      this.onkeypress = function (e) {
        if (e.which === 13 || e.keyCode === 13) {
          openMenu();
        }
      };
    };
    hamburger.onclick = function (e) {
      openMenu();
    };
  }

  if (close) {
    close.onclick = function (e) {
      closeMenu();
    };
    close.onfocus = function (event) {
      this.onkeypress = function (e) {
        if (e.which === 13 || e.keyCode === 13) {
          closeMenu();
        }
      };
    };
  }

  if (menu_mask) {
    menu_mask.onclick = function (e) {
      sliding_menu.setAttribute('data-menu-visibility', 0);
      sliding_menu.style.display = 'none';
      menu_mask.style.display = 'none';
      enableScroll();
      return false;
    };
  }

  function openMenu() {
    sliding_menu.style.display = 'block';
    sliding_menu.setAttribute('data-menu-visibility', 1);
    menu_mask.style.display = 'block';
    disableScroll();
    return false;
  }

  function closeMenu() {
    sliding_menu.setAttribute('data-menu-visibility', 0);
    menu_mask.style.display = 'none';
    sliding_menu.style.display = 'none';
    enableScroll();
    return false;
  }

  function preventDefault(e) {
    e = e || window.event;
    if (e.preventDefault) {
      e.preventDefault();
    }
    e.returnValue = false;
  }

  function preventDefaultForScrollKeys(e) {
    if (keys[e.keyCode]) {
      preventDefault(e);
      return false;
    }
  }

  function disableScroll() {
    if (w.addEventListener) {
      w.addEventListener('DOMMouseScroll', preventDefault, false);
      w.onwheel = preventDefault;
      w.onmousewheel = d.onmousewheel = preventDefault; // older browsers, IE
      w.ontouchmove = preventDefault; // mobile
      d.onkeydown = preventDefaultForScrollKeys;
    }
  }

  function enableScroll() {
    if (w.removeEventListener) {
      w.removeEventListener('DOMMouseScroll', preventDefault, false);
    }
    w.onmousewheel = d.onmousewheel = null;
    w.onwheel = null;
    w.ontouchmove = null;
    d.onkeydown = null;
  }
})(document, window);
