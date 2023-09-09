using Plots
using DifferentialEquations

const g1 = 0;    # Параметр, характеризующий потери в системе
const g2 = 0.9;
const g3 = g2;
const w1 = 5.1;   #Собственная частота колебаний
const w2 = 2.0;
const w3 = 1.9;  

# u[1] - x, u[2] - y, где x - координата колебаний, y - скорость колебаний, du[1]=dx/dt, du[2]=dy/dt
function lorenz1!(du,u,p,t)  # Модель колебаний без затуханий
    du[1] = u[2]
    du[2] = -w1*u[1] - g1*du[1]
end

function lorenz2!(du,u,p,t)  # Модель колебаний с затуханиями
    du[1] = u[2]
    du[2] = -w2*u[1] - g2*du[1]
end

function lorenz3!(du,u,p,t)  # Модель колебаний с затуханиями под действием внешней силы
    du[1] = u[2]
    du[2] = -w3*u[1] - g3*du[1] + 3.3*cos(5*t)
end

const u0 = [0.9, -1.9]
const T = [0.0, 38.0]

prob1 = ODEProblem(lorenz1!, u0, T)
prob2 = ODEProblem(lorenz2!, u0, T)
prob3 = ODEProblem(lorenz3!, u0, T)

sol1 = solve(
    prob1,
    saveat = 0.05)
    #abstol=1e-8,
    #reltol=1e-8)

sol2 = solve(
    prob2,
    saveat = 0.05)
    #abstol=1e-8,
    #reltol=1e-8)

sol3 = solve(
    prob3,
    saveat = 0.05)
    #abstol=1e-8,
    #reltol=1e-8)
y1_max = maximum(sol1.u[2])
y2_max = maximum(sol2.u[2])
y3_max = maximum(sol3.u[2])

plt1 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt1,
    sol1,
    idxs=(1,2),
    label="Фазовый портрет гармонического осциллятора без затуханий",
    xlabel="Координата",
    ylabel="Скорость колебаний",
    ylims = (u0[2]-1, y1_max + 3),
    #yscale =:identity,
    #yticks = 0:20500:205000, 
    #xticks = 0:0.2:2,
    #formatter=:plain,
    legend_position=:topright,
    titlefontsize=:10,
    color=:red,
    title="Модель гармонического осциллятора без затуханий")
           
plt2 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt2,
    sol2,
    idxs=(1,2),
    label="Фазовый портрет гармонического осциллятора с затуханиями",
    xlabel="Координата",
    ylabel="Скорость колебаний",
    ylims = (u0[2] - 0.5, y2_max),
    #yscale =:identity,
    #yticks = 0:20500:205000, 
    #xticks = 0:0.2:2,
    #formatter=:plain,
    legend_position=:bottomleft,
    legend_font_pointsize=:7,
    titlefontsize=:10,
    color=:blue,
    title="Модель гармонического осциллятора с затуханиями")

plt3 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt3,
    sol3,
    idxs=(1,2),
    label="Фазовый портрет гармонического осциллятора с затуханиями под действием внешней силы",
    xlabel="Координата",
    ylabel="Скорость колебаний",
    ylims = (u0[2] - 0.5, y3_max + 1),
    #yscale =:identity,
    #yticks = 0:20500:205000, 
    #xticks = 0:0.2:2,
    #formatter=:plain,
    legend_position=:bottomleft,
    legend_font_pointsize=:6,
    titlefontsize=:8,
    color=:green,
    title="Модель гармонического осциллятора с затуханиями под действием внешней силы")

savefig(plt1, "image/lab04_1.png")
savefig(plt2, "image/lab04_2.png")
savefig(plt3, "image/lab04_3.png")