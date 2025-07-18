export interface ContentfulHelpCategory {
  id: string;
  name: string;
  order?: number;
}

export interface ContentfulHelpCategoryGraphQLResponse {
  allContentfulCategory: {
    nodes: ContentfulHelpCategory[];
  };
}

export type HelpPageLink = string;
