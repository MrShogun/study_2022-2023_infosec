using Plots
using DifferentialEquations

const N = 11600;    # Число проживающих на острове
const I0 = 260;  # Число изначально заболевших
const R0 = 48;   # Число здоровых с иммунитетом
const S0 = N - I0 - R0;   # Число здоровых, но восприимчивых к болезни
const α = 0.01; # Коэффициент заболеваемости
const β = 0.02; # Коэффициент выздоровления

# u[1] - S(t), u[2] - I(t), u[3] - R(t), 
#где S - Число здоровых, но восприимчивых к болезни, 
#I - Число заболевших, R - число выздоровевших (при этом приобретая иммунитет) 
#du[1]=dS/dt, du[2]=dI/dt, du[3]=dR/dt
"Модель эпидемии при I(0) <= I*"
function lorenz1!(du,u,p,t)
    du[1] = 0
    du[2] = -β*u[2]
    du[3] = β*u[2]
end
"Модель эпидемии при I(0) > I*"
function lorenz2!(du,u,p,t)
    du[1] = -α*u[1]
    du[2] = α*u[1] - β*u[2]
    du[3] = β*u[2]
end

const u0 = [S0, I0, R0]
const T = [0.0, 100.0]
const T2 = [0.0, 500.0]

prob1 = ODEProblem(lorenz1!, u0, T)
prob2 = ODEProblem(lorenz2!, u0, T2)

sol1 = solve(
    prob1,
    #saveat = 0.05)
    abstol=1e-8,
    reltol=1e-8)
sol2 = solve(
    prob2,
    #saveat = 0.05)
    abstol=1e-8,
    reltol=1e-8)

#y1_max = maximum(sol1.u[2])
#y2_max = maximum(sol2.u[2])
#y3_max = maximum(sol3.u[2])

plt1 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt1,
    sol1,
    idxs=(0,1),
    label="Число здоровых, но восприимчивых к болезни",
    xlabel="Время с начала эпидемии",
    ylabel="Число людей",
    #ylims = (u0[2]-1, y1_max + 3),
    #yscale =:identity,
    yticks = 0:1160:11600, 
    #xticks = 0:0.2:2,
    formatter=:plain,
    legend_position=:topright,
    titlefontsize=:14,
    legend_font_pointsize=:6,
    color=:blue,
    title="Модель эпидемии при I(0) <= I*")
plot!(
    plt1,
    sol1,
    idxs=(0,2),
    label="Число заболевших",
    #ylims = (u0[2] - 0.5, y2_max),
    #yscale =:identity,
    #yticks = 0:20500:205000, 
    color=:red)
plot!(
    plt1,
    sol1,
    idxs=(0,3),
    label="Число выздоровевших и обретших иммунитет", 
    color=:green)

plt2 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt2,
    sol2,
    idxs=(0,1),
    label="Число здоровых, но восприимчивых к болезни",
    xlabel="Время с начала эпидемии",
    ylabel="Число людей",
    #ylims = (u0[2]-1, y1_max + 3),
    #yscale =:identity,
    yticks = 0:1160:11600, 
    #xticks = 0:0.2:2,
    formatter=:plain,
    legend_position=:topright,
    titlefontsize=:14,
    legend_font_pointsize=:6,
    color=:blue,
    title="Модель эпидемии при I(0) > I*")
plot!(
    plt2,
    sol2,
    idxs=(0,2),
    label="Число заболевших",
    #ylims = (u0[2] - 0.5, y2_max),
    #yscale =:identity,
    #yticks = 0:20500:205000, 
    color=:red)
plot!(
    plt2,
    sol2,
    idxs=(0,3),
    label="Число выздоровевших и обретших иммунитет", 
    color=:green)

savefig(plt1, "image/lab06_1.png")
savefig(plt2, "image/lab06_2.png")