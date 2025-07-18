import React from 'react';
import { Link } from 'gatsby';
import styled from 'styled-components';

const HeaderContainer = styled.header`
  background: #fff;
  border-bottom: 1px solid #e5e5e5;
  padding: 1rem 0;
`;

const HeaderContent = styled.div`
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
`;

const Logo = styled(Link)`
  font-size: 1.5rem;
  font-weight: bold;
  color: #202dac;
  text-decoration: none;

  &:hover {
    text-decoration: underline;
  }
`;

const Navigation = styled.nav`
  display: flex;
  gap: 2rem;
`;

const NavLink = styled(Link)`
  color: #333;
  text-decoration: none;

  &:hover {
    color: #202dac;
    text-decoration: underline;
  }
`;

const Header: React.FC = () => (
  <HeaderContainer>
    <HeaderContent>
      <Logo to="/">Sharesight Help</Logo>
      <Navigation>
        <NavLink to="/">Home</NavLink>
        <NavLink to="/search">Search</NavLink>
      </Navigation>
    </HeaderContent>
  </HeaderContainer>
);

export default Header;
