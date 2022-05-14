% This document class provides a simple memo for LaTeX users.
% It is based on article.cls and inherits most of the functionality
% that class.
% 
% Author: Rob Oakes, Copyright 2010.  Released under the LGPL, version 3.
% A copy of the LGPL can be found at http://www.gnu.org/licenses/lgpl.html

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{texMemo}[2010/07/31 - Simple Memo Class, Including Logo]
\RequirePackage{palatino}

\usepackage{graphicx}

% Load the Base Class
\LoadClassWithOptions{article}

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
\RequirePackage{geometry}
\RequirePackage{float}
\RequirePackage{ifthen}
\RequirePackage{syntax}
\RequirePackage{subfig}
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{xeCJK}
\RequirePackage{parskip}
\RequirePackage{pgfgantt}
\RequirePackage{tikz}
\RequirePackage{upgreek}
\RequirePackage[colorlinks=true,linkcolor=blue,urlcolor=black,bookmarksopen=true]{hyperref}
\usetikzlibrary{arrows, backgrounds, positioning, calc, automata, matrix, shapes.geometric, shapes.misc}

% Specialized memo Commands (To, From, Subject, Logo, Letterhead Address)

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
\RequirePackage{geometry}
\geometry{margin=1.0in}

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

% Style
\renewcommand{\emph}[1]{\textbf{{\color{magenta}#1}}}
\newcommand{\highlight}[1]{{\color{teal}#1}}
\newcommand{\hl}[1]{\highlight{#1}}
\newcommand{\No}[1]{{\color{violet} \textbf{$\textsection$#1$\Rightarrow$}}}
\newcommand{\chbox}[1]{{\color{brown}#1}}
\newcommand{\sref}[1]{\textit{$\langle\dag$ #1 $\rangle$}}
\setCJKmainfont{Heiti SC}

% Theorem & Definition
\RequirePackage{mdframed}
\theoremstyle{definition}

\newtheorem{theorem}{Theorem}
\newtheorem{definition}{Definition}
\newtheorem{proposition}{Proposition}

\surroundwithmdframed[backgroundcolor=red!20]{definition}
\surroundwithmdframed[backgroundcolor=blue!20]{theorem}
\surroundwithmdframed[backgroundcolor=yellow!20]{proposition}
