import path from 'path';
import { stringToAnchorId } from '../src/helpers/stringToAnchorId';
import { locales } from '../data/locales';
import type { CreatePagesArgs } from 'gatsby';
import type {
  ContentfulHelpCategoryGraphQLResponse,
  ContentfulHelpCategory,
} from '../types/help/helpCategory';

export const createHelpCategoryPages = async ({ graphql, actions, reporter }: CreatePagesArgs) => {
  const { createPage } = actions;

  const ContentfulHelpCategoryResult = await graphql<ContentfulHelpCategoryGraphQLResponse>(`
    query ContentfulHelpCategory {
      allContentfulCategory {
        nodes {
          id
          name
          order
        }
      }
    }
  `);

  if (ContentfulHelpCategoryResult.errors) {
    reporter.panicOnBuild(
      `There was an error loading your help category pages`,
      ContentfulHelpCategoryResult.errors
    );
  }

  const allCategories: ContentfulHelpCategory[] =
    ContentfulHelpCategoryResult.data?.allContentfulCategory.nodes || [];
  const helpCategoryTemplate = path.resolve('./src/templates/helpCategory.tsx');

  // Create category pages for each locale
  locales.forEach(locale => {
    allCategories.forEach(category => {
      if (!category.name) {
        return;
      }

      const categorySlug = stringToAnchorId(category.name);
      const categoryPath =
        locale.id === 'global'
          ? `/category/${categorySlug}`
          : `/${locale.id}/category/${categorySlug}`;

      createPage({
        path: categoryPath,
        component: helpCategoryTemplate,
        context: {
          categoryId: category.id,
          locale,
          categorySlug,
        },
      });
    });
  });
};
