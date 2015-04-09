# SEC_MS_Thesis
This repository has my Masters thesis manuscript.  
The thesis is about Phase aberration detection in Optical Vortices

The thesis is written in LaTex and compiled using the make command. 

## Usage of make

#### For compiling

The make file compiles the latex source `SEC_main.tex` using `pdflatex`. To compile, open a terminal and type: 
```
make pdflatex
```

and the following will happen:

1. `clean` Cleans the auxiliary files as well as not needed latex and bibtex files.
2. `pdflatex`  
3. `bibtex`
4. `pdflatex`
5. `pdflatex`
6. `pdflatex`

This returns a pdf file called `SEC_main.pdf` containing the thesis document.
If you want to view the pdf just type:

```
make view
```
This will open the file using Skim on Mac platforms. 

#### For cleaning

You can also use option `clean` without compiling by typing:

```
make clean
```

This is useful when you want to compile pdflatex only once from an editor like emacs. 

#### For commiting to github

The make file can also be used to update the github repository where this project is hosted. If you want to append and commit changes made on the folder do:

```
make git-commit
```

And the following commands will happen:

1. `clean`
2. `git add .`
3. `git commit`
4. `git push origin master` 

## Contents

#### Root

The backbone of the document is the file `SEC_main.tex`. You will find it in the root directory along the `LICENCE` and `Makefile`.

The `Makefile` is described above and the licence is a CC by-nc-nd/3.0 which allows you to:

Share — copy and redistribute the material in any medium or format
The licensor cannot revoke these freedoms as long as you follow the license terms.

And restricts you in the following ways:

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
NonCommercial — You may not use the material for commercial purposes.
NoDerivatives — If you remix, transform, or build upon the material, you may not distribute the modified material.
No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.

#### SETUP

Contains the class used for the main `.tex` file. This is a custom thesis latex class modified from one by Juan Antonio Navarro Perez http://navarroj.com/latex. 
#### Preface
Contains `.tex` files used in the preface of the thesis. These are:

* titlepage
* abstract
* acknowledgements
* dedication
* glossary

#### Chapters

Has the chapters

#### Figures
Contains all figures grouped by chapter

#### References
Has one bibtex file by chapter.
sd

