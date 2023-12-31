---
author: Qifan
title: When Uncertainty Meets Uncertainty
date: "2023-08-27"
math: true
comments: true
draft: true
tags: 
  - "probability"
  - "statistics"
---

In this blog, I would like to make a comparison between Binomial and Beta-binomial distribution to understand how the uncertainty in parameters affects probability distribution. I need to point out the Bayesian approach can not completely bypass the existance of parameters (or there will be no more statisticians in this world!) and it may even bring more. But it can provide us with an intuition about how the uncertainty in parameters affects the original distribution. 

{{< video src="comparison_video_alpha_beta" autoplay="true" controls="false" loop="true" caption="Video. (1)">}}

<!--more-->

Consider a general parametric distribution $X\sim F(x|\theta)$ and the priori of the parameters $\theta\sim \pi(\theta|\alpha)$. Then by simple calculation, we can cancel out $\theta$ and derive another distribution $F(x|\alpha)=\int F(x|\theta)\pi(\theta|\alpha)d\theta$. For example, if we consider a binomial distribution with $p\sim\beta(\alpha,\beta)$, its resulting marginal distribution is beta-binomial distribution, which has pdf
$$
\Pr(X=k) = {n \choose k }\frac{\beta(x+\alpha,n-x+\beta)}{\beta(\alpha,\beta)}.
$$
Then the uncertainty of the parameter $p$ is described by another two parameters $\alpha$ and $\beta$. To understand how the uncertainty of $p$ affects the original binomial distribution, we can do a simple simulation. First, note that the mean of beta-binomial distribution is $n\alpha/(\alpha+\beta)$ and to fix the mean of both beta-binomial and binomial, we change $\alpha$ and $\beta$ with the same rate and let $p=\alpha/(\alpha+\beta)$. Video. (1) indicates that as $\alpha$ and $\beta$ increase, the variance of $p$ decrease and thus the beta-binomial is more similar to binomial. Also, we can find that beta-binomial is more flat than blinomial, which means that we are less likely to assign high probability to any point. It aligns well with our intuition. This can also be reflected by the variance of two distribution, where binomial has $np(1-p)$ and beta-binomial has $np(1-p)(\alpha+\beta+n)/(\alpha+\beta+1)$. The extra $(\alpha+\beta+n)/(\alpha+\beta+1)$ is the description of additional uncertainty brought by $p$. Similarly, we can fix one of $\alpha$ and $\beta$ and see what will happen.

{{< video src="comparison_video_beta" autoplay="true" controls="false" loop="true" caption="Video. (2)">}}

{{< video src="comparison_video_alpha" autoplay="true" controls="false" loop="true" caption="Video. (3)">}}

From the above two videos, we can also see how $\alpha$ and $\beta$ controls the shape of beta distribution.

We can also do analysis for Gamma-Poisson and Gamma-Gaussian distribution but the approach is similar. The code generating the video in this blog can be found at [this repo](https://github.com/zh-qifan/zh-qifan.github.io/tree/main/code/R).