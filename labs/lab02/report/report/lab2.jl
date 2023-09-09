using Plots
using DifferentialEquations

const θ01 = 0
const θ02 = -π
const r01 = 11.8/5.2
const r02 = 11.8/3.2
const T1 = (θ01, 2π)
const T2 = (θ02, π)
const ϕ = π/4

function F(u, p, t)
    return u/√(16.64)
end

prob1 = ODEProblem(F, r01, T1)
prob2 = ODEProblem(F, r02, T2)

sol1 = solve(
  prob1,
  abstol=1e-16,
  reltol=1e-16)
sol2 = solve(
    prob2,
    abstol=1e-16,
    reltol=1e-16)

plt1 = plot(
    proj = :polar,
    aspect_ratio=:equal,
    dpi=300,
    legend=true)

plot!(
    plt1,
    sol1.t,
    sol1.u,
    xlabel="θ",
    ylabel="r(θ)",
    label="Траектория катера",
    color=:red,
    title="Катер с бандитами")
plot!(
    plt1, 
    fill(ϕ,11), 
    collect(0:10), 
    label="Траектория движения лодки", 
    color=:blue)         
    
plt2 = plot(
    proj = :polar,
    aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt2,
    sol2.t,
    sol2.u,
    xlabel="θ",
    ylabel="r(θ)",
    label="Траектория катера",
    color=:red,
    title="Катер с бандитами")
plot!(
    plt2, 
    fill(ϕ,11), 
    collect(0:10), 
    label="Траектория движения лодки", 
    color=:blue)

savefig(plt1, "image/lab02_1.png")
savefig(plt2, "image/lab02_2.png")