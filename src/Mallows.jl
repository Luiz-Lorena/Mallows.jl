module Mallows

    using StatsBase

    export sample_mallows

    """
        sample_mallows(sigma0::Vector{Int}, phi::Float64)

    Samples a permutation from the Mallows model with Kendall's tau distance,
    and also returns the Kendall's tau distance between the sampled permutation and sigma0.
    Parameters:
    - `phi`: The dispersion parameter (0.0 < phi <= 1.0).
    - `sigma0`: The central permutation.
    Returns:
    - `Tuple{Vector{Int}, Int}`:
        - The sampled permutation `sigma`.
        - The Kendall's tau distance `d(sigma, sigma0)`.
    """
    function sample_mallows(sigma0::Vector{Int}, phi::Float64)
        
        # Size of permutation
        n::Int = length(sigma0)
        
        # 1. Parameter validation
        if !(0.0 < phi <= 1.0)
            error("phi must be in (0,1]")
        end
        if n == 0
            if isempty(sigma0)
                return Int[], 0
            else
                error("sigma0 must be empty for n=0, but got length $(length(sigma0))")
            end
        end
        if length(sigma0) != n
            error("sigma0 must be a permutation of 1:$n, so its length must be $n. Got $(length(sigma0)).")
        end

        # 2. Precompute powers of phi
        phi_powers = Vector{Float64}(undef, n)
        if n > 0
            phi_powers[1] = 1.0 # phi^0
            for i in 2:n
                phi_powers[i] = phi_powers[i-1] * phi
            end
        end

        # 3. Build pi_prime and calculate Kendall distance to identity
        pi_prime_building = Vector{Int}(undef, n)
        kendall_distance_pi_prime_identity = 0

        # Loop for k_loop_var (item being inserted, also number of current insertion slots)
        for k_loop_var in 1:n
            if k_loop_var == 1
                if n > 0; pi_prime_building[1] = 1; end
                continue
            end

            current_probs_view = view(phi_powers, 1:k_loop_var)
            
            sum_val = 0.0
            if phi == 1.0
                sum_val = Float64(k_loop_var)
            else
                phi_to_the_k_power = 0.0
                if n == 0 
                    phi_to_the_k_power = 1.0 
                elseif k_loop_var == n 
                    phi_to_the_k_power = (n > 0 ? phi_powers[n] * phi : 1.0)
                else # k_loop_var < n
                    phi_to_the_k_power = (n > 0 ? phi_powers[k_loop_var+1] : 1.0)
                end
                sum_val = (1.0 - phi_to_the_k_power) / (1.0 - phi)
            end
            
            weights = if sum_val <= 1e-9 || !isfinite(sum_val) # Check for very small or non-finite sum_val
                # Fallback: copy view to vector for StatsBase.Weights to compute sum
                StatsBase.Weights(Vector(current_probs_view)) 
            else
                StatsBase.Weights(current_probs_view, sum_val)
            end

            chosen_idx_in_probs_vec = StatsBase.sample(1:k_loop_var, weights)
            j_elements_to_right = chosen_idx_in_probs_vec - 1
            kendall_distance_pi_prime_identity += j_elements_to_right

            insertion_idx = (k_loop_var - 1) - j_elements_to_right + 1
            
            if n > 0
                for l in (k_loop_var-1):-1:insertion_idx
                    pi_prime_building[l+1] = pi_prime_building[l]
                end
                pi_prime_building[insertion_idx] = k_loop_var
            end
        end

        sampled_perm = n > 0 ? sigma0[pi_prime_building] : Int[]
        return sampled_perm, kendall_distance_pi_prime_identity
    end

end