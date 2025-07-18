module.exports = {
  transform: {
    '^.+\\.(js|jsx|ts|tsx)$': '<rootDir>/jest-preprocess.js',
  },
  moduleNameMapping: {
    '^gatsby-page-utils/(.*)$': 'gatsby-page-utils/dist/$1',
    '^gatsby-core-utils/(.*)$': 'gatsby-core-utils/dist/$1',
    '^gatsby-plugin-utils/(.*)$': 'gatsby-plugin-utils/dist/$1',
    '^types/(.*)$': '<rootDir>/types/$1',
    '^lib/(.*)$': '<rootDir>/lib/$1',
    '^data/(.*)$': '<rootDir>/data/$1',
    '^components/(.*)$': '<rootDir>/src/components/$1',
    '^helpers/(.*)$': '<rootDir>/src/helpers/$1',
    '^hooks/(.*)$': '<rootDir>/src/hooks/$1',
    '^images/(.*)$': '<rootDir>/src/images/$1',
    '^pages/(.*)$': '<rootDir>/src/pages/$1',
    '^styled/(.*)$': '<rootDir>/src/styled/$1',
    '^page-data/(.*)$': '<rootDir>/src/page-data/$1',
  },
  testPathIgnorePatterns: ['node_modules', '.cache', 'public'],
  transformIgnorePatterns: ['node_modules/(?!(gatsby|gatsby-script|gatsby-link)/)'],
  globals: {
    __PATH_PREFIX__: '',
  },
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
};
