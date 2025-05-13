<div align="center">
<picture>
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/Luiz-Lorena/Mallows.jl/raw/master/docs/src/assets/logo.svg">
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Luiz-Lorena/Mallows.jl/raw/master/docs/src/assets/logo-dark.svg">
  <img alt="Mallows.jl logo." src="https://github.com/Luiz-Lorena/Mallows.jl/raw/master/docs/src/assets/logo.svg" height="150">
</picture>
  <h1>Mallows</h1>
</div>

<div align="center">
  *Sampling from a Mallows Distribution in Julia.*
</div>

<br>

<div align="center">

<!-- Markdown table inside HTML wrapper -->
  
<table>
  <thead>
    <tr>
      <th>Documentation</th>
      <th>Build Status</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <a href="https://luiz-lorena.github.io/Mallows.jl/stable/">
          <img src="https://img.shields.io/badge/docs-stable-blue.svg">
        </a>
        <a href="https://luiz-lorena.github.io/Mallows.jl/dev/">
          <img src="https://img.shields.io/badge/docs-dev-blue.svg">
        </a>
      </td>
      <td>
        <a href="https://github.com/luiz-lorena/Mallows.jl/actions/workflows/CI.yml?query=branch%3Amaster">
          <img src="https://github.com/luiz-lorena/Mallows.jl/actions/workflows/CI.yml/badge.svg?branch=master">
        </a>
      </td>
    </tr>
  </tbody>
</table>

</div>

## Installation

The package can be installed with the Julia package manager.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run:

```
pkg> add https://github.com/Luiz-Lorena/Mallows.jl
```

Or, equivalently, via the `Pkg` API:

```julia
julia> import Pkg; Pkg.add("https://github.com/Luiz-Lorena/Mallows.jl")
```

## Usage

```julia
using Mallows, Random

Random.seed!(42)

sigma0 = [1, 2, 3, 4, 5]
phi = 0.5
sampled_permutation, kendall_distance = sample_mallows(sigma0, phi)

println("Sampled permutation: $sampled_permutation | Distance: $kendall_distance")
```

Output:

```
Sampled permutation: [1, 2, 3, 5, 4] | Distance: 1
```

For the theory behind sampling from a Mallows Distribution please follow the documentation link.

<!--
## Citing Mallows.jl

If you find Mallows.jl useful in your work, we kindly request that you cite the
following paper:

```bibtex
@article{Lubin2023,
    author = {Miles Lubin and Oscar Dowson and Joaquim {Dias Garcia} and Joey Huchette and Beno{\^i}t Legat and Juan Pablo Vielma},
    title = {{JuMP} 1.0: {R}ecent improvements to a modeling language for mathematical optimization},
    journal = {Mathematical Programming Computation},
    volume = {15},
    pages = {581–589},
    year = {2023},
    doi = {10.1007/s12532-023-00239-3}
}
```
-->
