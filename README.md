# Southsea Cinema - Flutter Coursework

This repository contains the coursework starter project for students enrolled in the **Programming Applications and Programming Languages (M30235)** and **User Experience Design and Implementation (M32605)** modules at the University of Portsmouth.

## Overview

Your task is to recreate a mobile-friendly version of the Southsea Cinema website using Flutter. You must begin by forking this starter repository, then build your own version of the app step by step as you work through the weekly worksheets.

Reference website: [Southsea Cinema](https://southseacinema.savoysystems.co.uk/SouthseaCinema.dll/)

The starter app is deliberately minimal. It contains only a basic theme, an empty home page, a small drawer, and a default widget test. You are expected to add screens, widgets, data models, tests, persistence, and cloud services during the coursework.

## Getting Started

### Prerequisites

You need:

- A GitHub account
- A way to edit and run Flutter projects
- Git installed and connected to your GitHub account

Follow the [development environment instructions in Worksheet 1](https://manighahrmani.github.io/sandwich_shop/worksheet-1.html#set-up-your-development-environment). You can use your own device or access the university machines remotely.

### Fork the Repository

Open this repository on GitHub and click **Fork**, as shown below:

[https://github.com/manighahrmani/southsea_cinema/fork](https://github.com/manighahrmani/southsea_cinema/fork)

![Clicking the Fork button on GitHub](images/step1_fork_button.png)

On the "Create a new fork" page, leave the default options as they are (do not change the repository name) and click **Create fork**:

![Creating a new fork on GitHub](images/step1_create_fork.png)

Your fork should be called `southsea_cinema` and should have a URL like this:

```text
https://github.com/YOUR-USERNAME/southsea_cinema
```

### Clone Your Forked Repository

On your forked repository page, click the green **Code** button and copy the HTTPS URL, as shown below:

![Copying the clone URL from GitHub](images/step2_clone_repository.png)

If you are using VS Code, open the Source Control panel and click **Clone Repository** (or open the Command Palette with `Ctrl+Shift+P` / `Cmd+Shift+P` and choose "Git: Clone"), then paste the URL you copied:

![Cloning your fork in VS Code](images/step2_open_in_vscode.png)

Alternatively, if you are using a terminal, run:

```bash
git clone https://github.com/YOUR-USERNAME/southsea_cinema.git
cd southsea_cinema
```

Replace `YOUR-USERNAME` with your GitHub username.

### Install Dependencies

When you open the project, VS Code may show a popup asking if you want to fetch missing packages. If you see it, click **Run 'pub get'**, as shown below:

![VS Code prompting to run pub get](images/step3_flutter_pub_get_better.png)

If you do not see this popup, open a terminal and run the command manually:

```bash
flutter pub get
```

This downloads the Flutter packages needed by the starter app.

![Running flutter pub get in the terminal](images/step3_flutter_pub_get.png)

### Run the Application

This coursework targets Flutter Web. Use Chrome or Edge.

```bash
flutter run -d chrome
```

or:

```bash
flutter run -d edge
```

The app should open in your browser and show the Southsea Cinema starter home page, as shown below:

![Starter app running in Chrome](images/step4_run_app.png)

### Use Mobile View

The coursework should be designed mobile-first.

To view it in mobile view in Chrome or Edge, open developer tools (right-click the page and choose **Inspect**, or press F12), then click the **Toggle device toolbar** button:

![Toggle device toolbar button in Chrome DevTools](images/step5_open_devtools.png)

Finally, choose a phone-sized device preset from the dropdown menu:

![Selecting a phone-sized device preset](images/step5_mobile_view.png)

## Marking Criteria

This repository is the starting point for your Southsea Cinema coursework, which is Item 1 of your module and worth 50% of the overall module mark. Item 1 is assessed as a portfolio of five live in-person demos during your timetabled practical session. You build the app progressively by completing the exercises at the end of the weekly worksheets.

Every two worksheets prepare you for one demo (for example, Worksheets 1 and 2 prepare you for Demo 1). Only your best four demo marks count towards Item 1, with each counted demo worth 25% of Item 1 (12.5% of the overall module mark). Each demo is marked on functionality (9%), code quality (8%), and your understanding through two questions about your own code (8%).

Assessment takes place across five two-week demo windows (Weeks 1 and 2, Weeks 3 and 4, Weeks 5 and 6, Weeks 7 and 8, and Weeks 9 and 10). Three rules apply:

- You can perform at most one demo in any demo window.
- Demos must be completed in order. You cannot skip ahead to a later demo if you have missed an earlier one, because each stage builds on the previous codebase.
- Missing one demo window carries no mark penalty because only your best four demo marks count. Missing two or more windows reduces the number of demos you can complete.

For the full mark breakdown, the missed-demo rules, and how Extenuating Circumstances affect Item 1, read the [Assessment Guide](https://portdotacdotuk-my.sharepoint.com/:w:/g/personal/mani_ghahremani_port_ac_uk/IQC9nZoNwb2jT40MnFQPZWVvAVdTK2PGBmZ8jPff30RRyPc). The full demo dates and requirements are listed on the [Flutter Course homepage](https://manighahrmani.github.io/sandwich_shop/).

## Submission

You will submit the link to your public forked repository on Moodle before the first demo. You are not submitting a zip file or a copy of the source code.

Make sure your repository is public. Test this by opening your repository link in a private/incognito browser window.

## Demonstration

During each demo, you must be able to run your app and answer questions about your code.

Before attending a demo, check that the app runs from a clean clone:

```bash
flutter pub get
flutter run -d chrome
```

## Project Structure

The starter repository is intentionally small:

```text
southsea_cinema/
├── lib/
│   ├── constants.dart          # Shared colours, text styles, and app title
│   ├── main.dart               # Main app and route setup
│   ├── views/
│   │   ├── home_view.dart      # Starter home page
│   │   └── movie_listing.dart  # Empty movie listing page
│   └── widgets/
│       └── nav_drawer.dart     # Minimal starter drawer
├── test/
│   └── widget_test.dart        # Basic widget test
├── pubspec.yaml                # Project dependencies
└── README.md                   # This file
```

You will add more files and folders as the coursework develops.

## Help with Coursework

If you have questions or encounter issues while working on this coursework, use the [Discord guide](https://portdotacdotuk-my.sharepoint.com/:p:/g/personal/mani_ghahremani_port_ac_uk/IQCMJP6IiR_bQoYUMdXJSRDYAWnajEALZYEXFZyrJkHS1QU) to find the dedicated Discord channel and ask for help. Before posting a new question, check the existing posts to see if your question has already been answered. You can also attend your timetabled practical sessions to get face-to-face support from teaching staff.
