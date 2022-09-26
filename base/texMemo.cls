% Part of code is from: Rob Oakes
% Author: Claude Xin, Copyright 2022.  Released under the LGPL, version 3.
% A copy of the LGPL can be found at http://www.gnu.org/licenses/lgpl.html

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{texMemo}[2022/05/05 - research notes/memos template]
\RequirePackage{palatino}

\usepackage{graphicx}

% Load the Base Class
\PassOptionsToClass{\CurrentOption}{article}
\LoadClass[twoside]{article}



% Begin Requirements
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\RequirePackage{bussproofs}
\RequirePackage{color}
\RequirePackage{dsfont}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{ifthen}
\RequirePackage{subfig}
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{xeCJK}
\RequirePackage{parskip}
\RequirePackage{enumitem}
\RequirePackage{pgfgantt}
\RequirePackage{tikz}
\RequirePackage{upgreek}
\RequirePackage{ifplatform} % detect the platform of the os, support commands i.e., iflinux, ifmacosx. '--shell-escape' is required when build
\RequirePackage[colorlinks=true,linkcolor=blue,urlcolor=black,bookmarksopen=true]{hyperref}
\usetikzlibrary{arrows, backgrounds, positioning, calc, automata, matrix, shapes.geometric, shapes.misc}

\RequirePackage{semantic} % Support for semantic definition
\RequirePackage[center]{formal-grammar} % For BNF

\RequirePackage{skak} % Unicode symbol
\RequirePackage{scalerel} % Scale unicode symbol
\RequirePackage{pifont} % Crossmark and checkmark
\newcommand{\cmark}{\ding{51}}
\newcommand{\xmark}{\ding{55}}


\RequirePackage[backend=biber]{biblatex}
\ExecuteBibliographyOptions{url=false, maxnames=99}

