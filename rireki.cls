\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rireki}

\newif\if@afour
\newif\if@letterpaper
\newif\if@picture
\newif\if@stamp
\newif\if@foreign
\newif\if@nokanji
\newif\if@twoside
\newif\if@lowres
\@afourfalse
\@letterpaperfalse
\@picturefalse
\@stampfalse
\@foreignfalse
\@nokanjifalse
\@twosidetrue
\@lowrestrue
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{afour}{\@afourtrue}
\DeclareOption{letterpaper}{\@letterpapertrue}
\DeclareOption{picture}{\@picturetrue}
\DeclareOption{stamp}{\@stamptrue}
\DeclareOption{foreign}{\@foreigntrue}
\DeclareOption{nokanji}{\@nokanjitrue}
\DeclareOption{oneside}{\@twosidefalse}
\DeclareOption{hires}{\@lowresfalse}
\ProcessOptions\relax
\LoadClass[twoside, 11pt]{article}

\usepackage{xltxtra}
\gdef\@normalsize{11pt}
\defaultfontfeatures{Scale=MatchLowercase, Mapping=tex-text}
\setmainfont{Linux Libertine O}
\setromanfont{Linux Libertine O}
\setsansfont{Linux Biolinum O}
\setmonofont{DejaVu Sans Code}
\usepackage{xeCJK}
\setCJKmainfont{IPAMincho}
\setCJKsansfont{IPAMincho}
\usepackage{xunicode} % extra support for unicode
\XeTeXlinebreaklocale "ja"
\XeTeXlinebreakskip=0pt plus 1pt
\XeTeXlinebreakpenalty=0

\usepackage{xifthen}

