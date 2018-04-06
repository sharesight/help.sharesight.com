//= require "./config"
//= require "./helpers/cookies"
//= require "./helpers/content"
//= require "./helpers/locale"
//= require "./helpers/page"
//= require "./helpers/url"

const localization = {
  setLocaleId: false,

  onLoad () {
    this.initializeRegionSelector()
    this.modifyContent()
  },

  isGlobalOnlyPage () {
    if (document.getElementById('_404')) return true
    return false
  },

  modifyContent () {
    this.updateUrls()
    contentManager.updateContent()
  },

  setLocale (locale_id) {
    if (!locale_id || typeof locale_id !== 'string' || !localeHelper.isValidLocaleId(locale_id)) {
      locale_id = config.default_locale_id
    }

    locale_id = locale_id.toLowerCase()

    this.setLocaleId = locale_id
    cookieManager.setCookie(locale_id)
    this.modifyContent()

    // if we're not on a page that begins with the current locale, which should be localized, refresh the page and Cloudfront's localization should kick in
    if (!this.isGlobalOnlyPage() && window.location.pathname.indexOf(`/${locale_id}`) !== 0) {
      window.location.href = urlHelper.localizePath(window.location.pathname, locale_id);
    }
  },

  getCurrentLocaleId () {
    if (this.setLocaleId) return this.setLocaleId;
    return localeHelper.getCookieLocale();
  },

  updateUrls () {
    ;[].concat.apply([], // flatten arrays of arrays
      [
        config.base_url, // absolute urls (www.sharesight.com)
        config.marketing_url, // help site (help.sharesight.com)
        `${config.base_path}/`.replace(/\/+/g, '/'), // relative urls (/faq); replace duplicate slashes
      ].map(path => Array.from(document.querySelectorAll(`a[href^="${path}"]`)))
    ).forEach((element) => {
      // don't localize urls that are inside of the help article, as they may go to another locale
      if (!element.matches('article.article a')) {
        element.pathname = urlHelper.localizePath(element.pathname)
      }
    })
  },

  getRegionSelectorNode () {
    if (this.regionSelector) return this.regionSelector
    this.regionSelector = document.getElementById('region_selector')
    return this.regionSelector
  },

  initializeRegionSelector () {
    const self = this
    const selector = this.getRegionSelectorNode();
    if (!selector || !selector.options || !selector.options.length) return

    this.setRegionSelectorValue()
    this.setCookieFromRegionSelector();

    // when it changes, set locale
    selector.onchange = function () {
      self.setLocale(this.value)
    }
  },

  setRegionSelectorValue () {
    const selector = this.getRegionSelectorNode();
    const newLocaleId = this.getCurrentLocaleId();
    if (!this.isGlobalOnlyPage()) return // only set the region selector on global pages (eg. blog, which has no locale attached to it)
    if (this.getCurrentLocaleId() === config.default_locale_id) return // don't set a global cookie unless the user changes it themselves
    if (selector.value === this.getCurrentLocaleId()) return

    // set the region selector to match the current locale on unlocalized pages
    Array.from(selector.options).forEach(option => {
      option.removeAttribute('selected')

      if (option.value.toLowerCase() === this.getCurrentLocaleId()) {
        option.setAttribute('selected', true)
      }
    })
  },

  setCookieFromRegionSelector () {
    const selector = this.getRegionSelectorNode()
    if (selector.value === config.default_locale_id) return // don't set a global cookie when the page loads
    this.setLocale(selector.value)
  },
}

;(() => {
  document.addEventListener('DOMContentLoaded', () => {
    localization.onLoad()
  })
})()
