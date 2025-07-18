import React from 'react';
import { Link } from 'gatsby';
import styled from 'styled-components';

const BreadcrumbsContainer = styled.nav`
  margin-bottom: 2rem;
`;

const BreadcrumbsList = styled.ol`
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
`;

const BreadcrumbItem = styled.li`
  display: flex;
  align-items: center;

  &:not(:last-child)::after {
    content: '/';
    margin: 0 0.5rem;
    color: #999;
  }
`;

const BreadcrumbLink = styled(Link)`
  color: #202dac;
  text-decoration: none;

  &:hover {
    text-decoration: underline;
  }
`;

const BreadcrumbCurrent = styled.span`
  color: #666;
  font-weight: 500;
`;

interface BreadcrumbItem {
  label: string;
  path: string;
  current?: boolean;
}

interface BreadcrumbsProps {
  items: BreadcrumbItem[];
}

const Breadcrumbs: React.FC<BreadcrumbsProps> = ({ items }) => (
  <BreadcrumbsContainer aria-label="Breadcrumb">
    <BreadcrumbsList>
      {items.map((item, index) => (
        <BreadcrumbItem key={index}>
          {item.current ? (
            <BreadcrumbCurrent>{item.label}</BreadcrumbCurrent>
          ) : (
            <BreadcrumbLink to={item.path}>{item.label}</BreadcrumbLink>
          )}
        </BreadcrumbItem>
      ))}
    </BreadcrumbsList>
  </BreadcrumbsContainer>
);

export default Breadcrumbs;
