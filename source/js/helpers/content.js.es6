//= require "../config"
//= require "./page"
//= require "./locale"

const contentManager = {
  updateContent: function(){
    let element // reused for simplicity
    const data        = localeHelper.getLocale()
    const currentPage = pageHelper.getCurrentPage()

    // Update the site logo link's title
    element = document.getElementById('#site_logo')
    if (element && data) element.title = data.default_title

    // Update the site logo image's alt
    element = document.querySelector('img[src*="logo2.svg"]')
    if (element && data) element.alt = data.append_title

    // Update all of the titles
    ;[].concat.apply([], [// flatten
      Array.from(document.querySelectorAll(".footer__links a")), // for the Footer Links
    ]).forEach(element => {
      // only modify titles of same-origin (eg. don't modify title for external urls)
      if (element.origin === document.location.origin) {
        let page = pageHelper.getPage(element.pathname)
        if (page) element.title = page.page_title
      }
    })
  }
}
