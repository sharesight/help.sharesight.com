import React from 'react';
import { graphql } from 'gatsby';
import { Helmet } from 'react-helmet';
import Layout from '../components/Layout';
import HelpSearch from '../components/Help/HelpSearch';
import type { PageProps } from 'gatsby';
import type { ContentfulHelpPageGraphQLResponse } from '../../types/help/helpPage';

interface IndexPageContext {
  locale: {
    id: string;
    name: string;
    default_title: string;
  };
}

const IndexPage: React.FC<PageProps<ContentfulHelpPageGraphQLResponse, IndexPageContext>> = ({
  data,
  pageContext,
}) => {
  const { locale } = pageContext;
  const helpPages = data.allContentfulPage.nodes;

  // Fallback for locales that don't exist in our locales.ts
  const fallbackLocale = {
    id: locale?.id || 'global',
    name: locale?.name || 'Global',
    default_title: locale?.default_title || 'Sharesight Help',
  };

  return (
    <Layout>
      <Helmet>
        <title>{fallbackLocale.default_title}</title>
        <meta
          name="description"
          content="Articles and tutorial videos to help you get started with Sharesight, as well as to help troubleshoot common issues you may be experiencing."
        />
      </Helmet>

      <div className="container">
        <h1>Sharesight Help</h1>
        <p>Find answers to your questions and learn how to use Sharesight effectively.</p>

        <HelpSearch helpPages={helpPages} />
      </div>
    </Layout>
  );
};

export const query = graphql`
  query HelpPagesQuery {
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
        category {
          name
        }
      }
    }
  }
`;

export default IndexPage;
