import React from 'react';
import { Helmet } from 'react-helmet';
import styled from 'styled-components';
import Header from '../Header';
import Footer from '../Footer';

const LayoutContainer = styled.div`
  min-height: 100vh;
  display: flex;
  flex-direction: column;
`;

const Main = styled.main`
  flex: 1;
  padding: 2rem 0;
`;

interface LayoutProps {
  children: React.ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => (
  <LayoutContainer>
    <Helmet>
      <meta charSet="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <link rel="icon" href="/favicon.ico" />
    </Helmet>

    <Header />
    <Main>{children}</Main>
    <Footer />
  </LayoutContainer>
);

export default Layout;
