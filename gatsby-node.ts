import path from 'path';
import { createHelpPages } from './lib/createHelpPages';
import { createHelpCategoryPages } from './lib/createHelpCategoryPages';
import { createRobotsTxt } from './lib/createRobotsTxt';
import type { GatsbyNode } from 'gatsby';

export const onCreateBabelConfig: GatsbyNode['onCreateBabelConfig'] = ({ actions }) => {
  actions.setBabelPlugin({
    name: '@babel/plugin-transform-react-jsx',
    options: {
      runtime: 'automatic',
    },
  });
};

export const onCreateWebpackConfig: GatsbyNode['onCreateWebpackConfig'] = ({ actions }) => {
  actions.setWebpackConfig({
    module: {
      rules: [
        {
          test: path.resolve(__dirname, 'node_modules/@gatsbyjs/reach-router/es/index'),
          type: `javascript/auto`,
          use: [
            {
              loader: path.resolve(__dirname, 'loaders/reach-router-add-basecontext-export-loader'),
            },
          ],
        },
      ],
    },
    plugins: [],
    resolve: {
      alias: {
        data: path.resolve(__dirname, 'data'),
        components: path.resolve(__dirname, 'src/components'),
        helpers: path.resolve(__dirname, 'src/helpers'),
        hooks: path.resolve(__dirname, 'src/hooks'),
        images: path.resolve(__dirname, 'src/images'),
        'page-data': path.resolve(__dirname, 'src/page-data'),
        styled: path.resolve(__dirname, 'src/styled'),
      },
    },
  });
};

export const createPages: GatsbyNode['createPages'] = async createPagesArgs => {
  await createHelpPages(createPagesArgs);
  await createHelpCategoryPages(createPagesArgs);
  // Temporarily disabled until robots.txt issue is resolved
  // await createRobotsTxt(createPagesArgs);
};
