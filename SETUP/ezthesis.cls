%% ezthesis class for LaTeX2e.
%%
%% A custom thesis class
%% by Juan Antonio Navarro Perez
%% http://navarroj.com/latex
%% ezlatex@navarroj.com
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ezthesis}[2007/08/08 A custom thesis class]

%% switches
\newif\if@spanish\@spanishfalse
\newif\if@draft\@draftfalse
\newif\if@bibfix\@bibfixtrue
\newif\if@fancyhdr\@fancyhdrtrue
\newif\if@colors\@colorstrue
\newif\if@graphicx\@graphicxtrue
\newif\if@natbib\@natbibtrue
\newif\if@bibnumbers\@bibnumbersfalse

\def\PassLayoutOptions#1{%
	\PassOptionsToClass{#1}{report}
	\PassOptionsToPackage{#1}{geometry}}

%% class options
\DeclareOption{draft}{%
	\@drafttrue\PassOptionsToClass{draft}{report}
	\PassOptionsToClass{draft}{graphicx}}
\DeclareOption{draftmarks}{\@drafttrue\PassOptionsToClass{draft}{report}}
\DeclareOption{spanish}{\@spanishtrue}
\DeclareOption{final}{\@draftfalse}
\DeclareOption{letterpaper}{\PassLayoutOptions{letterpaper}}
\DeclareOption{a4paper}{\PassLayoutOptions{a4paper}}
\DeclareOption{twoside}{\PassLayoutOptions{twoside}}
\DeclareOption{oneside}{%
	\PassOptionsToClass{oneside}{report}%
	\PassOptionsToPackage{twoside=false}{geometry}}
\DeclareOption{singlespace}{\gdef\select@spacing{\singlespacing}}
\DeclareOption{onehalfspace}{\gdef\select@spacing{\onehalfspacing}}
\DeclareOption{doublespace}{\gdef\select@spacing{\doublespacing}}
\DeclareOption{10pt}{\gdef\select@fontsz{\PassOptionsToClass{10pt}{report}}}
\DeclareOption{11pt}{\gdef\select@fontsz{\PassOptionsToClass{11pt}{report}}}
\DeclareOption{12pt}{\gdef\select@fontsz{\PassOptionsToClass{12pt}{report}}}
\DeclareOption{numbers}{\@bibnumberstrue}
\DeclareOption{authoryear}{\@bibnumbersfalse}
\DeclareOption{nobibtoc}{\@bibfixfalse}
\DeclareOption{nofancyhdr}{\@fancyhdrfalse}
\DeclareOption{nocolors}{\@colorsfalse}
\DeclareOption{nographicx}{\@graphicxfalse}
\DeclareOption{nonatbib}{\@natbibfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ExecuteOptions{final,twoside,letterpaper,onehalfspace,12pt,authoryear}
\ProcessOptions\relax
\select@fontsz
\LoadClass{report}

%% spanish
\if@spanish
  \RequirePackage[activeacute,spanish]{babel}
\fi

%% fields
\def\author#1{\gdef\insertauthor{#1}\gdef\@author{#1}}
\def\authoremail#1{\gdef\insertauthoremail{#1}\gdef\@authoremail{#1}}
\def\title#1{\gdef\inserttitle{#1}\gdef\@title{#1}}
\def\supervisor#1{\gdef\insertsupervisor{#1}}
\def\supervisoremail#1{\gdef\insertsupervisoremail{#1}}
\def\institution#1{\gdef\insertinstitution{#1}}
\def\degree#1{\gdef\insertdegree{#1}}
\def\program#1{\gdef\insertprogram{#1}}
\def\faculty#1{\gdef\insertfaculty{#1}}
\def\department#1{\gdef\insertdepartment{#1}}
\def\submitdate#1{\gdef\insertsubmitdate{#1}}
\def\city#1{\gdef\insertcity{#1}}
\def\country#1{\gdef\insertcountry{#1}}

% some defaults and labels
\if@spanish
  \author{Falta nombre de autor}
  \authoremail{Falta email de autor}
  \title{Falta t\'itulo de la tesis}
  \degree{Doctor en...}
  \program{Doctorado en...}
  \supervisor{Falta nombre del supervisor}
  \supervisoremail{Falta nombre del supervisor}
  \institution{Universidad de Alg\'un Sitio}
  \faculty{Facultad de Ingenier\'ia y Ciencias}
  \department{Escuela de C\'omputo}
  \city{Falta nombre de ciudad}
  \country{Falta nombre de país}
  \def\draftlabel{BORRADOR}
\else
  \author{Author name missing}
  \authoremail{Author email missing}
  \title{Thesis title missing}
  \degree{Doctor of Philosophy}
  \program{Doctor of Philosophy}
  \supervisor{Supervisor name missing}
  \supervisoremail{Supervisor name missing}
  \institution{The University of Somewhere}
  \faculty{Faculty of Engineering and Physical Sciences}
  \department{School of Computer Science}
    \city{City name missing}
  \country{Country name missing}
  \def\draftlabel{DRAFT}
\fi
\submitdate{\number\the\year}


%% time and date
\newcount\hours \newcount\minutes
\def\SetTime{\hours=\time
        \global\divide\hours by 60
        \minutes=\hours
        \multiply\minutes by 60
        \advance\minutes by-\time
        \global\multiply\minutes by-1 }
\SetTime

\def\shortdate{\@arabic\day/\@arabic\month/\@arabic\year}
\def\shorttime{\number\hours:\ifnum\minutes<10 0\fi\number\minutes\ hrs}

\if@draft
	\def\draftmark{\draftlabel: \shortdate\ -- \shorttime}
\else
	\def\draftmark{}
\fi

%% spacing
\RequirePackage{setspace}
\select@spacing

%% margins
\RequirePackage[
  top     = 40mm, bottom     = 33mm,
  outer   = 25mm, inner      = 40mm,
  headsep = 10mm, headheight = 15pt,
  marginparwidth = 15mm ]{geometry}

%% page styles
\if@fancyhdr
  \RequirePackage{fancyhdr}

  \if@twoside
    \fancyhf{}
    \fancyhead[RE]{\itshape\nouppercase\leftmark}
    \fancyhead[LO]{\itshape\nouppercase\rightmark}
    \fancyhead[LE,RO]{\itshape\thepage}
    \fancyfoot[C]{\draftmark}

    \fancypagestyle{plain}{%
    \fancyhf{}
    \fancyfoot[LE,RO]{\itshape\thepage}
    \fancyfoot[RE,LO]{\draftmark}}
  \else
    \fancyhf{}
    \fancyhead[L]{\itshape\nouppercase\leftmark}
    \fancyhead[R]{\itshape\thepage}
    \fancyfoot[C]{\draftmark}

    \fancypagestyle{plain}{%
    \fancyhf{}
    \fancyfoot[R]{\itshape\thepage}
    \fancyfoot[L]{\draftmark}}
  \fi

  \fancypagestyle{empty}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[C]{\draftmark}}

  % setting page style should be done *after* geometry
  \AtBeginDocument{\pagestyle{fancy}}
\else
  \AtBeginDocument{\pagestyle{headings}}
\fi

\pagenumbering{arabic}

%% sectioning commands
\def\prefacesection#1{\clearpage\phantomsection
	\addcontentsline{toc}{chapter}{#1}\chapter*{#1}\markboth{#1}{}}

% %% Bibliography - natbib
% \if@natbib
%   \if@bibnumbers
%     \RequirePackage[sort&compress,square,numbers,sectionbib]{natbib}
%   \else
%     \RequirePackage[sort&compress,round,authoryear]{natbib}
%   \fi
%   \if@spanish
%     \bibliographystyle{SETUP/ezspanish}
%   \else
%     \bibliographystyle{plainnat}
%   \fi
%   \let\cite\citep
% \fi

% %% bibliography fix - makes bibliography appear
% %% in table of contents, and makes it work nice
% %% with hyperref
% \def\bibliographyfix{%
% 	\let\old@bibliography\bibliography

% 	\def\bibliography{%
% 		\clearpage
% 		\phantomsection
% 		\addcontentsline{toc}{chapter}{\bibname}%
% 		\old@bibliography}}

% \if@bibfix
% 	\AtBeginDocument{\bibliographyfix}
% \fi

%---------------------------------------------------------------
% Packages
%---------------------------------------------------------------
                                %referencias
%\PassOptionsToPackage{square,numbers}{natbib}
% \RequirePackage{natbib} 
\usepackage[square, sort&compress, numbers, sectionbib]{natbib} %OJO
                                %CAMBIO 
%\usepackage[spanish]{babelbib} %OJO
%\usepackage[backend=bibtex,url=false]{biblatex}  %Manejo de
\usepackage[resetlabels]{multibib}
\newcites{Int}{Bibliograf\'{i}a}
\newcites{ChGen}{Bibliograf\'{i}a}
\newcites{ChPD}{Bibliograf\'{i}a}
% \newcites{Slm}{Bibliograf\'{i}a}
% \newcites{Vor}{Bibliograf\'{i}a}
% \newcites{Aer}{Bibliograf\'{i}a}
% \newcites{SH}{Bibliograf\'{i}a}
% \newcites{OF}{Bibliograf\'{i}a}
% \newcites{Shp}{Bibliograf\'{i}a}
% \newcites{Apc}{Bibliograf\'{i}a}
% \newcites{Apu}{Bibliograf\'{i}a}
% \newcites{Apt}{Bibliograf\'{i}a}

% For use of listings code
\usepackage{listings}
% misc
\usepackage{cprotect}
% date and time
\usepackage{datetime}

%Para incluir detalles cucas del pdf
\usepackage[pdftex, pdftitle={GENERACIÓN Y CARACTERIZACIÓN DE VÓRTICES
                  ÓPTICOS MEDIANTE MODULADORES ESPACIALES DE LUZ}, pdfauthor={Santiago Echeverri},
pdfsubject={Optical Vortices, SLM Characterization, Phase retrieval}, pdfkeywords={Optical Vortices, SLM Characterization, Phase retrieval}, pdfpagemode=UseOutlines,bookmarks,bookmarksopen,pdfstartview=FitH,colorlinks,linkcolor=blue,
urlcolor=black, cite color=red]{hyperref} %

\usepackage[hyperpageref]{backref} 
%\usepackage[inline]{trackchanges}
\usepackage[finalnew]{trackchanges}
\addeditor{SEC}
\usepackage[compact]{titlesec}
% idioma
\usepackage[utf8]{inputenc}
%\usepackage[USenglish,british,american,australian,english]{babel}

\usepackage{booktabs} %tablas
\usepackage{tabularx}
\usepackage{rotating}  %rotar tablas

\usepackage{colortbl} %color tablas
\usepackage{setspace} %espaciado
\usepackage{url}
\usepackage{subcaption}
%\usepackage{hyperref}
% Paquetes de la AMS:
\usepackage{amsmath, amsthm, amsfonts, amssymb}
\usepackage{dsfont}
\onehalfspacing
\pagestyle{plain} % numeracion en la parte inferior

% Default fixed font does not support bold face
\DeclareFixedFont{\ttb}{T1}{txtt}{bx}{n}{8} % for bold
\DeclareFixedFont{\ttm}{T1}{txtt}{m}{n}{8}  % for normal

%\setlength{\parindent}{0pt}
%\setlength{\parskip}{2.0ex plus0.5ex minus0.2ex}


%---------------------------------------------------------------
%  End Packages
%---------------------------------------------------------------
%\usepackage[resetlabels]{multibib}

%% title page building blocks
\renewenvironment{titlepage}%
	{\let\ez@blockfill\relax
	 \thispagestyle{empty}\centering\null\vskip1in}
	{\vskip.5in\newpage}

\newcommand{\TitleBlock}[2][\ez@blockfill]{#1{#2\par}\let\ez@blockfill\vfill}



%% Graphics and colors
\if@graphicx
	\RequirePackage{graphicx}
\fi

\if@colors
	\RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}
	\definecolor{dark-red}{rgb}{0.4,0.15,0.15}
	\definecolor{dark-blue}{rgb}{0.15,0.15,0.4}
	\definecolor{medium-blue}{rgb}{0,0,0.5}
        \definecolor{deepblue}{rgb}{0,0,0.5}
        \definecolor{deepred}{rgb}{0.6,0,0}
        \definecolor{deepgreen}{rgb}{0,0.5,0}
        \definecolor{mygreen}{rgb}{0,0.6,0}
        \definecolor{mygray}{rgb}{0.47,0.47,0.33}
        \definecolor{myorange}{rgb}{0.8,0.4,0}
        \definecolor{mywhite}{rgb}{0.98,0.98,0.98}
        \definecolor{myblue}{rgb}{0.01,0.61,0.98}
        \definecolor{mylilas}{RGB}{170,55,241}
        \definecolor{MyDarkGreen}{rgb}{0.0,0.4,0.0}
\fi

% Linking and pdf options
\let\phantomsection\@empty
\def\hyperlinking{%
	\providecommand\theHalgorithm{\thealgorithm}
	\providecommand\theHdefinition{\thedefinition}
	\providecommand\theHexample{\theexample}
	\providecommand\theHlemma{\thelemma}
	\providecommand\theHproposition{\theproposition}
	\providecommand\theHcorollary{\thecorollary}

	\RequirePackage[final,breaklinks,bookmarks]{hyperref}

	% properties of pdf file
	\hypersetup{%
		pdftitle={\inserttitle},pdfauthor={\insertauthor},
		pdfsubject={\insertdegree\ Thesis, \insertdepartment}}

	% color links
	\if@colors
		\hypersetup{%
			colorlinks,linkcolor={dark-red},citecolor={dark-blue},
			urlcolor={medium-blue}}
	\fi

	\renewcommand{\chapterautorefname}{Chapter}
	\renewcommand{\sectionautorefname}{Section}
	\renewcommand{\subsectionautorefname}{Section}
	\renewcommand{\subsubsectionautorefname}{Section}
	\RequirePackage[all]{hypcap}
}
% For including pdf pages
\usepackage{pdfpages}
% Matlab style
\lstloadlanguages{Matlab}%
\lstset{language=Matlab,                        % Use MATLAB
       %basicstyle=\color{red},
    breaklines=true,%
    morekeywords={matlab2tikz},
    keywordstyle=\color{blue},%
    morekeywords=[2]{1}, keywordstyle=[2]{\color{black}},
    identifierstyle=\color{black},%
    stringstyle=\color{mylilas},
    commentstyle=\color{mygreen},%
    showstringspaces=false,%without this there will be a symbol in the places where there is a space
    %numbers=left,%
    %numberstyle={\tiny \color{black}},% size of the numbers
    %numbersep=9pt, % this defines how far the numbers are from the text
    emph=[1]{for,end,break},emphstyle=[1]\color{red}, %some words to emphasise
    %emph=[2]{word1,word2}, emphstyle=[2]{style},    
        }
\lstdefinestyle{Matlab}{%
    keywords={void},%                 define keywords
    morecomment=[l]{\%},%             treat // as comments
}
% Arduino style 
\newcommand*{\FormatDigit}[1]{\ttfamily\textcolor{mygreen}{#1}}
\lstdefinestyle{FormattedNumber}{%
    literate=*{0}{{\FormatDigit{0}}}{1}%
             {1}{{\FormatDigit{1}}}{1}%
             {2}{{\FormatDigit{2}}}{1}%
             {3}{{\FormatDigit{3}}}{1}%
             {4}{{\FormatDigit{4}}}{1}%
             {5}{{\FormatDigit{5}}}{1}%
             {6}{{\FormatDigit{6}}}{1}%
             {7}{{\FormatDigit{7}}}{1}%
             {8}{{\FormatDigit{8}}}{1}%
             {9}{{\FormatDigit{9}}}{1}%
             {.0}{{\FormatDigit{.0}}}{2}% Following is to ensure that only periods
             {.1}{{\FormatDigit{.1}}}{2}% followed by a digit are changed.
             {.2}{{\FormatDigit{.2}}}{2}%
             {.3}{{\FormatDigit{.3}}}{2}%
             {.4}{{\FormatDigit{.4}}}{2}%
             {.5}{{\FormatDigit{.5}}}{2}%
             {.6}{{\FormatDigit{.6}}}{2}%
             {.7}{{\FormatDigit{.7}}}{2}%
             {.8}{{\FormatDigit{.8}}}{2}%
             {.9}{{\FormatDigit{.9}}}{2}%
             %{,}{{\FormatDigit{,}}{1}% depends if you want the "," in color
             {\ }{{ }}{1}% handle the space
             ,%
}
\lstset{%
  backgroundcolor=\color{mywhite},   
  basicstyle=\footnotesize,       
  breakatwhitespace=false,         
  breaklines=true,                 
  captionpos=b,                   
  commentstyle=\color{red},    
  deletekeywords={...},           
  escapeinside={\%*}{*)},          
  extendedchars=true,              
  frame=tb,                    
  keepspaces=true,                 
  keywordstyle=\color{myorange},       
  language=Octave,                
  morekeywords={*,...},            
  %numbers=left,                    
  %numbersep=5pt,                   
  %numberstyle=\tiny\color{mygray}, 
  %rulecolor=\color{black},         
  %rulesepcolor=\color{myblue},
  showspaces=false,                
  showstringspaces=false,          
  showtabs=false,                  
  stepnumber=2,                    
  stringstyle=\color{myorange},    
  tabsize=2,                       
  title=\lstname,
  emphstyle=\bfseries\color{blue},%  style for emph={} 
} 
\lstdefinestyle{Arduino}{%
    style=FormattedNumber,
    keywords={void},%                 define keywords
    morecomment=[l]{//},%             treat // as comments
    morecomment=[s]{/*}{*/},%         define /* ... */ comments
    emph={HIGH, OUTPUT, LOW},%        keywords to emphasize
}
\newtoggle{InString}{}% Keep track of if we are within a string
\togglefalse{InString}% Assume not initally in string
% Python style for highlighting
\newcommand\pythonstyle{\lstset{
language=Python,
commentstyle=\color{red},
basicstyle=\footnotesize,%\ttm,
otherkeywords={self},             % Add keywords here
keywordstyle=\ttb\color{deepblue},
emph={MyClass,__init__},          % Custom highlighting
emphstyle=\ttb\color{deepred},    % Custom highlighting style
stringstyle=\color{deepgreen},
frame=tb,                         % Any extra options here
showstringspaces=false            % 
}}
% Python environment
\lstnewenvironment{python}[1][]
{
\pythonstyle
\lstset{#1}
}
{}

% Load the package
\usepackage[toc]{glossaries}
 % Generate the glossary
\makeglossaries
% %\usepackage{nomencl}
% \usepackage[intoc]{nomencl} % load nomencl extension; include in TOC
% %\nomrefpage % to include page numbers after abbrevations
% %\renewcommand{\nomname}{Glossary} % rename nomenclature
% % As we are using the glossary to list the acronyms we change the label of the section
% \renewcommand{\nomname}{Acr\'onimos y Nomenclatura} % rename nomenclature
% \renewcommand{\nomlabel}[1]{\textbf{#1}} % make abbreviations bold
% \makenomenclature % used to be \makeglossary
% \newcommand{\g}{\footnote{For all abbreviations see the glossary on page \pageref{nom}.}} % type "\g" to refer to glossary

%\usepackage{quotchap}

% These macros define an environment for front matter that is always 
% single column even in a double-column document.

\newenvironment{alwayssingle}{%
       \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
       \else\newpage\fi}
       {\if@restonecol\twocolumn\else\newpage\fi}

%:-------------------------- dedication -----------------------

%
% The dedication environment makes sure the dedication gets its
% own page and is set out in verse format.

\newenvironment{dedication}
{\begin{alwayssingle}
  \pagestyle{empty}
  \begin{center}
  \vspace*{1.5cm}
  {\LARGE }
  \end{center}
  \vspace{0.5cm}
  \begin{quote} \begin{flushright}}
{\end{flushright} \end{quote} \end{alwayssingle}}

\makeatletter
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
	\hbox{}
	\vspace*{\fill}
	\thispagestyle{empty}
	\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\makeatother


%:-------------------------- acknowledgements -----------------------

%
% The acknowledgements environment puts a large, bold, centered 
% "Acknowledgements" label at the top of the page. The acknowledgements
% themselves appear in a quote environment, i.e. tabbed in at both sides, and
% on its own page.

\newenvironment{acknowledgements}
{\pagestyle{empty}
\begin{alwayssingle}
 \cleardoublepage
 \begin{center}
\vspace*{1.5cm}
{\Large \bfseries Agradecimientos}
\end{center}
\vspace{0.5cm}
\begin{quote}}
{\end{quote}\end{alwayssingle}}

% The acknowledgementslong environment puts a large, bold, centered 
% "Acknowledgements" label at the top of the page. The acknowledgement itself 
% does not appears in a quote environment so you can get more in.

%:-------------------------- abstract -----------------------

%
%The abstract environment puts a large, bold, centered "Abstract" label at
%the top of the page. The abstract itself appears in a quote environment,
%i.e. tabbed in at both sides, and on its own page.

\newenvironment{laburpena} {\begin{alwayssingle} \pagestyle{empty}
  \cleardoublepage
  \begin{center}
  \vspace*{1.5cm}
  {\Large \bfseries  Laburpena}
  \end{center}
  \vspace{0.5cm}
   \begin{quote}}
{\end{quote}\end{alwayssingle}}

\newenvironment{resumen} {\begin{alwayssingle} \pagestyle{empty}
  \cleardoublepage
  \begin{center}
  \vspace*{1.5cm}
  {\Large \bfseries  Resumen}
  \end{center}
  \vspace{0.5cm}
   \begin{quote}}
{\end{quote}\end{alwayssingle}}

\newenvironment{abstracts} {\begin{alwayssingle} \pagestyle{empty}
   \cleardoublepage
 \begin{center}
  \vspace*{1.5cm}
  {\Large \bfseries  Abstract}
  \end{center}
  \vspace{0.5cm}
   \begin{quote}}
{\end{quote}\end{alwayssingle}}

%The abstractlong environment puts a large, bold, centered "Abstract" label at
%the top of the page. The abstract itself does not appears in a quote
%environment so you can get more in.

\newenvironment{abstractslong} {\begin{alwayssingle} \pagestyle{empty}
  \begin{center}
   \cleardoublepage
 \vspace*{1.5cm}
  {\Large \bfseries  Abstract}
  \end{center}
  \vspace{0.5cm} \begin{quote}}
{\end{quote}\end{alwayssingle}}

%The abstractseparate environment is for running of a page with the abstract
%on including title and author etc as required to be handed in separately

\newenvironment{abstractseparate} {\begin{alwayssingle} \pagestyle{empty}
  \vspace*{-1in}
  \cleardoublepage
 \begin{center}
    { \Large {\bfseries {\@title}} \par}
    {{\large \vspace*{1ex} \@author} \par}
{\large \vspace*{1ex}
    {{\@collegeordept} \par}
    {{\@university} \par}
\vspace*{1ex}
    {{\it \submittedtext} \par}
    {\it {\@degree} \par}
\vspace*{2ex}
    {\@degreedate}}
  \end{center}}
{\end{alwayssingle}}



%:-------------------------- frontmatter text layout -----------------------

\newcommand{\frontmatter}{%
\cleardoublepage
\pagestyle{fancy}
\pagenumbering{roman}

% \chapter format
\titleformat{\chapter}[display]%		
% Label and title options
{\filleft}%
% Label format and text
{\color{Gray}{\filleft\small{\bfseries CAPÍTULO}} {\linebreak\fontsize{90}{90}\selectfont\selectfont {\bfseries \thechapter}}}	   
% Label and title distance
{2ex}
% Title format
{\vspace{2ex}\bfseries \fontsize{30}{30}\selectfont}%
% Space between title and text
\titlespacing{\chapter}{3mm}{*10}{15mm}[3mm] %

% \section format
\titleformat{\section}[block]{\normalfont\Large}{\thesection}{.5em}{\bfseries}
\titlespacing*{\section}{0pt}{*4}{*1}

% \subsection format
\titleformat{\subsection}[block]{\normalfont\large}{\thesubsection}{.5em}{\bfseries}
\titlespacing*{\subsection}{0pt}{*4}{*1}

% \subsubsection format
\titleformat{\subsubsection}[block]{\normalfont\normalsize}{\thesubsubsection}{.5em}{\bfseries}
\titlespacing*{\subsubsection}{0pt}{*4}{0.5ex}
}

%:-------------------------- mainmatter text layout -----------------------

\newcommand{\mainmatter}{%
\cleardoublepage
\pagestyle{fancy}
\pagenumbering{arabic}

%% Another version of
%% \chapter format
%\titleformat{\chapter}[block]
%{\normalfont\sffamily\huge}{\bfseries\thechapter.}{.5em}{\filleft\bfseries}
%[\titlerule\vspace{10ex}]
%%% Space between title and text
%\titlespacing*{\chapter}{0pt}{*4}{*1}

% Distance between captions and text
\setlength{\textfloatsep}{20pt}

% \chapter format
\titleformat{\chapter}[display]%		
% Label and title options
{\filleft}%
% Label format and text
{\color{Gray}{\filleft\small{\bfseries CAPÍTULO}} {\linebreak\fontsize{90}{90}\selectfont\selectfont {\bfseries \thechapter}}}	   
% Label and title distance
{2ex}
% Title format
{\vspace{2ex}\bfseries \fontsize{30}{30}\selectfont}%
% Space between title and text
\titlespacing{\chapter}{3mm}{*10}{15mm}[3mm] %

% \section format
\titleformat{\section}[block]{\normalfont\Large}{\thesection}{.5em}{\bfseries}
\titlespacing*{\section}{0pt}{*4}{*1}

% \subsection format
\titleformat{\subsection}[block]{\normalfont\large}{\thesubsection}{.5em}{\bfseries}
\titlespacing*{\subsection}{0pt}{*4}{*1}

% \subsubsection format
\titleformat{\subsubsection}[block]{\normalfont\normalsize}{\thesubsubsection}{.5em}{\bfseries}
\titlespacing*{\subsubsection}{0pt}{*4}{0.5ex}
}

%:-------------------------- backmatter text layout -----------------------

\newcommand{\backmatter}{%
\cleardoublepage
\pagestyle{fancy}
       
% \chapter format
\titleformat{\chapter}[display]%		
% Label and title options
{\filleft}%
% Label format and text
{\color{Gray}{\filleft\small{\bfseries ANEXO}}
  {\linebreak\fontsize{90}{90}\selectfont\selectfont {\bfseries \thechapter}}}	   
% Label and title distance
{2ex}
% Title format
{\vspace{2ex}\bfseries \fontsize{30}{30}\selectfont}%
% Space between title and text
\titlespacing{\chapter}{3mm}{*10}{15mm}[3mm] %       
       
% \section format
\titleformat{\section}[block]{\normalfont\Large}{\thesection}{.5em}{\bfseries}
\titlespacing*{\section}{0pt}{*4}{*1}

% \subsection format
\titleformat{\subsection}[block]{\normalfont\large}{\thesubsection}{.5em}{\bfseries}
\titlespacing*{\subsection}{0pt}{*4}{*1}

% \subsubsection format
\titleformat{\subsubsection}[block]{\normalfont\normalsize}{\thesubsubsection}{.5em}{\bfseries}
\titlespacing*{\subsubsection}{0pt}{*4}{0.5ex}
}

\endinput
