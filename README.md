# Store

An online storefront built with Ruby on Rails, offering user authentication, product management, shopping cart functionality, and order processing.

### Technology Stack

- Ruby  
- JavaScript  
- SQLite  
- Docker  
- GitHub Actions

## Table of Contents

1. [Features](#features)  
2. [Prerequisites](#prerequisites)  
3. [Getting Started](#getting-started)  
   1. [Clone the Repository](#clone-the-repository)  
   2. [Install Dependencies](#install-dependencies)  
   3. [Configure Environment](#configure-environment)  
   4. [Database Setup](#database-setup)  
   5. [Run the Application](#run-the-application)  
4. [Docker](#docker)  
5. [Running the Test Suite](#running-the-test-suite)  
6. [Code Quality](#code-quality)  
7. [Project Structure](#project-structure)  
8. [Contributing](#contributing)  
9. [License](#license)  
10. [Contact](#contact)  

## Features

- **Authentication and Authorization**  
  - Secure user registration with email confirmation  
  - Encrypted password storage using bcrypt  
  - Role-based access control (customer vs. admin)  

- **Product Catalog**  
  - Full CRUD for products with image upload via Active Storage  
  - Categories, tags and nested subcategories for flexible organization  
  - Product variants, SKU management and real-time inventory tracking  

- **Shopping Cart**  
  - Persistent cart stored in session or database  
  - Quantity updates, real-time price calculations (discounts, taxes)  
  - Stock-availability checks and quantity limits enforcement  

- **Checkout & Order Management**  
  - Multi-step checkout: billing/shipping address, shipping options, payment  
  - Integration with Stripe (or dummy gateway for local testing)  
  - Order confirmation emails, status updates and order-history page  
  - One-click re-order for past purchases  

- **Admin Dashboard**  
  - Manage products, orders and user accounts from a single interface  
  - Bulk import/export of products and orders via CSV  
  - User management: role assignment, account suspension and activity logs  
  - Sales analytics: revenue charts, top-selling items, customer sign-ups  

- **Search & Filtering**  
  - Full-text search powered by PostgreSQL or Elasticsearch  
  - Dynamic filters: price range, category, rating and availability  
  - Autocomplete suggestions and “did you mean?” corrections  

- **API Access**  
  - RESTful JSON endpoints for products, carts and orders  
  - Token-based authentication (JWT) for third-party integrations  
  - Pagination, rate limiting and filtering support  

- **Testing & Code Quality**  
  - RSpec, FactoryBot and Capybara for unit, integration and system tests  
  - Continuous integration with GitHub Actions running tests and linters  
  - RuboCop enforcement and standard Ruby on Rails best practices  

## Prerequisites

- Ruby (version specified in `.ruby-version`)  
- Rails (version in `Gemfile.lock`)  
- Bundler  
- Node.js & Yarn (for Webpacker assets)  
- A database (SQLite3 by default; configurable for PostgreSQL or MySQL)  
- Docker & Docker Compose (optional, for containerized setup)  

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/DilanKaya127/store.git
cd store
```

### Install Dependencies

```bash
bundle install
yarn install
```

### Configure Environment

1. Copy the example environment file and update values:

   ```bash
   cp .env.example .env
   ```

2. Edit `.env` to set your database credentials, secret keys, etc.

### Database Setup

```bash
rails db:create
rails db:migrate
rails db:seed   # optional, if seeds are provided
```

### Run the Application

```bash
rails server
```

Visit http://localhost:3000 in your browser.

## Docker

Build and run the app in a container:

```bash
docker build -t store-app .
docker run -it --rm -p 3000:3000 --env-file .env store-app
```

If you’re using Docker Compose:

```bash
docker-compose up --build
```

## Running the Test Suite

```bash
rails test
```

Ensure all tests pass before opening a pull request.

## Code Quality

- Linting with RuboCop:

  ```bash
  rubocop
  ```

- Continuous integration configured in `.github/workflows` to run tests and linters on each push.

## Project Structure

- **/.github/** – CI workflows  
- **/app/** – MVC folders (models, views, controllers)  
- **/config/** – Routes, database, and environment settings  
- **/db/** – Migrations and seeds  
- **/lib/** – Custom libraries and tasks  
- **/public/** – Static assets  
- **/test/** – Unit and integration tests  
- **Gemfile** – Ruby gem dependencies  
- **Dockerfile** – Container build instructions  
- **.ruby-version** – Ruby version pinning  
- **.rubocop.yml** – Linting configuration  

## Contributing

1. Fork the repository  
2. Create a feature branch (`git checkout -b feature/your-feature`)  
3. Commit your changes (`git commit -m 'Add some feature'`)  
4. Push to your fork (`git push origin feature/your-feature`)  
5. Open a pull request  

Please follow the existing code style, write tests for new behavior, and ensure the test suite passes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

Dilan Kaya  
– GitHub: [DilanKaya127](https://github.com/DilanKaya127)  
– Email: dilankaya127@gmail.com  

Feel free to open issues or pull requests for bugs, enhancements, or questions!
