;(function(){
  const select = document.querySelector("select#page_navigation");

  if (select) {
    select.addEventListener('change', function () {
      if (this.value.indexOf('http') === 0 && window.location.href !== this.value) window.location.href = this.value;
    })
  }
})(document, window);
