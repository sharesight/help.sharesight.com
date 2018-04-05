;(function(){
  const select = document.querySelector("select#page_navigation");

  select.addEventListener('change', function () {
    if (this.value.indexOf('http') === 0 && window.location.href !== this.value) window.location.href = this.value;
  })
})(document, window);
