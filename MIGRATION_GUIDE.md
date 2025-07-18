# Migration Guide: Middleman to Gatsby

This document outlines the migration from the old Middleman-based help site to the new Gatsby-based implementation.

## What Changed

### Technology Stack
- **From**: Middleman 3.4.1 (Ruby-based static site generator)
- **To**: Gatsby 5.14.0 (React-based static site generator)

### Key Improvements
1. **Performance**: Faster build times and better runtime performance
2. **Developer Experience**: Modern React/TypeScript development
3. **Maintainability**: Better code organization and type safety
4. **Search**: Improved search functionality with Fuse.js
5. **Responsive Design**: Better mobile experience

## File Structure Changes

### Old Structure (Middleman)
```
├── config/
├── helpers/
├── mappers/
├── source/
│   ├── css/
│   ├── js/
│   ├── layouts/
│   └── partials/
├── spec/
├── Gemfile
└── config.rb
```

### New Structure (Gatsby)
```
├── src/
│   ├── components/
│   ├── pages/
│   ├── templates/
│   ├── helpers/
│   ├── hooks/
│   └── styled/
├── lib/
├── types/
├── data/
├── gatsby-config.ts
├── gatsby-node.ts
└── package.json
```

## Contentful Integration

### Old Implementation
- Used `contentful_middleman` gem
- Custom mappers in Ruby
- Data stored in `data/` directory as JSON files

### New Implementation
- Uses `gatsby-source-contentful` plugin
- TypeScript interfaces for type safety
- GraphQL queries for data fetching

## Localization

### Old Implementation
- Ruby-based locale handling
- Custom helpers for URL generation
- Locale data in `data/locales.json`

### New Implementation
- Uses `@sharesight/gatsby-plugin-sharesight-localization`
- React-based locale handling
- TypeScript interfaces for locale data

## Search Functionality

### Old Implementation
- Lunr.js for search
- Server-side search index generation

### New Implementation
- Fuse.js for client-side search
- Real-time search with better performance

## Deployment

### Old Implementation
- Middleman S3 sync
- Ruby-based deployment scripts

### New Implementation
- Gatsby build process
- Same S3/CloudFront deployment
- GitHub Actions for CI/CD

## Environment Variables

### Old Variables
```bash
CONTENTFUL_MASTER_TOKEN
CONTENTFUL_PREVIEW_TOKEN
APP_ENV
```

### New Variables
```bash
CONTENTFUL_HELP_SPACE_ID
CONTENTFUL_HELP_ACCESS_TOKEN
CONTENTFUL_HELP_PREVIEW_ACCESS_TOKEN
CONTENTFUL_ENVIRONMENT
NODE_ENV
```

## Migration Steps

1. **Backup**: Create a backup branch of the old implementation
2. **Environment**: Set up new environment variables
3. **Dependencies**: Install Node.js dependencies
4. **Content**: Verify Contentful integration works
5. **Testing**: Run tests and verify functionality
6. **Deployment**: Update deployment pipeline
7. **Cleanup**: Remove old Ruby dependencies

## Breaking Changes

1. **URL Structure**: Some URLs may change due to Gatsby routing
2. **Build Process**: Different build commands and process
3. **Development**: Different development server and hot reloading
4. **Testing**: New testing framework (Jest instead of RSpec)

## Benefits

1. **Performance**: Faster page loads and better SEO
2. **Developer Experience**: Modern tooling and better debugging
3. **Maintainability**: TypeScript provides better type safety
4. **Scalability**: Better handling of large content sets
5. **Future-Proof**: Modern React ecosystem

## Support

For questions about the migration, please contact the development team or create an issue in this repository.
