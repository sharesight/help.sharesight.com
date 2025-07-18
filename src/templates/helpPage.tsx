import React from 'react';
import { graphql } from 'gatsby';
import { Helmet } from 'react-helmet';
import Layout from '../components/Layout';
import Breadcrumbs from '../components/Breadcrumbs';
import type { PageProps } from 'gatsby';
import type { ContentfulHelpPage } from '../../types/help/helpPage';
import type { Locale } from '../../data/locales';

interface HelpPageContext {
  pageId: string;
  locale: Locale;
  slug: string;
}

interface HelpPageData {
  contentfulHelpPage: ContentfulHelpPage;
}

const HelpPageTemplate: React.FC<PageProps<HelpPageData, HelpPageContext>> = ({
  data,
  pageContext,
}) => {
  const { contentfulPage: page } = data;
  const { locale } = pageContext;

  if (!page) {
    return (
      <Layout>
        <div className="container">
          <h1>Page not found</h1>
        </div>
      </Layout>
    );
  }

  const breadcrumbItems = [
    { label: 'Help', path: locale.id === 'global' ? '/' : `/${locale.id}` },
    ...(page.category
      ? [
          {
            label: page.category.name,
            path:
              locale.id === 'global'
                ? `/category/${page.category.id}`
                : `/${locale.id}/category/${page.category.id}`,
          },
        ]
      : []),
    ...(page.parent_page
      ? [
          {
            label: page.parent_page.title.title,
            path:
              locale.id === 'global'
                ? `/${page.parent_page.url_slug || ''}`
                : `/${locale.id}/${page.parent_page.url_slug || ''}`,
          },
        ]
      : []),
    { label: page.title.title, path: '', current: true },
  ];

  const lastModified = new Date(page.updatedAt).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });

  return (
    <Layout>
      <Helmet>
        <title>
          {page.title.title} | {locale.default_title}
        </title>
        {page.meta_description?.meta_description && <meta name="description" content={page.meta_description.meta_description} />}
      </Helmet>

      <div className="container help-page-container">
        <Breadcrumbs items={breadcrumbItems} />

        <div className="content">
          <article className="article">
            <h1>{page.title.title}</h1>

            <div
              className="article-content"
              dangerouslySetInnerHTML={{
                __html: page.content.content,
              }}
            />

            <p className="date_modified">Last modified on {lastModified} UTC</p>
          </article>
        </div>
      </div>
    </Layout>
  );
};

export const query = graphql`
  query HelpPageQuery($pageId: String!) {
    contentfulPage(id: { eq: $pageId }) {
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
`;

export default HelpPageTemplate;
