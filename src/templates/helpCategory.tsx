import React from 'react';
import { graphql, Link } from 'gatsby';
import { Helmet } from 'react-helmet';
import Layout from '../components/Layout';
import Breadcrumbs from '../components/Breadcrumbs';
import type { PageProps } from 'gatsby';
import type { ContentfulHelpCategory } from '../../types/help/helpCategory';
import type { Locale } from '../../data/locales';

interface HelpCategoryContext {
  categoryId: string;
  locale: Locale;
  categorySlug: string;
}

interface HelpCategoryData {
  contentfulHelpCategory: ContentfulHelpCategory;
}

const HelpCategoryTemplate: React.FC<PageProps<HelpCategoryData, HelpCategoryContext>> = ({
  data,
  pageContext,
}) => {
  const { contentfulHelpCategory: category } = data;
  const { locale } = pageContext;

  if (!category) {
    return (
      <Layout>
        <div className="container">
          <h1>Category not found</h1>
        </div>
      </Layout>
    );
  }

  const breadcrumbItems = [
    { label: 'Help', path: locale.id === 'global' ? '/' : `/${locale.id}` },
    { label: category.name, path: '', current: true },
  ];

  return (
    <Layout>
      <Helmet>
        <title>
          {category.name} | {locale.default_title}
        </title>
        <meta name="description" content={`Help articles in the ${category.name} category`} />
      </Helmet>

      <div className="container">
        <Breadcrumbs items={breadcrumbItems} />

        <div className="content">
          <h1>{category.name}</h1>

          <div className="help-pages-list">
            <p>No help pages found in this category.</p>
          </div>
        </div>
      </div>
    </Layout>
  );
};

export const query = graphql`
  query HelpCategoryQuery($categoryId: String!) {
    contentfulCategory(id: { eq: $categoryId }) {
      id
      name
      order
    }
  }
`;

export default HelpCategoryTemplate;
