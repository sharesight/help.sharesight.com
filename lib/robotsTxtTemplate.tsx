import React from 'react';
import type { PageProps } from 'gatsby';

interface RobotsTxtContext {
  robotsTxt: string;
}

const RobotsTxtTemplate: React.FC<PageProps<Record<string, never>, RobotsTxtContext>> = ({
  pageContext,
}) => <pre>{pageContext.robotsTxt}</pre>;

export default RobotsTxtTemplate;
