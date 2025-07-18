import { CreatePagesArgs } from 'gatsby';
import generateRobotstxt from 'generate-robotstxt';

export const createRobotsTxt = async ({ actions }: CreatePagesArgs) => {
  const { createPage } = actions;

  const robotsTxt = generateRobotstxt({
    policy: [
      {
        userAgent: '*',
        allow: '/',
        disallow: ['/admin/', '/private/'],
      },
    ],
    sitemap: 'https://help.sharesight.com/sitemap.xml',
  });

  createPage({
    path: '/robots.txt',
    component: require.resolve('./robotsTxtTemplate'),
    context: {
      robotsTxt,
    },
  });
};
