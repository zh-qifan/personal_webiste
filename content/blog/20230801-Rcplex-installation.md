---
author: Qifan
title: Rcplex Installation
date: "2023-08-02"
description: "In this blog, I will introduce how to install Rcplex on Windows."
math: false
comments: true
tags: 
  - "R"
  - "technical-issues"
---

I need to install Rcplex recently to replicate the results of one paper. However, the direct use of *install.packages("Rcplex")* did not work on Windows. In this article, I will introduce how to successfully install Rcplex on your Windows.

**Step 1** Get your cplex source file on https://www.ibm.com/products/ilog-cplex-optimization-studio. Let's say you install the Cplex Studio at D:/Cplex Studio/;

**Step 2** Download the Rcplex .gz package on https://cran.r-project.org/web/packages/Rcplex/index.html and unzip it to D:/Rcplex/;

**Step 3** Open the src/Makevars.win and modify it to 

<!-- markdownlint-disable MD033 -->
<pre class="line-numbers language-none" data-start="1">
  <code>
CPLEX_DIR="D:/Cplex Studio/cplex"
ifeq "$(WIN)" "64"
PKG_LIBS = -L"${CPLEX_DIR}/bin/x64_win64" -lcplex1263 -lm
PKG_CPPFLAGS = -D_LP64 -I"${CPLEX_DIR}/include" -DBUILD_CPXSTATIC
else
PKG_LIBS = -L"${CPLEX_DIR}/bin/x86_win32" -lcplex1263 -lm
PKG_CPPFLAGS = -I"${CPLEX_DIR}/include"
endif
  </code>
</pre>
<!-- markdownlint-enable MD033 -->

**Step 4** Open the src/Rcplex_QCP.c and comment the lines 4-8. (Because the variables are defined in another .c file.)

<!-- markdownlint-disable MD033 -->
<pre class="line-numbers language-clike" data-start="1">
  <code>
// The actual solving procedure is called using the function Rcplex 
#include "Rcplex.h"

//CPXENVptr env;
//CPXLPptr lp;
//int numcalls;
//int max_numcalls;
//int forceCplxClose;
  </code>
</pre>
<!-- markdownlint-enable MD033 -->

**Step 5** run the following commands on your terminal.

<!-- markdownlint-disable MD033 -->
<pre class="command-line language-clike" data-start="1">
  <code>
R CMD build --no-build-vignettes --no-manual --md5 D:/Rcplex
R CMD INSTALL --build --no-multiarch D:/Rcplex_{version}.tar.gz
  </code>
</pre>
<!-- markdownlint-enable MD033 -->

**Step 6** Now theoretically you should have Rcplex successfully installed. Check with *library(Rcplex)*! (It may need you to install slam first.)