\newcommand{\era}{\protect\@era}
\newcommand{\@era}[1][]{
  \ifthenelse{\isempty{#1}}{}{
  \@tempcnta=#1
  \ifnum\@tempcnta<1989
    \advance\@tempcnta by -1925
    昭和
  \else
    \advance\@tempcnta by -1988
    平成
  \fi
  \ifnum\@tempcnta=1
    元
  \else
    \the\@tempcnta
  \fi}
}
\usepackage{graphicx}
\if@lowres
  \graphicspath{{img/}}
\else
  \graphicspath{{img-hires/}}
\fi

\usepackage{datetime2}

\DTMnewdatestyle{jpdate}{%
  \renewcommand*{\DTMdisplaydate}[4]{##1年##2月##3日}%
  \renewcommand*{\DTMDisplaydate}{\DTMdisplaydate}%
}
\DTMnewdatestyle{nengodate}{%
  \renewcommand*{\DTMdisplaydate}[4]{\era[##1]年##2月##3日}%
  \renewcommand*{\DTMDisplaydate}{\DTMdisplaydate}%
}
\DTMsetdatestyle{nengodate}

\usepackage{hyperref}

\if@letterpaper
  \setlength{\paperwidth}{8.5in}
  \setlength{\paperheight}{11in}
\else\if@afour
  \setlength{\paperwidth}{210mm}
  \setlength{\paperheight}{297mm}
\else  % B5
  \setlength{\paperwidth}{182mm}
  \setlength{\paperheight}{257mm}
\fi\fi
\@settopoint{\paperwidth}
\@settopoint{\paperheight}

% Origin
\setlength{\voffset}{0pt}  % Or -1in
\setlength{\hoffset}{0pt}  % Or -1in

% Use no margins
\setlength{\marginparsep}{0pt}
\setlength{\marginparwidth}{0pt}
\setlength{\marginparpush}{0pt}

% Left margin
\setlength{\oddsidemargin}{0mm}  % Or 20mm
\setlength{\evensidemargin}{0mm}  % Or 10.5mm
\@settopoint{\oddsidemargin}
\@settopoint{\evensidemargin}

% Top margin
\setlength{\headheight}{\z@}
\setlength{\headsep}{\z@}
\setlength{\topsep}{\z@}
\setlength{\topmargin}{0mm}  % Or 16mm
\@settopoint{\topmargin}

% Use no footers
\setlength{\footnotesep}{\z@}
\setlength{\footskip}{\z@}

% Text area
\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-\oddsidemargin}
\addtolength{\textwidth}{-\evensidemargin}
\@settopoint{\textwidth}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-2\topmargin}
\@settopoint{\textheight}

% Graphics origin
\newcommand{\@x}{0}
\newcommand{\@y}{0}
\newcounter{pic@x}
\newcounter{pic@y}
\def\MoveTo(#1,#2){\gdef\@x{#1}\gdef\@y{#2}}
\def\RMoveTo(#1,#2){ %
  \@tempcnta=\number\@x
  \advance\@tempcnta by #1
  \xdef\@x{\the\@tempcnta}
  \@tempcnta=\number\@y
  \advance\@tempcnta by #2
  \xdef\@y{\the\@tempcnta}
}

\def\Put(#1,#2){%
  \setcounter{pic@x}{\@x}
  \setcounter{pic@y}{\pic@height}
  \addtocounter{pic@x}{#1}
  \addtocounter{pic@y}{-\@y}
  \addtocounter{pic@y}{-#2}
  \put(\thepic@x, \thepic@y)%
}

\def\MultiPut(#1,#2)(#3,#4){
  \setcounter{pic@x}{\@x}
  \setcounter{pic@y}{\pic@height}
  \addtocounter{pic@x}{#1}
  \addtocounter{pic@y}{-\@y}
  \addtocounter{pic@y}{-#2}
  \multiput(\thepic@x,\thepic@y)(#3,-#4)%
}

\let\@firstpagehook\@empty
\let\@secondpagehook\@empty
\newcommand\@surname\@empty
\newcommand\kana@surname\@empty
\newcommand\@forename\@empty
\newcommand\kana@forename\@empty
\newcommand\@surnameForeign\@empty
\newcommand\kana@surnameForeign\@empty
\newcommand\@forenameForeign\@empty
\newcommand\kana@forenameForeign\@empty
\newcommand\@address\@empty
\newcommand\kana@address\@empty
\newcommand\@postalcode\@empty
\newcommand\@phone\@empty
\newcommand\@email\@empty
\newcommand\@github\@empty
\newcommand\@otheraddress\@empty
\newcommand\kana@otheraddress\@empty
\newcommand\@otherpostalcode\@empty
\newcommand\@otherphone\@empty
\newcommand\@birthday\@empty
\newcommand\@subjects\@empty
\newcommand\@selfintro\@empty
\newcommand\@hobbies\@empty
\newcommand\@strengths\@empty
\newcommand\@motive\@empty
\newcommand\@desire\@empty
\newcommand\@commute\@empty
\newcommand\@dependents\@empty
\newcommand\@spouse\@empty
\newcommand\@spousedependence\@empty
\newcommand\@guardian\@empty
\newcommand\kana@guardian\@empty
\newcommand\@guardianaddress\@empty
\newcommand\kana@guardianaddress\@empty
\newcommand\@guardianpostalcode\@empty
\newcommand\@guardianphone\@empty

% Runs at \end{document}
\newcommand{\@makerireki}{
  \setlength\unitlength{1mm}
  \@tempcnta=\number\textwidth
  \divide\@tempcnta by \number\unitlength
  \edef\pic@width{\the\@tempcnta}
  \@tempcnta=\number\textheight
  \divide\@tempcnta by \number\unitlength
  \edef\pic@height{\the\@tempcnta}

  % Picture environment
  %\noindent
  \begin{picture}(\pic@width,\pic@height)

    % Title and picture box
    \MoveTo(0,0)
    \Put(0,0){\Large\bfseries\resumestr}
    \Put(100,2){\makebox(0,5)[rc]{\scriptsize\@date 現在}}
    \if@picture
      \Put(105,31){\dashbox{0.5}(28,38)[c]{
	\includegraphics[width=30mm]{face}}
      }
    \else
      \Put(105,31){
	\dashbox{0.5}(28,38)[c]{
	  \scriptsize \shortstack[c]{
	    写真を貼る位置\\縦 36 〜 40 mm\\横 24 〜 30 mm
	  }
	}
      }
    \fi
    \@tempcnta=\number\paperheight
    \divide\@tempcnta by 2
    \advance\@tempcnta by -\number\topmargin
    \divide\@tempcnta by \unitlength
    \Put(-16,\the\@tempcnta){$\triangleleft$}

    % Profile
    \MoveTo(0,0)
    \thicklines
    \Put(0,2){\line(1,0){100}}
    \Put(0,2){\line(0,-1){76}}
    \Put(0,78){\line(1,0){151}}
    \Put(100,2){\line(0,-1){32}}
    \Put(100,34){\line(1,0){51}}
    \Put(151,34){\line(0,-1){44}}
    
    \thinlines
    \Put(0,7){\dashbox{.5}(100,5)[l]{\scriptsize\hspace{1mm}\kanastr}}
    \Put(0,24){\line(1,0){100}}
    \Put(1,8){\makebox(0,0)[tl]{\scriptsize\namestr}}

    \if@foreign
      \if@nokanji
	\Put(1,29){\makebox(42,16)[tr]{\LARGE\@forenameForeign\hspace{12pt}}}
	\Put(1,7){\makebox(42,5)[r]{\scriptsize\kana@surnameForeign\hspace{12pt}}}
	\Put(42,29){\makebox(42,16)[tl]{\LARGE\hspace{12pt}\@surnameForeign}}
	\Put(42,7){\makebox(42,5)[l]{\scriptsize\hspace{12pt}\kana@forenameForeign}}
      \else
	\Put(1,19){\makebox(42,16)[r]{\LARGE\@surname\hspace{12pt}}}
	\Put(1,25){\makebox(42,16)[r]{\scriptsize\kana@surnameForeign\hspace{12pt}}}
	\Put(1,35){\makebox(42,16)[tr]{\@forenameForeign\hspace{12pt}}}
	\Put(1,7){\makebox(42,5)[r]{\scriptsize\kana@surname\hspace{12pt}}}
	\Put(42,19){\makebox(42,16)[l]{\LARGE\hspace{12pt}\@forename}}
	\Put(42,25){\makebox(42,16)[l]{\hspace{12pt}\scriptsize\kana@forenameForeign}}
	\Put(42,35){\makebox(42,16)[tl]{\hspace{12pt}\@surnameForeign}}
	\Put(42,7){\makebox(42,5)[l]{\scriptsize\hspace{12pt}\kana@forename}}
      \fi
    \else
      \Put(1,24){\makebox(42,16)[r]{\LARGE\@surname\hspace{12pt}}}
      \Put(1,7){\makebox(42,5)[r]{\scriptsize\kana@surname\hspace{12pt}}}
      \Put(42,24){\makebox(42,16)[l]{\LARGE\hspace{12pt}\@forename}}
      \Put(42,7){\makebox(42,5)[l]{\scriptsize\hspace{12pt}\kana@forename}}
    \fi

    \Put(87,2){\line(0,-1){22}}
    \Put(88,24){\makebox(12,16)[tl]{\tiny 印}}
    \if@stamp
      \Put(89,22){\includegraphics[width=9.5mm]{stamp}}
    \fi

    \Put(88,7){\makebox(12,5)[c]{\scriptsize\genderstr\hskip 1ex\@gender}}

    \Put(0,34){\makebox(100,10)[l]{\scriptsize\hspace{1ex}\birthdaystr}}
    \Put(0,34){\makebox(100,10)[r]{\@birthday\hskip 2em
	       (満\hbox to 2em{\hfil\@age\hfil}歳)\hspace{1em}}}
    \Put(0,34){\line(1,0){100}}

    % Addresses
    \Put(0,39){\dashbox{.5}(151,5)[l]{\hspace{1mm}\scriptsize\kanastr}}
    \Put(20,38){\makebox(0,0)[lb]{\scriptsize\kana@address}}
    \Put(1,40){\makebox(0,0)[tl]{\scriptsize\addressstr}}
    \Put(12,40){\makebox(0,0)[lt]{\small 〒 \@postalcode}}
    \Put(20,48){\makebox(148,5)[lb]{\@address}}
    \Put(0,50){\line(1,0){151}}
    \Put(1,51){\makebox(0,0)[tl]{\scriptsize\contactstr}}
    \Put(5,56){\makebox(151,6)[l]{\small\@phone\@email\@github}}
    \Put(0,56){\line(1,0){151}}
    \Put(0,61){\dashbox{.5}(151,5)[l]{\hspace{1mm}\scriptsize\kanastr}}
    \Put(20,61){\makebox(0,5)[l]{\scriptsize\kana@otheraddress}}
    \Put(1,62){\makebox(0,0)[tl]{\scriptsize\otheraddressstr}}
    \Put(12,62){\makebox(0,0)[lt]{\small 〒 \@otherpostalcode}}
    \Put(20,70){\makebox(151,8)[lb]{\@otheraddress}}
    \Put(0,72){\line(1,0){151}}
    \Put(1,78){\makebox(0,5)[tl]{\scriptsize\contactstr}}
    \Put(5,78){\makebox(151,6)[l]{\small\@otherphone}}

    % Background and work experience
    \MoveTo(0,79)
    \thicklines
    \Put(0,0){\line(1,0){151}}
    \Put(151,0){\line(0,-1){159}}
    \Put(0,0){\line(0,-1){159}}
    \Put(0,159){\line(1,0){151}}

    \thinlines
    \Put(0,159){\dashbox{.5}(17,159){}}
    \Put(26,0){\line(0,-1){159}}
    \Put(0,5){\line(1,0){151}}
    \Put(0,5){\makebox(17,5)[c]{\scriptsize 年}}
    \Put(17,5){\makebox(9,5)[c]{\scriptsize 月}}
    \Put(26,5){\makebox(125,5)[c]{\scriptsize\backgroundstr}}

    \MultiPut(0,5)(0,7){22}{\line(1,0){151}}
    \@starttoc{lob} % list of background
    \@starttoc{loc} % list of career

    % Finish
    MoveTo(0, 0)
    \@firstpagehook
  \end{picture}
  \clearpage
  \begin{picture}(\pic@width, \pic@height)
    \MoveTo(0,0)
    \thicklines
    \Put(0,0){\line(1,0){151}}
    \Put(0,0){\line(0,-1){224}}
    \Put(151,0){\line(0,-1){224}}
    \Put(0,224){\line(1,0){151}}

    \Put(0,75){\line(1,0){151}}
    \Put(0,164){\line(1,0){151}}
    \Put(0,194){\line(1,0){151}}
    \Put(0,203){\line(1,0){151}}

    % Creds
    \MoveTo(0,0)
    \thinlines
    \Put(0,75){\dashbox{.5}(17,75){}}
    \Put(26,0){\line(0,-1){75}}
    \Put(0,5){\makebox(17,5)[c]{\scriptsize 年}}
    \Put(17,5){\makebox(9,5)[c]{\scriptsize 月}}
    \Put(26,5){\makebox(125,5)[c]{\scriptsize\licensestr}}
    \Put(0,5){\line(1,0){151}}

    \MultiPut(0,5)(0,7){10}{\line(1,0){151}}
    \@starttoc{lol} % list of licenses

    % Subjects
    \Put(75,75){\line(0,-1){56}}
    \Put(1,103){\makebox(75,27)[lt]{\scriptsize\subjectsstr}}
    \Put(1,103){\makebox(75,24){\@subjects}}
    % Self-Introduction
    \Put(76,103){\makebox(75,27)[lt]{\scriptsize\selfintrostr}}
    \Put(76,103){\makebox(75,24){\@selfintro}}
    \Put(0,103){\line(1,0){151}}
    % Hobbies
    \Put(1,131){\makebox(75,27)[lt]{\scriptsize\hobbiesstr}}
    \Put(1,131){\makebox(75,24){\@hobbies}}
    % strengths
    \Put(76,131){\makebox(75,27)[lt]{\scriptsize\strengthsstr}}
    \Put(76,131){\makebox(75,24){\@strengths}}
    \Put(0,131){\line(1,0){151}}
    % Motive
    \Put(1,162){\makebox(150,30)[lt]{\scriptsize\motivestr}}
    \Put(1,162){\makebox(150,26){\@motive}}
    % Desire
    \Put(1,192){\makebox(150,27)[tl]{\scriptsize\desirestr}}
    \Put(1,192){\makebox(150,24){\@desire}}
    % Commute
    \Put(1,203){\makebox(47,8)[lt]{\scriptsize\commutestr}}
    \Put(1,203){\makebox(45,8)[r]{\@commute}}
    \Put(48,194){\line(0,-1){9}}
    % Dependents
    \Put(49,203){\makebox(34,8)[lt]{\scriptsize\dependentsstr}}
    \Put(49,203){\makebox(30,8)[r]{\@dependents}}
    \Put(84,194){\line(0,-1){9}}
    % Spouse
    \Put(85,203){\makebox(33,8)[lt]{\scriptsize\spousestr}}
    \Put(85,203){\makebox(29,8)[r]{\@spouse}}
    \Put(116,194){\line(0,-1){9}}
    % Spouse dependence
    \Put(117,203){\makebox(34,8)[lt]{\scriptsize\spousedependencestr}}
    \Put(117,203){\makebox(30,8)[r]{\@spousedependence}}
    % Guardian
    \Put(0,212){\dashbox{.5}(151,9){}}
    \Put(1,212){\makebox(124,8)[lt]{\scriptsize\guardianstr}}
    \Put(1,212){\makebox(124,5)[l]{\scriptsize\kanastr}}
    \Put(35,212){\line(0,-1){12}}
    \Put(1,224){\makebox(34,11)[lt]{\scriptsize\namestr}}
    \Put(16,212){\makebox(0,5)[l]{\scriptsize\kana@guardian}}
    \Put(1,224){\makebox(34,12)[c]{\@guardian}}
    \Put(36,224){\makebox(89,11)[lt]{\small 〒 \@guardianpostalcode}}
    \Put(48,212){\makebox(77,5)[l]{\scriptsize\kana@guardianaddress}}
    \Put(36,224){\makebox(89,8)[c]{\@guardianaddress}}
    \Put(150,224){\makebox(0,11)[rt]{\scriptsize\@guardianphone}}

    % Finish
    MoveTo(0, 0)
    \@secondpagehook
  \end{picture}
}

\newcommand{\AtFirstPage}{\g@addto@macro\@firstpagehook}
\newcommand{\AtSecondPage}{\g@addto@macro\@secondpagehook}

%%再生紙
\newcommand{\recycled}{%
  \if@twoside
    \AtFirstPage{\Put(150,225){\makebox(0,0)[rt]{\scriptsize 
      この用紙には再生紙を利用しています。}}}
  \fi
  \AtSecondPage{\Put(150,225){\makebox(0,0)[rt]{\scriptsize 
    この用紙には再生紙を利用しています。}}}
}

\newcommand{\surname}[2] {
  \gdef\@surname{#1}
  \gdef\kana@surname{#2}
}
\newcommand{\forename}[2] {
  \gdef\@forename{#1}
  \gdef\kana@forename{#2}
}

\newcommand{\surnameForeign}[2] {
  \gdef\@surnameForeign{#1}
  \gdef\kana@surnameForeign{#2}
}
\newcommand{\forenameForeign}[2] {
  \gdef\@forenameForeign{#1}
  \gdef\kana@forenameForeign{#2}
}

\newcommand{\address}[2] {
  \gdef\@address{#1}
  \gdef\kana@address{#2}
}

\newcommand{\postalcode}[1]{\gdef\@postalcode{\texttt{#1}}}
\newcommand{\phone}[1]{\gdef\@phone{\hskip 24pt 電話: \texttt{#1}}}
\newcommand{\email}[1]{\gdef\@email{\hskip 24pt メール: \texttt{\href{mailto:#1}{#1}}}}
\newcommand{\github}[1]{\gdef\@github{\hskip 24pt GitHub: \texttt{\href{https://github.com/#1}{#1}}}}

\newcommand{\otheraddress}[2] {
  \gdef\@otheraddress{#1}
  \gdef\kana@otheraddress{#2}
}

\newcommand{\otherpostalcode}[1]{\gdef\@otherpostalcode{\texttt{#1}}}
\newcommand{\otherphone}[1]{\gdef\@otherphone{\hskip 24pt 電話: \texttt{#1}}}

\newcounter{agecounter}
\newcommand{\birthday}[3]{
  \gdef\@birthday{\DTMdisplaydate{#1}{#2}{#3}生}
  \setcounter{agecounter}{\year}
  \addtocounter{agecounter}{-#1}
  \ifnum\month = #2
    \ifnum\day < #3
      \addtocounter{agecounter}{-1}
    \fi
  \else
    \ifnum\month < #2
      \addtocounter{agecounter}{-1}
    \fi
  \fi
}

\newcommand{\@age}{\expandafter\theagecounter}

\newcommand{\gender}[1]{\gdef\@gender{#1}}
\newcommand{\subjects}[1]{\long\gdef\@subjects{\parbox{72mm}{#1}}}
\newcommand{\selfintro}[1]{\long\gdef\@selfintro{\parbox{72mm}{#1}}}
\newcommand{\hobbies}[1]{\long\gdef\@hobbies{\parbox{72mm}{#1}}}
\newcommand{\strengths}[1]{\long\gdef\@strengths{\parbox{72mm}{#1}}}
\newcommand{\motive}[1]{\long\gdef\@motive{\parbox{144mm}{#1}}}
\newcommand{\desire}[1]{\long\gdef\@desire{\parbox{144mm}{#1}}}
\newcommand{\commute}[1]{\gdef\@commute{#1}}
\newcommand{\dependents}[1]{\gdef\@dependents{#1}}
\newcommand{\spouse}[1]{\gdef\@spouse{#1}}
\newcommand{\spousedependence}[1]{\gdef\@spousedependence{#1}}

\newcommand{\guardian}[2] {
  \gdef\@guardian{#1}
  \gdef\kana@guardian{#2}
}
\newcommand{\guardianaddress}[2] {
  \gdef\@aguardianddress{#1}
  \gdef\kana@aguardianddress{#2}
}
\newcommand{\guardianphone}[1]{\gdef\@guardianphone{\hskip 24pt 電話: \texttt{#1}}}

% List output command
\newcommand{\PutListEntry}[4]{
  \Put(0,#1){\makebox(17,7)[c]{#2}}
  \Put(17,#1){\makebox(9,7)[c]{#3}}
  \Put(28,#1){\makebox(121,7)[l]{#4}}
}

% Add to academic list
\newcounter{@b}\setcounter{@b}{5}
\newcommand{\background}[3]{%
  \addtocounter{@b}{7}
  \addtocontents{lob}{\protect\PutListEntry{\the@b}{\era[#1]}{#2}{#3}}
}
\newif{\if@bglastnewline}
\@bglastnewlinefalse
\newcommand{\BackgroundLastNewLine}{\@bglastnewlinetrue}

% Add to work experience list
\newcounter{@c}\setcounter{@c}{0}
\newif\if@career
\@careertrue
\newcommand{\career}[3]{%
  \@careerfalse
  \addtocounter{@c}{7}
  \addtocontents{loc}{\protect\PutListEntry{\the@c}{\era[#1]}{#2}{#3}}
}

% Add to certs list
\newcounter{@l}\setcounter{@l}{5}
\newcommand{\license}[3]{%
  \addtocounter{@l}{7}
  \addtocontents{lol}{\protect\PutListEntry{\the@l}{\era[#1]}{#2}{#3}}
}

% Strings
\newcommand{\resumestr}{履~~歴~~書}
\newcommand{\namestr}{氏~~名}
\newcommand{\kanastr}{ふりがな}
\newcommand{\addressstr}{現~住~所}
\newcommand{\otheraddressstr}{連~絡~先}
\newcommand{\contactstr}{電話など}
\newcommand{\birthdaystr}{生年月日}
\newcommand{\genderstr}{性別}
\newcommand{\backgroundstr}{学歴・職歴}
\newcommand{\licensestr}{免許・資格}
\newcommand{\subjectsstr}{得意な科目・分野}
\newcommand{\selfintrostr}{自己分析（性格・特徴・PR など）}
\newcommand{\hobbiesstr}{趣味・スポーツ・サークルなど}
\newcommand{\strengthsstr}{特技など}
\newcommand{\motivestr}{志望の動機}
\newcommand{\desirestr}{本人希望記入欄（特に給料・職種・勤務時間・勤務地・
  その他についての希望などがあれば記入）}
\newcommand{\guardianstr}{保護者 (本人が未成年の場合のみ記入)}
\newcommand{\commutestr}{通勤時間}
\newcommand{\dependentsstr}{扶養家族数}
\newcommand{\spousestr}{配偶者}
\newcommand{\spousedependencestr}{配偶者の扶養義務}

\AtBeginDocument{\pagestyle{empty}}
\AtBeginDocument{\background{}{}{\textbf{\hfil 学歴}}}
\AtBeginDocument{\career{}{}{\textbf{\hfil 職歴}}\@careertrue}

\AtEndDocument{\if@bglastnewline\background{}{}{}\fi}
\AtEndDocument{\addtocontents{lob}{\protect\RMoveTo(0,\the@b)}}
\AtEndDocument{\if@career\career{}{}{なし}\fi}
\AtEndDocument{\career{}{}{\hfill 以上\hspace{2em}}}
\AtEndDocument{\addtocontents{loc}{\protect\RMoveTo(0,-\the@b)}}
\AtEndDocument{\@makerireki}

\endinput
