//= require "./config"
//= require "./helpers/cookies"
//= require "./helpers/locale"
//= require "./helpers/page"
//= require "./helpers/url"


/*
 * NOTE: This file, and associated files, are adapted from our marketing website.
 * See: `https://github.com/sharesight/www.sharesight.com/blob/master/source/js/localization.js.es6`
 *
 * Most of this localization script is not used on help.sharesight.com
 * This is a fairly stripped down version of www.sharesight.com's code.
 * Eg. content modification and url rewriting is gone.
 *
 * This code, generally, is strictly for the localization dropdown, and is drastic overkill for that.
 * If you need to modify this code, please look at the original file first to see if that functionality exists.
 */

const localization = {
  setLocaleId: false,

  onLoad () {
    this.initializeRegionSelector()
  },

  isGlobalOnlyPage () {
    if (document.getElementById('_404')) return true
    return false
  },

  setLocale (locale_id) {
    if (!locale_id || typeof locale_id !== 'string' || !localeHelper.isValidLocaleId(locale_id)) {
      locale_id = config.default_locale_id
    }

    locale_id = locale_id.toLowerCase()

    this.setLocaleId = locale_id
    cookieManager.setCookie(locale_id)

    // if we're not on a page that begins with the current locale, which should be localized, refresh the page and Cloudfront's localization should kick in
    if (!this.isGlobalOnlyPage() && window.location.pathname.indexOf(`/${locale_id}`) !== 0) {
      window.location.href = urlHelper.localizePath(window.location.pathname, locale_id);
    }
  },

  getCurrentLocaleId () {
    if (this.setLocaleId) return this.setLocaleId;
    return localeHelper.getCookieLocale();
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
