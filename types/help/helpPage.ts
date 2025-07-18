export interface ContentfulHelpPage {
  id: string;
  title: {
    title: string;
  };
  url_slug?: string;
  meta_description?: {
    meta_description: string;
  };
  content: {
    content: string;
  };
  keywords?: {
    keywords: string;
  };
  order?: number;
  featured_image?: {
    gatsbyImageData: {
      images: {
        sources: Array<{
          srcSet: string;
          sizes: string;
          type: string;
        }>;
        fallback: {
          src: string;
          srcSet: string;
          sizes: string;
        };
      };
      layout: string;
      width: number;
      height: number;
    };
  };
  category?: {
    name: string;
    id: string;
  };
  parent_page?: {
    title: {
      title: string;
    };
    url_slug?: string;
  };
  static_url_slug?: string;
  updatedAt: string;
}

export interface ContentfulHelpPageGraphQLResponse {
  allContentfulPage: {
    nodes: ContentfulHelpPage[];
  };
}

export interface HelpPageLink {
  path: string;
  title: string;
  description?: string;
  category?: string;
}
