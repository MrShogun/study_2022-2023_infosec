using Plots
using DifferentialEquations

#function F(u, p, t)
#    return u/√(16.64)
#end

function lorenz1!(du,u,p,t)
    du[1] = -0.13*u[1] - 0.51*u[2] + sin(t + 13)/2
    du[2] = -0.41*u[1] - 0.15*u[2] + cos(t + 2)/2
end

function lorenz2!(du,u,p,t)
    du[1] = -0.08*u[1] - 0.76*u[2] + sin(2*t) + 1
    du[2] = -0.64*u[1]*u[2] - 0.07*u[2] + cos(3*t) + 1
end

const u0 = [202000, 92000]
const T1 = (0.0, 2.0)
const T2 = (0.0, 0.0001)

prob1 = ODEProblem(lorenz1!, u0, T1)
prob2 = ODEProblem(lorenz2!, u0, T2)

sol1 = solve(
    prob1,
    abstol=1e-8,
    reltol=1e-8)

sol2 = solve(
    prob2,
    abstol=1e-10,
    reltol=1e-10)

plt1 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt1,
    sol1,
    idxs=(0,1),
    label="Армия X",
    xlabel="Время",
    ylabel="Численность войск",
    ylims = (0, 205000),
    yscale =:identity,
    yticks = 0:20500:205000, 
    xticks = 0:0.2:2,
    formatter=:plain,
    legend_position=:topright,
    titlefontsize=:10,
    color=:red,
    title="Боевые действия между регулярными армиями")
plot!(
    plt1,
    sol1,
    idxs=(0,2),
    label="Армия Y",
    color=:blue)
           
plt2 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt2,
    sol2,
    idxs=(0,1),
    label="Регулярная армия X",
    xlabel="Время",
    ylabel="Численность войск",
    ylims = (0, 205000),
    yscale =:identity,
    yticks = 0:20500:205000, 
    xticks = 0:0.00001:0.0001,
    formatter=:plain,
    legend_position=:topright,
    titlefontsize=:10,
    color=:red,
    title="Боевые действия между регулярной армией и партизанами")
plot!(
    plt2,
    sol2,
    idxs=(0,2),
    label="Партизанская армия Y",
    color=:blue)

savefig(plt1, "image/lab03_1.png")
savefig(plt2, "image/lab03_2.png")