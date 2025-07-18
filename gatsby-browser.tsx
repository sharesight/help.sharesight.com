import React from 'react';
import { createGlobalStyle } from 'styled-components';

const GlobalStyle = createGlobalStyle`
  * {
    box-sizing: border-box;
  }

  body {
    margin: 0;
    padding: 0;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
      'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
      sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    line-height: 1.6;
    color: #333;
  }

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;
  }

  .help-page-container {
    display: grid;
    grid-template-columns: 250px 1fr;
    gap: 2rem;

    @media (max-width: 768px) {
      grid-template-columns: 1fr;
    }
  }

  .article {
    background: #fff;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }

  .article h1 {
    color: #202DAC;
    margin-bottom: 1rem;
  }

  .article-content {
    line-height: 1.8;
  }

  .article-content h2,
  .article-content h3,
  .article-content h4 {
    color: #202DAC;
    margin-top: 2rem;
    margin-bottom: 1rem;
  }

  .article-content p {
    margin-bottom: 1rem;
  }

  .article-content ul,
  .article-content ol {
    margin-bottom: 1rem;
    padding-left: 2rem;
  }

  .article-content code {
    background: #f5f5f5;
    padding: 0.2rem 0.4rem;
    border-radius: 3px;
    font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
  }

  .article-content pre {
    background: #f5f5f5;
    padding: 1rem;
    border-radius: 4px;
    overflow-x: auto;
  }

  .date_modified {
    color: #666;
    font-size: 0.9rem;
    margin-top: 2rem;
    padding-top: 1rem;
    border-top: 1px solid #e5e5e5;
  }

  .help-pages-list {
    display: grid;
    gap: 1rem;
  }

  .help-page-item {
    background: #fff;
    padding: 1rem;
    border: 1px solid #e5e5e5;
    border-radius: 4px;

    &:hover {
      border-color: #202DAC;
    }
  }

  .help-page-link {
    text-decoration: none;
    color: inherit;

    h3 {
      margin: 0;
      color: #202DAC;
    }
  }
`;

export const wrapRootElement = ({ element }: { element: React.ReactElement }) => (
  <>
    <GlobalStyle />
    {element}
  </>
);