\def\@btitle{\relax}
\newcommand{\btitle}[1]{\gdef\@btitle{\textsc{#1}}}

\def\@memoto{\relax}
\newcommand{\memoto}[1]{\gdef\@memoto{#1}}

\def\@memofrom{\relax}
\newcommand{\memofrom}[1]{\gdef\@memofrom{#1}}

\def\@memosubject{\relax}
\newcommand{\memosubject}[1]{\gdef\@memosubject{#1}}

\def\@memodate{\relax}
\newcommand{\memodate}[1]{\gdef\@memodate{#1}}

\def\@memologo{\relax}
\newcommand{\logo}[1]{\gdef\@memologo{\protect #1}}

\def\@letterheadaddress{\relax}
\newcommand{\lhaddress}[1]{\gdef\@letterheadaddress{#1}}

% Custom Document Formatting
\newcommand\decorativeline[1][1pt]{
	\par\noindent%
	\rule[0.5ex]{\linewidth}{#1}\par
}

% Set the Paper Size and margins
\usepackage[a4paper,
  inner=20mm,
  outer=60mm,% = marginparsep + marginparwidth
  top=20mm,
  bottom=25mm,
  marginparsep=15mm,
  marginparwidth=40mm]{geometry} % Page
\newcommand{\sidenotectx}[2]{\marginpar{{\color{black} #2} \small{#1}}}
\newcommand{\sidenote}[1]{\sidenotectx{#1}{$\blacksquare$}}
\newcommand{\idxsidenote}[1]{\sidenotectx{\small{{\color{gray} #1}}}{$\hookrightarrow$}}
  
% \sidenote{\normalsize{\textbf{{\color{black} $\hookrightarrow$ }}}{\color{gray}#1}}}


% Create the Letterhead and To/From Block

\renewcommand{\maketitle}{\makememotitle}
\newcommand\makememotitle{
	\ifthenelse{\equal{\@memologo}{\relax}}{}
	{ % Create With Logo
	\begin{minipage}[t]{1\columnwidth}%
		\begin{flushright}
			\vspace{-0.6in}
			\@memologo
			\vspace{0.5in}
		\par\end{flushright}%
	\end{minipage}
	}
	{\begin{center}
	\LARGE\bf
	% R\textsc{esearch} \textsc{Proposal}
  \ifthenelse{\equal{\@btitle}{\relax}}{}{\@btitle}
	\end{center}}
	% To, From, Subject Block
	\begin{description}
		% \ifthenelse{\equal{\@memoto}{\relax}}{}{\item [{To:}] \@memoto}
		\ifthenelse{\equal{\@memofrom}{\relax}}{}{\item [{Author:}] \@memofrom}
		\ifthenelse{\equal{\@memosubject}{\relax}}{}{\item [{Subject:}] \@memosubject}
		\ifthenelse{\equal{\@memodate}{\relax}}{}{\item [{Date:}] \@memodate}
	\end{description}
	\decorativeline\bigskip{}
}

% Code
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\lstdefinestyle{common} {
  backgroundcolor=\color{backcolour},   
  commentstyle=\color{codegreen},
  keywordstyle=\color{magenta},
  numberstyle=\tiny\color{codegray},
  stringstyle=\color{codepurple},
  basicstyle=\ttfamily\footnotesize,
  breakatwhitespace=false,         
  breaklines=true,                 
  captionpos=b,                    
  keepspaces=true,                 
  numbers=left,                    
  numbersep=5pt,                  
  showspaces=false,                
  showstringspaces=false,
  showtabs=false,                  
  tabsize=2
}

% Ocaml language
\lstdefinelanguage{ocaml} {
  style=common
}
\lstnewenvironment{ocaml} {\lstset{language=ocaml}}{}

% Coq language
\lstdefinelanguage{coq} {
  morekeywords={
    Inductive, Type, Definition, match, with, end, Compute,
    Example, Theorem, Lemma, Fact,
    Proof, Qed
    },
  sensitive=true,
  morecomment=[s]{(*}{*)}, 
  morestring=[b]",
  style=common
}
\lstnewenvironment{coq} {\lstset{language=coq}}{}

% Racket language
\lstdefinelanguage{racket} {
  morekeywords={
    define, list, lambda,
    cond, if, and, or, struct,
    require, letrec, let, module,
    provide},
  sensitive=true,
  morecomment=[l]{;}, 
  morestring=[b]",
  style=common
}
\lstnewenvironment{racket} {\lstset{language=racket}}{}

% Haskell language
\lstdefinelanguage{haskell} {
  morekeywords={
    as, case, of, family, default, 
    module, where, infixl, infix, infixr,
    instance, class, data, deriving,
    do, forall, foreign, hiding, if, then, else,
    import, let, in, mdo, newtype, proc, qualified, 
    rec, type
    },
  sensitive=true,
  morecomment=[l]{--}, 
  morecomment=[s]{\{-}{-\}},
  morestring=[b]",
  style=common
}
\lstnewenvironment{haskell} {\lstset{language=haskell}}{}

% Python
\lstdefinelanguage{python} {
  morekeywords={
    for, in, while, True, False, class, with, and, or, not, if, else
  },
  sensitive=true,
  morecomment=[l]{\#},
  morecomment=[s]{"""}{"""},
  morestring=[b]",
  style=common
}
\lstnewenvironment{python} {\lstset{language=python}}{}

% Rust
\lstdefinelanguage{rust} {
  morekeywords={
    as, break, const, continue, crate, else, enum, extern, false, fn,
    for, if, impl, in, let, loop, match, mod, move, mut, pub, ref, return,
    self, Self, static, struct, super, trait, true, type, unsafe
    use, where, while, async, await, dyn, abstract, become, box,
    do, final, macro, override, priv, typeof, unsized, virtual, yield
  },
  sensitive=true,
  morecomment=[l]{//},
  morecomment=[s]{/*}{*/},
  morestring=[b]",
  style=common
}
\lstnewenvironment{rust} {\lstset{language=rust}}{}

% Fsharp
\lstdefinelanguage{fsharp}{
  morekeywords={
    abstract, and, as, assert, base, begin, class,
    default, delegate, do, done, downcast, downto, elif, else, end,
    exception, extern, false, finally, fixed, for, fun, function, global, if,
    in, inherit, inline, interface, internal, lazy, let, let!, match, match!, member,
    module, mutable, namespace, new, not, null, of, open, or, override, private, public,
    rec, return, return!, select, static, struct, then, to, true, try, type, upcast, use,
    use!, val, void, when, while, with, yield, yield!, const,
    % Ocaml extension
    asr, land, lor, lsl, lsr, lxor, mod, sig,
    % Future expansion
    break, checked, component, const, constraint, continue, event, external, include, mixin, parallel,
    process, protected, pure, sealed, tailcall, trait, virtual
  },
  sensitive=true,
  morecomment=[l]{//},
  morecomment=[s]{(*}{*)},
  morestring=[b]",
  style=common
}
\lstnewenvironment{fsharp} {\lstset{language=fsharp}}{}

% Style
\renewcommand{\emph}[1]{\textbf{{\color{magenta}#1}}}
\newcommand{\remph}[1]{\emph{#1}\idxsidenote{#1}}
% \renewcommand{\paragraph}[1]{\scalerel*{\WhiteKnightOnWhite}{Xg} \textbf{#1}}
\renewcommand{\paragraph}[1]{$\blacksquare$ \textbf{#1}}
\newcommand{\hl}[1]{{\color{teal}#1}}
\newcommand{\No}[1]{\hfill\break{\color{violet} \textbf{$\textsection$#1$\Rightarrow$}}}
\newcommand{\chbox}[1]{{\color{brown}#1}}
\newcommand{\sref}[1]{\textit{$\langle\dag$ #1 $\rangle$}}

\iflinux\setCJKmainfont{Noto Sans Mono CJK SC}\fi
\ifmacosx\setCJKmainfont{Heiti SC}\fi

% Theorem & Definition
\RequirePackage[framemethod=TiKz]{mdframed}
\theoremstyle{definition}

\newtheorem{theorem}{Theorem}
\newtheorem{definition}{Definition}
\newtheorem{proposition}{Proposition}
\newtheorem{lemma}{Lemma}
\newtheorem{notation}{Notation}
\newtheorem{convention}{Convention}

\surroundwithmdframed[backgroundcolor=red!20, skipabove=1em, linewidth=1.5pt]{definition}
\surroundwithmdframed[backgroundcolor=blue!20, skipabove=1em, linewidth=1.5pt]{theorem}
\surroundwithmdframed[backgroundcolor=yellow!20, skipabove=1em, linewidth=1.5pt]{proposition}
\surroundwithmdframed[backgroundcolor=green!20, skipabove=1em, linewidth=1.5pt]{lemma}
\surroundwithmdframed[backgroundcolor=magenta!20, skipabove=1em, linewidth=1.5pt]{notation}
\surroundwithmdframed[backgroundcolor=cyan!20, skipabove=1em, linewidth=1.5pt]{convention}

% Note 
\newmdenv[roundcorner=10pt, linecolor=red!50, linewidth=2pt, skipabove=1em, leftmargin=3em, rightmargin=3em, backgroundcolor=yellow!20]{mdnote}
\newenvironment{note}{\begin{mdnote} \textbf{$\dagger$ Conclusion:}}{\end{mdnote}}

% Unicode setting for Agda language
\RequirePackage{unicode-math}
\RequirePackage{newunicodechar}
% Unicode
\newunicodechar{ₐ}{\ensuremath{{}_{a}}}
\newunicodechar{ₑ}{\ensuremath{{}_{e}}}
\newunicodechar{ₕ}{\ensuremath{{}_{h}}}
\newunicodechar{ᵢ}{\ensuremath{{}_{i}}}
\newunicodechar{ⱼ}{\ensuremath{{}_{j}}}
\newunicodechar{ₖ}{\ensuremath{{}_{k}}}
\newunicodechar{ₗ}{\ensuremath{{}_{l}}}
\newunicodechar{ₘ}{\ensuremath{{}_{m}}}
\newunicodechar{ₙ}{\ensuremath{{}_{n}}}
\newunicodechar{ₒ}{\ensuremath{{}_{o}}}
\newunicodechar{ₚ}{\ensuremath{{}_{p}}}
\newunicodechar{ᵣ}{\ensuremath{{}_{r}}}
\newunicodechar{ₛ}{\ensuremath{{}_{s}}}
\newunicodechar{ₜ}{\ensuremath{{}_{t}}}
\newunicodechar{ᵤ}{\ensuremath{{}_{u}}}
\newunicodechar{ᵥ}{\ensuremath{{}_{v}}}
\newunicodechar{ₓ}{\ensuremath{{}_{x}}}

\newunicodechar{₀}{\ensuremath{{}_{0}}}
\newunicodechar{₁}{\ensuremath{{}_{1}}}
\newunicodechar{₂}{\ensuremath{{}_{2}}}
\newunicodechar{₃}{\ensuremath{{}_{3}}}
\newunicodechar{₄}{\ensuremath{{}_{4}}}
\newunicodechar{₅}{\ensuremath{{}_{5}}}
\newunicodechar{₆}{\ensuremath{{}_{6}}}
\newunicodechar{₇}{\ensuremath{{}_{7}}}
\newunicodechar{₈}{\ensuremath{{}_{8}}}
\newunicodechar{₉}{\ensuremath{{}_{9}}}

\newunicodechar{₊}{\ensuremath{{}_{+}}}
\newunicodechar{₋}{\ensuremath{{}_{-}}}
\newunicodechar{₌}{\ensuremath{{}_{=}}}
