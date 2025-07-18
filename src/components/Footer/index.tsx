import React from 'react';
import styled from 'styled-components';

const FooterContainer = styled.footer`
  background: #f5f5f5;
  border-top: 1px solid #e5e5e5;
  padding: 2rem 0;
  margin-top: auto;
`;

const FooterContent = styled.div`
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
  text-align: center;
  color: #666;
`;

const Footer: React.FC = () => (
  <FooterContainer>
    <FooterContent>
      <p>&copy; {new Date().getFullYear()} Sharesight. All rights reserved.</p>
      <p>
        <a href="https://www.sharesight.com" target="_blank" rel="noopener noreferrer">
          Visit Sharesight
        </a>
      </p>
    </FooterContent>
  </FooterContainer>
);

export default Footer;
