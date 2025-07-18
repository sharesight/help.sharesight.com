export interface Locale {
  id: string;
  path: string;
  name: string;
  lang: string;
  currency: string;
  currency_symbol: string;
  plans_include_tax: boolean;
  cert_type: string;
  country: string;
  for_country: string;
  default_title: string;
  append_title: string;
  footer_ios_alt: string;
  footer_android_alt: string;
  pages: Array<{
    page: string;
    page_title: string;
    page_description?: string;
    sitemap_priority?: number;
    show_in_sitemap?: boolean;
    proxy?: boolean;
  }>;
}

export const locales: Locale[] = [
  {
    id: 'global',
    path: '/',
    name: 'Global',
    lang: 'en',
    currency: 'USD',
    currency_symbol: '$',
    plans_include_tax: false,
    cert_type: 'stock',
    country: '',
    for_country: '',
    default_title: 'Sharesight Help',
    append_title: 'Sharesight Help',
    footer_ios_alt: 'Sharesight Portfolio Tracker iOS App',
    footer_android_alt: 'Sharesight Portfolio Tracker Android App',
    pages: [
      {
        page: 'index',
        page_title: 'Sharesight Help',
        page_description:
          'Articles and tutorial videos to help you get started with Sharesight, as well as to help troubleshoot common issues you may be experiencing.',
        sitemap_priority: 1,
      },
      {
        page: '404',
        page_title: 'Page not found | Sharesight Help',
        page_description:
          'The leading online share portfolio tracker & reporting tool for DIY investors. Track share prices, trades, dividends, performance and tax!',
        show_in_sitemap: false,
      },
    ],
  },
  {
    id: 'au',
    path: '/au/',
    name: 'Australia',
    lang: 'en-AU',
    currency: 'AUD',
    currency_symbol: '$',
    plans_include_tax: true,
    cert_type: 'stock',
    country: 'AU',
    for_country: 'Australia',
    default_title: 'Sharesight Australia Help',
    append_title: 'Sharesight Australia Help',
    footer_ios_alt: 'Sharesight Portfolio Tracker iOS App Australia',
    footer_android_alt: 'Sharesight Portfolio Tracker Android App Australia',
    pages: [
      {
        page: 'index',
        page_title: 'Sharesight Australia Help',
        page_description:
          'Articles and tutorial videos to help you get started with Sharesight Australia, as well as to help troubleshoot common issues you may be experiencing.',
        sitemap_priority: 1,
      },
      {
        page: '404',
        page_title: 'Page not found | Sharesight Australia Help',
        page_description:
          'The leading online share portfolio tracker & reporting tool for DIY investors. Track share prices, trades, dividends, performance and tax!',
        show_in_sitemap: false,
      },
    ],
  },
  {
    id: 'ca',
    path: '/ca/',
    name: 'Canada',
    lang: 'en-CA',
    currency: 'CAD',
    currency_symbol: '$',
    plans_include_tax: false,
    cert_type: 'stock',
    country: 'CA',
    for_country: 'Canada',
    default_title: 'Sharesight Canada Help',
    append_title: 'Sharesight Canada Help',
    footer_ios_alt: 'Sharesight Portfolio Tracker iOS App Canada',
    footer_android_alt: 'Sharesight Portfolio Tracker Android App Canada',
    pages: [
      {
        page: 'index',
        page_title: 'Sharesight Canada Help',
        page_description:
          'Articles and tutorial videos to help you get started with Sharesight Canada, as well as to help troubleshoot common issues you may be experiencing.',
        sitemap_priority: 1,
      },
      {
        page: '404',
        page_title: 'Page not found | Sharesight Canada Help',
        page_description:
          'The leading online share portfolio tracker & reporting tool for DIY investors. Track share prices, trades, dividends, performance and tax!',
        show_in_sitemap: false,
      },
    ],
  },
  {
    id: 'nz',
    path: '/nz/',
    name: 'New Zealand',
    lang: 'en-NZ',
    currency: 'NZD',
    currency_symbol: '$',
    plans_include_tax: true,
    cert_type: 'stock',
    country: 'NZ',
    for_country: 'New Zealand',
    default_title: 'Sharesight New Zealand Help',
    append_title: 'Sharesight New Zealand Help',
    footer_ios_alt: 'Sharesight Portfolio Tracker iOS App New Zealand',
    footer_android_alt: 'Sharesight Portfolio Tracker Android App New Zealand',
    pages: [
      {
        page: 'index',
        page_title: 'Sharesight New Zealand Help',
        page_description:
          'Articles and tutorial videos to help you get started with Sharesight New Zealand, as well as to help troubleshoot common issues you may be experiencing.',
        sitemap_priority: 1,
      },
      {
        page: '404',
        page_title: 'Page not found | Sharesight New Zealand Help',
        page_description:
          'The leading online share portfolio tracker & reporting tool for DIY investors. Track share prices, trades, dividends, performance and tax!',
        show_in_sitemap: false,
      },
    ],
  },
  {
    id: 'uk',
    path: '/uk/',
    name: 'United Kingdom',
    lang: 'en-GB',
    currency: 'USD',
    currency_symbol: '$',
    plans_include_tax: false,
    cert_type: 'share',
    country: 'UK',
    for_country: 'UK',
    default_title: 'Sharesight UK Help',
    append_title: 'Sharesight UK Help',
    footer_ios_alt: 'Sharesight Portfolio Tracker iOS App UK',
    footer_android_alt: 'Sharesight Portfolio Tracker Android App UK',
    pages: [
      {
        page: 'index',
        page_title: 'Sharesight UK Help',
        page_description:
          'Articles and tutorial videos to help you get started with Sharesight UK, as well as to help troubleshoot common issues you may be experiencing.',
        sitemap_priority: 1,
      },
      {
        page: '404',
        page_title: 'Page not found | Sharesight UK Help',
        page_description:
          'The leading online share portfolio tracker & reporting tool for DIY investors. Track share prices, trades, dividends, performance and tax!',
        show_in_sitemap: false,
      },
    ],
  },
];

export const defaultLocale = locales.find(locale => locale.id === 'global') || locales[0];
