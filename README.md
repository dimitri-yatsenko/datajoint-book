[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)
[![Build and Deploy](https://github.com/dimitri-yatsenko/datajoint-book/actions/workflows/main.yml/badge.svg)](https://github.com/dimitri-yatsenko/datajoint-book/actions/workflows/main.yml)


# License

© DataJoint Inc., 2024-2025, All rights reserved.

This work is licensed under the [CC BY-NC-ND 4.0 License](LICENSE.md).
You may share the content as long as you 
* give appropriate credit
* do not use it for commercial purposes
* do not make modifications.


# DataJoint Book

Welcome to the [DataJoint Book](https://dimitri-yatsenko.github.io/datajoint-book), a comprehensive
introduction to relational database programming in the context of scientific computing and data science.

This book is built as an **executable book**, following the principles of the [Executable Books Project](https://executablebooks.org/en/latest/), an international collaboration to build open source tools that facilitate publishing computational narratives using the Jupyter ecosystem.

The book is authored using [MyST Markdown](https://mystmd.org/) (Markedly Structured Text), an extensible, semantic, and community-driven flavor of markdown designed for scientific and computational narratives. MyST enables us to:

- Write rich, publication-quality content with enhanced markdown syntax
- Embed executable code cells and computational outputs directly in the documentation
- Generate interactive web pages and other output formats from the same source
- Maintain a single source of truth for documentation, examples, and executable content

This approach ensures that all code examples in the book are tested, up-to-date, and can be run directly by readers, bridging the gap between documentation and hands-on learning.

## Running the Book with Dev Containers

This repository includes a **Dev Container** (Development Container) configuration that provides a pre-configured development environment with all necessary dependencies, tools, and extensions already set up. This eliminates the need to manually install Python, DataJoint, MyST, and other required packages on your local machine.

### What is a Dev Container?

A Dev Container is a Docker-based development environment that runs inside a container but integrates seamlessly with your code editor (like Visual Studio Code or GitHub Codespaces). It ensures that everyone working on the book has an identical, reproducible environment, regardless of their operating system or local setup.

### How to Use the Dev Container

**Option 1: Using Visual Studio Code (Local)**

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop) on your machine
2. Install [Visual Studio Code](https://code.visualstudio.com/)
3. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) in VS Code
4. Clone this repository and open it in VS Code
5. When prompted, click "Reopen in Container" (or use Command Palette: `Dev Containers: Reopen in Container`)
6. VS Code will build the container and reload the workspace inside it

**Option 2: Using GitHub Codespaces (Cloud)**

1. Navigate to this repository on GitHub
2. Click the green "Code" button
3. Select the "Codespaces" tab
4. Click "Create codespace on main"
5. GitHub will launch a cloud-based VS Code environment with the Dev Container already running

Once inside the Dev Container, you have access to all tools needed to build, edit, and execute the book's content, including Jupyter notebooks, Python with DataJoint, and MyST build tools.


# Building and Deployment

Once you're working inside the Dev Container (see above), you can build and preview the book locally.

### Building the Book

The MyST static site deployment instructions are provided here: https://mystmd.org/guide/deployment

To build and serve the book locally:

```shell
$ cd book
$ myst build --html
$ npx serve _build/html
```

This will:
1. Build the static HTML site from the MyST markdown and Jupyter notebook sources
2. Start a local web server (typically at `http://localhost:3000`)
3. Allow you to preview the book in your browser exactly as it will appear when deployed

### Automatic Deployment

The book is **automatically published** to [https://dimitri-yatsenko.github.io/datajoint-book](https://dimitri-yatsenko.github.io/datajoint-book) using GitHub Actions. 

Every time changes are pushed to the `main` branch, a GitHub Actions workflow:
1. Builds the book using MyST
2. Deploys the generated HTML to GitHub Pages
3. Makes the updated book immediately available online

You can monitor the build and deployment status via the badge at the top of this README or by viewing the [Actions tab](https://github.com/dimitri-yatsenko/datajoint-book/actions) in the repository. This automated CI/CD pipeline ensures that the published version always reflects the latest content in the repository.

# Contributions 
We welcome and appreciate your contributions to this book, whether as a reviewer or as a contributor.
All contributions will be gratefully acknowledged.
You may suggest modifications by submitting an issue in the main [GitHub repository](https://github.com/dimitri-yatsenko/datajoint-book) for this book.
For more substrantial contributions and collaborations, including co-authorship and publications, please contact Dimitri Yatsenko.