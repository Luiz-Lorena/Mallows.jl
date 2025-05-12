using Mallows
using Random
using Test

@testset "Mallows.jl" begin
    # Example test case
    Random.seed!(42)
    sigma0 = [1, 2, 3, 4, 5]
    phi = 0.5
    sampled_permutation, kendall_distance = sample_mallows(sigma0, phi)
    n = length(sigma0)
    @test length(sampled_permutation) == n
    @test sampled_permutation == [1, 2, 3, 5, 4]
    @test sampled_permutation != [1, 2, 3, 4, 5]
    @test kendall_distance >= 0
    @test kendall_distance <= n * (n - 1) / 2    
end