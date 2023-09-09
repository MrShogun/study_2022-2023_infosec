using Plots
using DifferentialEquations

const M1_0 = 8.5; # Оборотные средства предприятия 1 в начале (в млн)
const M2_0 = 9.1; # Оборотные средства предприятия 2 в начале (в млн)
const p_cr = 33; # Критическая стоимость продукта (больше нее отказываются покупать) (в тыс)
const N = 83; # Число потребителей производимого продукта (в тыс)
const q = 1; # максимальная потребность одного человека в продукте в единицу времени
const τ1 = 27; # Длительность производственного цикла на 1 предприятии
const τ2 = 24; # Длительность производственного цикла на 2 предприятии
const p1 = 11.3; # Себестоимость продукта на 1 предприятии (в тыс)
const p2 = 12.5; # Себестоимость продукта на 5 предприятии (в тыс)

a1 = p_cr / (τ1^2 * p1^2 * N * q);
a2 = p_cr / (τ2^2 * p2^2 * N * q);
b = p_cr / (τ1^2 * p1^2 * τ2^2 * p2^2 * N * q);
c1 = (p_cr - p1) / (τ1 * p1);
c2 = (p_cr - p2) / (τ2 * p2);


# u[1] - M1(θ), u[2] - M2(θ), 
#где M - Оборотные средства предприятия, 
# θ = t/c1 - безразмерное время (для нормировки) 
#du[1]=dM1/dθ, du[2]=dM2/dθ
"Модель конкуренции только рыночными методами"
function lorenz1!(du,u,p,t)
    du[1] = u[1] - b*u[1]*u[2]/c1 - a1*u[1]*u[1]/c1
    du[2] = c2*u[2]/c1 - b*u[1]*u[2]/c1 - a2*u[2]*u[2]/c1
end
"Модель конкуренции с рыночными и социально-психологическими факторами"
function lorenz2!(du,u,p,t)
    du[1] = u[1] - (b/c1 + 0.00019)*u[1]*u[2] - a1*u[1]*u[1]/c1
    du[2] = c2*u[2]/c1 - b*u[1]*u[2]/c1 - a2*u[2]*u[2]/c1
end

const u0 = [M1_0, M2_0]
const T1 = [0.0, 40.0]
const T2 = [0.0, 20.0]

prob1 = ODEProblem(lorenz1!, u0, T1)
prob2 = ODEProblem(lorenz2!, u0, T2)

sol1 = solve(
    prob1,
    #saveat = 0.05
    abstol=1e-8,
    reltol=1e-8)
sol2 = solve(
    prob2,
    #saveat = 0.05
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
    label="Изменение оборотных средств фирмы 1",
    xlabel="Безразмерное время θ = t/c1",
    ylabel="Оборотные средства",
    #ylims = (u0[2]-1, y1_max + 3),
    #yscale =:identity,
    #yticks = 0:1160:11600, 
    #xticks = 0:0.2:2,
    formatter=:plain,
    legend_position=:bottomright,
    titlefontsize=:10,
    legend_font_pointsize=:6,
    color=:blue,
    title="Модель конкуренции только рыночными методами")
plot!(
    plt1,
    sol1,
    idxs=(0,2),
    label="Изменение оборотных средств фирмы 2",
    #ylims = (u0[2] - 0.5, y2_max),
    #yscale =:identity,
    #yticks = 0:20500:205000, 
    color=:red)


plt2 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt2,
    sol2,
    idxs=(0,1),
    label="Изменение оборотных средств фирмы 1",
    xlabel="Безразмерное время θ = t/c1",
    ylabel="Оборотные средства",
    #ylims = (u0[2]-1, y1_max + 3),
    #yscale =:identity,
    #yticks = 0:1160:11600, 
    #xticks = 0:0.2:2,
    formatter=:plain,
    legend_position=:bottomright,
    titlefontsize=:8,
    legend_font_pointsize=:6,
    color=:blue,
    title="Модель конкуренции с рыночными и социально-психологическими факторами")
plot!(
    plt2,
    sol2,
    idxs=(0,2),
    label="Изменение оборотных средств фирмы 2",
    #ylims = (u0[2] - 0.5, y2_max),
    #yscale =:identity,
    #yticks = 0:20500:205000, 
    color=:red)

savefig(plt1, "image/lab08_1.png")
savefig(plt2, "image/lab08_2.png")