import path from 'path';
import { stringToAnchorId } from '../src/helpers/stringToAnchorId';
import { locales } from '../data/locales';
import type { CreatePagesArgs } from 'gatsby';
import type { ContentfulHelpPageGraphQLResponse, ContentfulHelpPage } from '../types/help/helpPage';

export const createHelpPages = async ({ graphql, actions, reporter }: CreatePagesArgs) => {
  const { createPage } = actions;

  const ContentfulHelpPageResult = await graphql<ContentfulHelpPageGraphQLResponse>(`
    query ContentfulHelpPage {
      allContentfulPage {
        nodes {
          id
          title {
            title
          }
          url_slug
          meta_description {
            meta_description
          }
          content {
            content
          }
          keywords {
            keywords
          }
          order
          featured_image {
            gatsbyImageData
          }
          category {
            name
            id
          }
          parent_page {
            title {
              title
            }
            url_slug
          }
          static_url_slug
          updatedAt
        }
      }
    }
  `);

  if (ContentfulHelpPageResult.errors) {
    reporter.panicOnBuild(
      `There was an error loading your help pages`,
      ContentfulHelpPageResult.errors
    );
  }

  const allPages: ContentfulHelpPage[] =
    ContentfulHelpPageResult.data?.allContentfulPage.nodes || [];
  const helpPageTemplate = path.resolve('./src/templates/helpPage.tsx');

  // Create pages for each locale
  locales.forEach(locale => {
    allPages.forEach(page => {
      if (!page.title?.title || !page.content?.content) {
        return;
      }

      const rawSlug = page.url_slug || stringToAnchorId(page.title.title);
      // Normalize slug by removing leading slash and ensuring it's clean
      const slug = rawSlug.replace(/^\//, '').replace(/\/$/, '');
      const pagePath = locale.id === 'global' ? `/${slug}` : `/${locale.id}/${slug}`;

      createPage({
        path: pagePath,
        component: helpPageTemplate,
        context: {
          pageId: page.id,
          locale,
          slug,
        },
      });
    });
  });
};
