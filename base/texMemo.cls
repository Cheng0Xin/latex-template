% Part of code is from: Rob Oakes
% Author: Claude Xin, Copyright 2022.  Released under the LGPL, version 3.
% A copy of the LGPL can be found at http://www.gnu.org/licenses/lgpl.html

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{texMemo}[2022/05/05 - research notes/memos template]
\RequirePackage{palatino}

\usepackage{graphicx}

% Load the Base Class
% \PassOptionsToClass{\CurrentOption}{article}
% \LoadClass[twoside]{article}
\LoadClassWithOptions{article}

% Begin Requirements
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
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
% \RequirePackage{enumitem}
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

% Formula in section
\def\secformula#1{\texorpdfstring{$#1$}{}}

\RequirePackage{titlesec}

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
\if@twoside%
  \usepackage{marginfix}
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
  \newcommand{\remph}[1]{\emph{#1}\idxsidenote{#1}}
\else%
\usepackage[a4paper,
  inner=20mm,
  outer=20mm,
  top=20mm,
  bottom=20mm]{geometry} % Page
\fi%

% \RequirePackage{bm} % For bold math symbol
\newcommand{\bm}[1]{\textit{\textbf{#1}}}

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
  % For equations
  \setlength{\abovedisplayskip}{0pt}
  % \setlength{\abovedisplayshortskip}{0pt}
  \setlength{\belowdisplayskip}{0pt}
  % \setlength{\belowdisplayshortskip}{-5pt}

  % For itemize and enumerate
  \setlength{\itemsep}{0em}
  \setlength{\parskip}{0em}
  \setlength{\topsep}{0em}

  % For paragraph
  \setlength{\baselineskip}{1.2em}
  % \setlength{\parskip}{\baselineskip}

  % For section
  \titlespacing\section{0pt}{1\baselineskip}{1\baselineskip}
  \titlespacing\subsection{0pt}{1\baselineskip}{1\baselineskip}
  \titlespacing\subsubsection{0pt}{1\baselineskip}{1\baselineskip}
  \titlespacing\paragraph{0pt}{1\baselineskip}{1\baselineskip}

  % For line space

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

% Cpp
\lstdefinelanguage{cpp} {
  morekeywords={
    alignas, alignof, and, and_eq, asm, atomic_cancel,
    atomic_commit, atomic_noexcept, auto, bitand, bitor,
    bool, break, case, catch, char, char8_t, char16_t,
    char32_t, class, compl, concept, const, consteval,
    constexpr, constinit, const_cast, continue,
    co_await, co_return, co_yield, decltype, default,
    delete, do, double, dynamic_cast, else, enum, explicit,
    export, extern, false, float, for, friend, goto, if, include,
    inline, int, long, mutable, namespace, new, noexcept,
    not, not_eq, nullptr, operator, or, or_eq, private,
    protected, public, reflexpr, register, reinterpret_cast,
    requires, return, short, signed, sizeof, static,
    static_assert, static_cast, struct, switch, synchronized,
    template, this, thread_local, throw, true, try, typedef,
    typeid, typename, union, unsigned, using, virtual, void,
    volatile, wchar_t, while, xor, xor_eq
  },
  sensitive=true,
  morecomment=[l]{//},
  morecomment=[s]{/*}{*/},
  morestring=[b]",
  style=common
}

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

% Style
\renewcommand{\emph}[1]{\textbf{{\color{magenta}#1}}}
\newcommand{\hl}[1]{\textbf{\color{teal}#1}}
\newcommand{\chbox}[1]{{\color{brown}#1}}
\newcommand{\sref}[1]{
    \phantomsection
    \texttt{$\|${\color{codepurple}#1}$\|$}
    \def\@currentlabel{\unexpanded{#1}}\label{#1}
}
\def\tbf#1{\textbf{#1}}
\def\tit#1{\textit{#1}}
\def\ttt#1{\texttt{#1}}
\def\defeq{\overset{\mbox{\ttt{\tiny{def}}}}{=}}

% Numbering
\renewcommand{\paragraph}[1]{\hfill\break$\blacksquare$ \textbf{#1}}
\newcommand{\No}[1]{\hfill\break{\color{violet} \textbf{$\textsection$#1$\Rightarrow$}}}

% Control detecting environment
\newcounter{detectObject}
\newcommand{\setDetectObject}[1]{\setcounter{detectObject}{#1}}
\newcommand{\getDetectObject}{\arabic{detectObject}}

\newcounter{noi}
\newcounter{noii}
\newcounter{noiii}
\def\nocolor{violet}

\newcommand{\noh}{
  \setcounter{noi}{1}
  \setDetectObject{1}
  \if\getDetectObject1 \setDetectObject{0} \else ~\\ \fi
  {\color{\nocolor}
    \textbf{$\blacksquare$\texttt{\arabic{noi}} $\Rightarrow$ }}}
\newcommand{\no}{
  \stepcounter{noi}
  \if\getDetectObject1 \setDetectObject{0} \else ~\\ \fi
  {\color{\nocolor}
    \textbf{$\blacksquare$\texttt{\arabic{noi}} $\Rightarrow$ }}}

\newcommand{\snoh}{
  \setcounter{noii}{1}
  \if\getDetectObject1 \setDetectObject{0} \else ~\\ \fi
  {\color{\nocolor}
    \textbf{$\vdash\blacksquare$\texttt{\arabic{noi}.\arabic{noii}} $\Rightarrow$ }}}
\newcommand{\sno}{
  \stepcounter{noii}
  \if\getDetectObject1 \setDetectObject{0} \else ~\\ \fi
  {\color{\nocolor}
    \textbf{$\vdash\blacksquare$\texttt{\arabic{noi}.\arabic{noii}} $\Rightarrow$ }}}

\newcommand{\ssnoh}{
  \setcounter{noiii}{1}
  \if\getDetectObject1 \setDetectObject{0} \else ~\\ \fi
  {\color{\nocolor}
    \textbf{$\vdash\vdash\blacksquare$\texttt{\arabic{noi}.\arabic{noii}.\arabic{noiii}} $\Rightarrow$ }}}
\newcommand{\ssno}{
  \stepcounter{noiii}
  \if\getDetectObject1 \setDetectObject{0} \else ~\\ \fi
  {\color{\nocolor}
    \textbf{$\vdash\vdash\blacksquare$\texttt{\arabic{noi}.\arabic{noii}.\arabic{noiii}} $\Rightarrow$ }}}

% Font selection
\iflinux\setCJKmainfont{Noto Sans Mono CJK SC}\fi
\ifmacosx\setCJKmainfont{Heiti SC}\fi

% Theorem and Definition
\newtheoremstyle{theoremdd}% name of the style to be used
  {\topsep}% measure of space to leave above the theorem. E.g.: 3pt
  {\topsep}% measure of space to leave below the theorem. E.g.: 3pt
  {\normalfont}% name of font to use in the body of the theorem
  {0pt}% measure of space to indent
  {\bfseries}% name of head font
  {. }% punctuation between head and body
  { }% space after theorem head; " " = normal interword space
  {\thmname{#1}\thmnumber{ #2}\textnormal{\thmnote{ #3}}}

\RequirePackage[framemethod=TiKz]{mdframed}
% \theoremstyle{definition}
\theoremstyle{theoremdd}

\newtheorem{fact}{Fact}
\newtheorem{theorem}{Theorem}
\newtheorem{definition}{Definition}
\newtheorem{proposition}{Proposition}
\newtheorem{lemma}{Lemma}
\newtheorem{notation}{Notation}
\newtheorem{convention}{Convention}
\newtheorem*{fact*}{Fact}
\newtheorem*{theorem*}{Theorem}
\newtheorem*{definition*}{Definition}
\newtheorem*{proposition*}{Proposition}
\newtheorem*{lemma*}{Lemma}
\newtheorem*{notation*}{Notation}
\newtheorem*{convention*}{Convention}

% Short theorem and definition
\def\thbox#1#2#3{\tbf{{\color{#1}#2}\sref{#3}:}}
\def\thm#1{\thbox{blue!50}{Theorem}{#1}}
\def\lmm#1{\thbox{blue!50}{Lemma}{#1}}
\def\coro#1{\thbox{blue!50}{Corollary}{#1}}
\def\rmk#1{\thbox{magenta!50}{Remark}{#1}}
\def\defi#1{\thbox{red!50}{Definition}{#1}}
\def\conv#1{\thbox{cyan!50}{Convention}{#1}}
\def\shref#1{\hyperref[#1]{{\color{teal} \ttt{$\dagger$#1}}}}
\def\impt{\emph{$\star$}}

\mdfdefinestyle{surroundwfstyle}{%
    roundcorner=5pt,
    skipabove=0.5em,
    skipbelow=0.5em,
    linewidth=1.5pt,
    innertopmargin=6pt,
    nobreak=true
}
\surroundwithmdframed[backgroundcolor=red!20, style=surroundwfstyle]{definition}
\surroundwithmdframed[backgroundcolor=blue!30, style=surroundwfstyle]{theorem}
\surroundwithmdframed[backgroundcolor=blue!30, style=surroundwfstyle]{fact}
% \surroundwithmdframed[backgroundcolor=blue!15, style=surroundwfstyle, linewidth=.5pt]{proof}
\surroundwithmdframed[backgroundcolor=yellow!20, style=surroundwfstyle]{proposition}
\surroundwithmdframed[backgroundcolor=blue!20, style=surroundwfstyle]{lemma}
\surroundwithmdframed[backgroundcolor=magenta!20, style=surroundwfstyle]{notation}
\surroundwithmdframed[backgroundcolor=cyan!20, style=surroundwfstyle]{convention}
\surroundwithmdframed[backgroundcolor=red!20, style=surroundwfstyle]{definition*}
\surroundwithmdframed[backgroundcolor=blue!30, style=surroundwfstyle]{theorem*}
\surroundwithmdframed[backgroundcolor=blue!30, style=surroundwfstyle]{fact*}
\surroundwithmdframed[backgroundcolor=yellow!20, style=surroundwfstyle]{proposition*}
\surroundwithmdframed[backgroundcolor=blue!20, style=surroundwfstyle]{lemma*}
\surroundwithmdframed[backgroundcolor=magenta!20, style=surroundwfstyle]{notation*}
\surroundwithmdframed[backgroundcolor=cyan!20, style=surroundwfstyle]{convention*}


\newenvironment{defienv}[2]{
    \begin{definition*}[\sref{#1}\tbf{:} #2]\hfill
}
{
    \end{definition*}
}
\newenvironment{lmmenv}[2]{
    \begin{lemma*}[\sref{#1}\tbf{:} #2]\hfill
}
{
    \end{lemma*}
}

% Note
\newmdenv[
    roundcorner=10pt,
    linecolor=red!50,
    linewidth=2pt,
    skipabove=.5em,
    skipbelow=.5em,
    nobreak=true,
    % leftmargin=3em,
    % rightmargin=3em,
    backgroundcolor=yellow!20]{mdnote}
\newenvironment{note}{
    \begin{mdnote} \textbf{$\dagger$ Conclusion: }}{\end{mdnote}\setDetectObject{1}}
% Proof
\newmdenv[
    roundcorner=5pt,
    linecolor=black!50,
    linewidth=1.5pt,
    skipabove=.5em,
    skipbelow=.5em,
    nobreak=true,
    % leftmargin=3em,
    % rightmargin=3em,
    backgroundcolor=blue!10]{mdproof}
\renewenvironment{proof}{
    \begin{mdproof} \textbf{Proof: }}{\end{mdproof}\setDetectObject{1}}

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

\renewcommand{\labelenumi}{\ttt{(\arabic{enumi})}}
\renewcommand{\labelenumii}{\ttt{(\arabic{enumi}.\arabic{enumii})}}
% \renewcommand{\labelenumiii}{\arabic{enumi}.\arabic{enumii}.\arabic{enumiii}}
% \renewcommand{\labelenumiv}{\arabic{enumi}.\arabic{enumii}.\arabic{enumiii}.\arabic{enumiv}}

\newenvironment{itemize*}{\begin{itemize}}{\end{itemize}\setDetectObject{1}}
\newenvironment{enumerate*}{\begin{enumerate}}{\end{enumerate}\setDetectObject{1}}
% \newenvironment{eq*}{\begin{align}}{\end{align}\setDetectObject{1}}
\lstnewenvironment{ocaml} {\lstset{language=ocaml}}{}
\lstnewenvironment{coq} {\lstset{language=coq}}{}
\lstnewenvironment{racket} {\lstset{language=racket}}{}
\lstnewenvironment{haskell} {\lstset{language=haskell}}{}
\lstnewenvironment{python} {\lstset{language=python}}{}
\lstnewenvironment{rust} {\lstset{language=rust}\setDetectObject{1}}{}
\lstnewenvironment{cpp} {\lstset{language=cpp}}{}
\lstnewenvironment{fsharp} {\lstset{language=fsharp}}{}

% \newcommand{\restore@Environment}[1]{%
%   \AtBeginDocument{%
%     \csletcs{#1*}{#1}%
%     \csletcs{end#1*}{end#1}%
%   }%
%   \setDetectObject{1}
% }
% \forcsvlist\restore@Environment{alignat,equation,gather,multline,flalign,align}
\AtBeginDocument{
\newenvironment{eq*}{\begin{align}}{\end{align}\setDetectObject{1}}
}
\def\[#1\]{~\\\begin{minipage}{\textwidth}\begin{align}#1\end{align}\end{minipage}\setDetectObject{1}\\}

\def\refstable#1{
\begin{table}[H]
    \resizebox{\columnwidth}{!}{
    \begin{tabular}{| l | l | l |}
	\hline
	#1
	\hline
    \end{tabular}}
\end{table}
}
\def\refsitem#1#2#3{
    #1 & \shref{#2} & #3 \\
}
