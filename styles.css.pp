#lang pollen

table {
    /* Remove spacing between table cells (from Normalize.css) */
    border-collapse: collapse;
    border-spacing: 0;
    empty-cells: show;
    border: 1px solid #cbcbcb;
    table-layout: fixed;
}

 caption {
    padding: 1em 0;
    text-align: center;
    caption-side: bottom;
}

 td,
 th {
    border-left: 1px solid #cbcbcb;/*  inner column border */
    border-width: 0 0 0 1px;
    font-size: inherit;
    margin: 0;
    overflow: visible; /*to make ths where the title is really long work*/
    padding: 0.5em 1em; /* cell padding */
}

 thead {
    background-color: #e0e0e0;
    color: #000;
    text-align: left;
    vertical-align: bottom;
}

/*
striping:
   even - #fff (white)
   odd  - #f2f2f2 (light gray)
*/
td {
    background-color: transparent;
}
/* nth-child selector for modern browsers */
tr:nth-child(odd) td {
    background-color: #f2f2f2;
}
/* BORDERED TABLES */
td {
    border-bottom: 1px solid #cbcbcb;
}
tbody > tr:last-child > td {
    border-bottom-width: 0;
}

/* HORIZONTAL BORDERED TABLES */

.pure-table-horizontal td,
.pure-table-horizontal th {
    border-width: 0 0 1px 0;
    border-bottom: 1px solid #cbcbcb;
}
.pure-table-horizontal tbody > tr:last-child > td {
    border-bottom-width: 0;
}
/**
 * Use the default user interface font in all browsers (opinionated).
 */

html {
  font-family:
     /* macOS 10.11-10.12 */ -apple-system,
    /* Windows 6+ */ "Segoe UI",
    /* Android 4+ */ "Roboto",
    /* Ubuntu 10.10+ */ "Ubuntu",
    /* KDE Plasma 5+ */ "Noto Sans",
    /* Gnome 3+ */ "Cantarell",
    /* fallback */ sans-serif,
    /* macOS emoji */ "Apple Color Emoji",
    /* Windows emoji */ "Segoe UI Emoji",
    /* Windows emoji */ "Segoe UI Symbol",
    /* Linux emoji */ "Noto Color Emoji",
    system-ui;
}

/**
 * Use the default monospace user interface font in all browsers (opinionated).
 */

code,
kbd,
samp,
pre {
  font-family:
    /* macOS 10.10+ */ "Menlo",
    /* Windows 6+ */ "Consolas",
    /* Android 4+ */ "Roboto Mono",
    /* Ubuntu 10.10+ */ "Ubuntu Monospace",
    /* KDE Plasma 5+ */ "Noto Mono",
    /* KDE Plasma 4+ */ "Oxygen Mono",
    /* Linux/OpenOffice fallback */ "Liberation Mono",
    /* fallback */ monospace,
    /* macOS emoji */ "Apple Color Emoji",
    /* Windows emoji */ "Segoe UI Emoji",
    /* Windows emoji */ "Segoe UI Symbol",
    /* Linux emoji */ "Noto Color Emoji";
}


a{
    /* remove underline */
    text-decoration: none;
}

.question {
    color: #07a;
}

.steps {
    list-style-position: none;
}

.step {
    color: purple;
}

.more-examples{
    color: green;
}

.anchor {
    float: left;
    padding-right: 4px;
    margin-left: -20px;
    line-height: 1;
    text-decoration: none;
    color: #c2c2c2;
    opacity: .9;
    font-size: 65%;
}

details {
    border: 1px solid #aaa;
    border-radius: 4px;
    padding: .5em .5em 0;
}

summary {
    font-weight: bold; 
    margin: -.5em -.5em 0;
    padding: .5em;
}

details[open] {
    padding: .5em;
}

details[open] summary {
    border-bottom: 1px solid #aaa;
    margin-bottom: .5em;
}
/* LAYOUT */
/* 
    prev search next
    .   content .
    . content .
*/
#prev {
    grid-area: prev;
    direction: rtl;
}

#next {
    grid-area: next;
    direction: rtl;
}

#home {
    grid-area: home;
    direction: rtl;
}

.container {
        grid-template-areas: 
        ". content .";
        display: grid;
        grid-template-columns: minmax(1em, 1fr) minmax(auto, 90ch) minmax(1em, 1fr);
        height: 100vh;
}

article {
    grid-area: article;
}

.main-wrapper {
    grid-area: content;
}

.wrap {
    flex-wrap: wrap;
}

.layout-spread-row {
    display: flex;
    justify-content: space-evenly;
}

pre {
  width: 100%;
  overflow: scroll;
  white-space:pre-wrap;
  word-wrap:break-word;
  overflow:auto;
}
