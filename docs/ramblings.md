# Event studies with overlapping treatment windows

#### Contents:

1. Introduce the Deryugina et al. estimatino set-up
2. Write down a simple probability model that justifies this set up
   1. Explain how it differs from the standard DiD / event study set up
3. See if it is possible to fit multiple treatments for the same unit into the standard IID model
   1. What assumptions are required to allow for consistent and unbiased estimatoin? 
   2. How do the aymptotics work? What are the exact assumptions required 
4. Extensions:
   1. is it possilbe to relax the 'no anticipation effects' assumption
5. Fully parametrics GMM inference? 
   1. For example, esing an explicit probability model for the hurricane probability? 
   2. And have an explicit utility maximisation framework, that pops out a functional form for the impact of an unexpected shock?

## Introduce the set up 

Some recent papers in applied Climate Econometrics use event studies to analyse the economic and social impacts of hurricanes **{add citations}.**

A common way to implement such a strategy is to run a two-way fixed effects estimator, which includes spatial and temporal fixed effects. Then, the impacts of an extreme weather event can be identied if we assume that conditional on the included fixed effects, unobserved factors that affect the relationship between hurricanes and outcomes are as good as randomly assigned. 

To fix ideas, lets consider this set up in the case of Deryungina et al.'s recent NBER working paper. 
$$
y_{it} = \sum_{-4 \leq j \leq 12, j \neq 2} \beta_j H_{t - j} + \gamma_t + \alpha_j + \varepsilon_{it}
$$
Let $\beta = (\beta_{-4}, ...\beta_{12})$. The identification assumption in this model is that:
$$
\begin{equation}

E(\varepsilon_{it} \cdot \beta) = 0

\end{equation}
$$
But, why might we expect this to be the case? In the case of hurricanes, papers exploit the timing and location of hurricanes contains some meterological randomness. If we estimate the model on a sample of observations in which all counties could have been hit by hurricanes, then the argument in the applied literature **{more to add!!}**

For now, lets run with this argument, and assume that conditoinal on our 

