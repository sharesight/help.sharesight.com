import * as dotenv from 'dotenv';
import type { GatsbyConfig } from 'gatsby';

// Load environment variables
const nodeEnv = process.env.NODE_ENV || 'development';
dotenv.config({
  path: `${__dirname}/.env.${nodeEnv}`,
});

const CONTENTFUL_OPTIONS = {
  environment: process.env.CONTENTFUL_ENVIRONMENT || 'master',
};

const config: GatsbyConfig = {
  siteMetadata: {
    title: 'Sharesight Help',
    description: 'Articles and tutorial videos to help you get started with Sharesight',
    siteUrl:
      process.env.NODE_ENV === 'production'
        ? 'https://help.sharesight.com'
        : 'https://staging-help.sharesight.com',
    author: 'Sharesight',
  },
  plugins: [
    // Localization Plugin
    {
      resolve: '@sharesight/gatsby-plugin-sharesight-localization',
      options: {
        excludePaths: ['/404', '/robots.txt', '/sitemap.xml'],
        locales: ['global', 'au', 'ca', 'nz', 'uk'],
      },
    },
    // Contentful Source
    {
      resolve: 'gatsby-source-contentful',
      options: {
        ...CONTENTFUL_OPTIONS,
        spaceId: process.env.CONTENTFUL_HELP_SPACE_ID,
        accessToken:
          process.env.CONTENTFUL_HELP_PREVIEW_ACCESS_TOKEN ||
          process.env.CONTENTFUL_HELP_ACCESS_TOKEN,
        host: process.env.CONTENTFUL_HELP_PREVIEW_ACCESS_TOKEN
          ? 'preview.contentful.com'
          : undefined,
      },
    },
    {
      resolve: 'gatsby-plugin-eslint',
      options: {
        exclude: ['node_modules', '.cache', 'public'],
        stages: ['develop'],
        failOnError: false,
        failOnWarning: false,
      },
    },
    {
      resolve: 'gatsby-plugin-module-resolver',
      options: {
        root: './',
        aliases: {
          types: './types',
          lib: './lib',
          data: './data',
          components: './src/components',
          helpers: './src/helpers',
          hooks: './src/hooks',
          images: './src/images',
          pages: './src/pages',
          styled: './src/styled',
          'page-data': './src/page-data',
        },
      },
    },
    {
      resolve: 'gatsby-plugin-anchor-links',
      options: {
        offset: -100,
      },
    },
    'gatsby-plugin-react-helmet',
    'gatsby-plugin-styled-components',
    {
      resolve: 'gatsby-source-filesystem',
      options: {
        name: 'images',
        path: `${__dirname}/src/images`,
      },
    },
    {
      resolve: 'gatsby-plugin-exclude',
      options: { paths: ['**/*.stories.*', '**/*.jest.*'] },
    },
    'gatsby-plugin-lodash',
    {
      resolve: `gatsby-plugin-sharp`,
      options: {
        defaults: {
          formats: [`auto`, `webp`],
          placeholder: 'none',
          quality: 100,
          breakpoints: [750, 1080, 1366, 1920],
          backgroundColor: `transparent`,
        },
      },
    },
    `gatsby-transformer-sharp`,
    `gatsby-plugin-image`,
    {
      resolve: 'gatsby-plugin-manifest',
      options: {
        name: 'Sharesight Help',
        short_name: 'Sharesight Help',
        start_url: '/',
        background_color: '#202DAC',
        theme_color: '#FFC21A',
        display: 'minimal-ui',
        icon: 'src/images/favicon.png',
      },
    },
    'gatsby-plugin-sitemap',
    'gatsby-plugin-zopfli',
    'gatsby-react-router-scroll',
    'gatsby-remark-autolink-headers',
    'gatsby-script',
  ],
};

export default config;
