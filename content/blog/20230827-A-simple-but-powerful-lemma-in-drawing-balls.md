---
author: Qifan
title: A Simple but Powerful Lemma in Drawing balls from bags
date: "2023-08-28"
description: "This blog is about a lemma I found useful in calculating probability in ball-drawing problems."
math: true
comments: true
tags: 
  - "probability"
---

Consider such a problem that bag A has $a$ white balls and $b$ black balls and bag B has $\alpha$ white balls and $\beta$ black balls. Now draw $c(c\leq a+b)$ balls from the bag A to the bag B. Then what is the probability that drawing a white ball from the bag B?

To solve this problem, one can directly calculate the probability using the law of total probability. In the calculation, one will find an interesting fact which I summarize as a lemma below. 

> Consider a bag of $N$ balls where some are white and some are black. If the number of white balls is a random variable $X$, the probability of drawing a white ball is $\mathbb{E}[X]/N$.

Simple and intuitive! The proof for this lemma is direct if using law of total probability. Now let's reconsider the problem. Note that the expected number of white balls drew from bag A is $ca/(a+b)$. Thus the required probability is $(\alpha + ca/(a+b))/(\alpha+\beta+c)$. This is just a one line calculation! 

Now let's consider a more complicated problem. We still consider the bag A and B but now we draw one ball from each bag and exchange them. After $n$ draws, what is the probability that drawing a white ball from the bag A?

Obviously, we are unsure about the number of white balls in the bag A after $n$ draws. Then let's say it is a random variables $X_n$ and similarly $Y_n$ is the number of white balls in bag B after $n$ draws. Thus we have a relationship between them  
$$
X_n + Y_n = a + \alpha.
$$
Note that if we let $\xi_n$ and $\eta_n$ be the number of white balls drew from the bag A and B in the $n$th draw, we have
$$
X_n = X_{n-1} + \eta_n - \xi_n.
$$
Since $\xi_n$ and $\eta_n$ can only be 0 or 1, the probability that they equals to 1 has the same value as their expectations. This is where our lemma can play a role! $\rightarrow\ \mathbb{E}[\xi_n] = \mathbb{E}[X_{n-1}]/(a+b)$ and $\mathbb{E}[\eta_n] = \mathbb{E}[Y_{n-1}]/(\alpha+\beta)$. Then one can derive the final recursion equation, solving which will give the final answer
$$
\mathbb{E}[X_n] = \mathbb{E}[X_{n-1}] + \frac{a+\alpha-\mathbb{E}[X_{n-1}]}{\alpha+\beta} - \frac{\mathbb{E}[X_{n-1}]}{a+b}.
$$

Use this lemma in your probability problem set and it will guarantee very fast computation!
