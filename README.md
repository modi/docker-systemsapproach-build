# Usage

Clone this repo, then run:

    git submodule init
    git submodule update
    docker run --rm -v $(pwd):/work -w /work -u $(id -u):$(id -g) modicn/systemsapproach:builder sphinx-build -M latexpdf ./book ./build

# Refs

-   [Installing TeX Live over the Internet - TeX Users Group](https://www.tug.org/texlive/acquire-netinstall.html)
-   [install-tl - TeX Live cross-platform installer](https://www.tug.org/texlive/doc/install-tl.html#PROFILES)
-   [LaTeX customization — Sphinx documentation](https://www.sphinx-doc.org/en/master/latex.html)
