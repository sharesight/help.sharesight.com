# Sharesight Help Site

Sharesight user help pages built with **Gatsby** and **Contentful**. **This is a public repository.**

## Features

- ⚡ **Fast**: Built with Gatsby for optimal performance
- 🔍 **Searchable**: Full-text search using Fuse.js
- 🌍 **Multi-locale**: Support for multiple regions (Global, AU, CA, NZ, UK)
- 📱 **Responsive**: Mobile-first design
- 🎨 **Modern UI**: Clean, accessible interface
- 📝 **Contentful CMS**: Easy content management

## Tech Stack

- **Framework**: Gatsby 5.14.0
- **CMS**: Contentful
- **Styling**: Styled Components
- **Search**: Fuse.js
- **Language**: TypeScript
- **Deployment**: AWS S3 + CloudFront

## Getting Started

### Prerequisites

- Node.js 18+
- Yarn or npm
- Contentful account with access to the help space
- direnv (optional, for automatic environment loading)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/sharesight/help.sharesight.com.git
   cd help.sharesight.com
   ```

2. **Install dependencies**
   ```bash
   yarn install
   ```

   **Optional: Install direnv for automatic environment loading**
   ```bash
   # macOS
   brew install direnv

   # Ubuntu/Debian
   sudo apt-get install direnv

   # Add to your shell profile (.bashrc, .zshrc, etc.)
   echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
   # or for zsh
   echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
   ```

3. **Set up environment variables**

   **Option A: Using direnv (recommended)**
   ```bash
   cp .envrc.example .envrc
   ```

   Edit `.envrc` with your Contentful credentials:
   ```bash
   export CONTENTFUL_HELP_SPACE_ID=kw7pc879iryd
   export CONTENTFUL_HELP_ACCESS_TOKEN=your_delivery_token_here
   export CONTENTFUL_HELP_PREVIEW_ACCESS_TOKEN=your_preview_token_here
   export CONTENTFUL_ENVIRONMENT=master
   export NODE_ENV=development
   ```

   **Option B: Using .env files**
   ```bash
   cp .envrc.example .env.development
   ```

   Edit `.env.development` with your Contentful credentials:
   ```env
   CONTENTFUL_HELP_SPACE_ID=kw7pc879iryd
   CONTENTFUL_HELP_ACCESS_TOKEN=your_delivery_token_here
   CONTENTFUL_HELP_PREVIEW_ACCESS_TOKEN=your_preview_token_here
   CONTENTFUL_ENVIRONMENT=master
   NODE_ENV=development
   ```

4. **Start development server**
   ```bash
   yarn develop
   ```

   The site will be available at `http://localhost:8000`

## Available Scripts

- `yarn develop` - Start development server
- `yarn build` - Build for production
- `yarn serve` - Serve production build locally
- `yarn clean` - Clear Gatsby cache
- `yarn lint` - Run ESLint
- `yarn typeCheck` - Run TypeScript type checking
- `yarn test` - Run tests

## Project Structure

```
├── src/
│   ├── components/     # React components
│   ├── pages/         # Gatsby pages
│   ├── templates/     # Page templates
│   ├── helpers/       # Utility functions
│   ├── hooks/         # Custom React hooks
│   ├── styled/        # Styled components
│   └── images/        # Static images
├── lib/               # Build utilities
├── types/             # TypeScript type definitions
├── data/              # Static data (locales, etc.)
└── gatsby-*.ts        # Gatsby configuration files
```

## Contentful Integration

The site pulls content from Contentful using the following content types:

- **Help Page** (`post`): Individual help articles
- **Help Category** (`category`): Categories for organizing content

### Content Structure

Each help page includes:
- Title
- URL slug (optional, auto-generated from title)
- Meta description
- Content (Markdown)
- Keywords
- Category association
- Parent page (for hierarchical content)
- Featured image

## Localization

The site supports multiple locales:
- **Global** (`/`) - Default English content
- **Australia** (`/au/`) - Australian-specific content
- **Canada** (`/ca/`) - Canadian-specific content
- **New Zealand** (`/nz/`) - New Zealand-specific content
- **United Kingdom** (`/uk/`) - UK-specific content

## Deployment

### Staging
- Branch: `develop`
- URL: `https://staging-help.sharesight.com`

### Production
- Branch: `master`
- URL: `https://help.sharesight.com`

Deployment is handled automatically via GitHub Actions when changes are pushed to the respective branches.

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `CONTENTFUL_HELP_SPACE_ID` | Contentful space ID | Yes |
| `CONTENTFUL_HELP_ACCESS_TOKEN` | Contentful delivery token | Yes |
| `CONTENTFUL_HELP_PREVIEW_ACCESS_TOKEN` | Contentful preview token | No |
| `CONTENTFUL_ENVIRONMENT` | Contentful environment | No (defaults to 'master') |

## Contributing

1. Create a feature branch from `develop`
2. Make your changes
3. Run tests: `yarn test`
4. Run linting: `yarn lint`
5. Submit a pull request

## Support

For questions or issues, please contact the development team or create an issue in this repository.
