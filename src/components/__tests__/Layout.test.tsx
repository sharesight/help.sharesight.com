import React from 'react';
import { render } from '@testing-library/react';
import Layout from '../Layout';

// Mock the child components since they're not fully implemented yet
jest.mock(
  '../Header',
  () =>
    function MockHeader() {
      return <div data-testid="header">Sharesight Help</div>;
    }
);

jest.mock(
  '../Footer',
  () =>
    function MockFooter() {
      return <div data-testid="footer">© {new Date().getFullYear()} Sharesight</div>;
    }
);

describe('Layout', () => {
  it('renders children correctly', () => {
    const { getByText } = render(
      <Layout>
        <div>Test Content</div>
      </Layout>
    );

    expect(getByText('Test Content')).toBeInTheDocument();
  });

  it('renders header and footer', () => {
    const { getByTestId } = render(
      <Layout>
        <div>Test Content</div>
      </Layout>
    );

    expect(getByTestId('header')).toBeInTheDocument();
    expect(getByTestId('footer')).toBeInTheDocument();
  });
});
