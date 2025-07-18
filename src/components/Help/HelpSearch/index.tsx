import React, { useState, useMemo } from 'react';
import { Link } from 'gatsby';
import Fuse from 'fuse.js';
import styled from 'styled-components';
import type { ContentfulHelpPage } from '../../../types/help/helpPage';

const SearchContainer = styled.div`
  margin: 2rem 0;
`;

const SearchInput = styled.input`
  width: 100%;
  max-width: 500px;
  padding: 0.75rem;
  border: 2px solid #e5e5e5;
  border-radius: 4px;
  font-size: 1rem;

  &:focus {
    outline: none;
    border-color: #202dac;
  }
`;

const SearchResults = styled.div`
  margin-top: 1rem;
`;

const SearchResultItem = styled.div`
  padding: 1rem;
  border: 1px solid #e5e5e5;
  border-radius: 4px;
  margin-bottom: 0.5rem;
  background: #fff;

  &:hover {
    border-color: #202dac;
  }
`;

const SearchResultLink = styled(Link)`
  color: #202dac;
  text-decoration: none;
  font-weight: 500;

  &:hover {
    text-decoration: underline;
  }
`;

const SearchResultDescription = styled.p`
  color: #666;
  margin: 0.5rem 0 0 0;
  font-size: 0.9rem;
`;

const CategoryTag = styled.span`
  background: #f0f0f0;
  padding: 0.25rem 0.5rem;
  border-radius: 3px;
  font-size: 0.8rem;
  color: #666;
  margin-left: 0.5rem;
`;

interface HelpSearchProps {
  helpPages: ContentfulHelpPage[];
}

const HelpSearch: React.FC<HelpSearchProps> = ({ helpPages }) => {
  const [searchTerm, setSearchTerm] = useState('');

  const fuse = useMemo(() => {
    const options = {
      keys: ['title.title', 'meta_description.meta_description', 'keywords.keywords', 'category.name'],
      threshold: 0.3,
      includeScore: true,
    };

    return new Fuse(helpPages, options);
  }, [helpPages]);

  const searchResults = useMemo(() => {
    if (!searchTerm.trim()) {
      return helpPages.slice(0, 10); // Show first 10 pages when no search
    }

    return fuse.search(searchTerm).map(result => result.item);
  }, [searchTerm, fuse, helpPages]);

  return (
    <SearchContainer>
      <SearchInput
        type="text"
        placeholder="Search help articles..."
        value={searchTerm}
        onChange={e => setSearchTerm(e.target.value)}
      />

      <SearchResults>
        {searchResults.map(page => {
          const pageSlug = page.url_slug || page.title.title.toLowerCase().replace(/\s+/g, '-');

          return (
            <SearchResultItem key={page.id}>
              <SearchResultLink to={`/${pageSlug}`}>
                {page.title.title}
                {page.category && <CategoryTag>{page.category.name}</CategoryTag>}
              </SearchResultLink>
              {page.meta_description?.meta_description && (
                <SearchResultDescription>{page.meta_description.meta_description}</SearchResultDescription>
              )}
            </SearchResultItem>
          );
        })}
      </SearchResults>
    </SearchContainer>
  );
};

export default HelpSearch;
