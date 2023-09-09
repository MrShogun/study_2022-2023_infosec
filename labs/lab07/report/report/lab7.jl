using Plots
using DifferentialEquations

const N = 1120;    # Число проживающих на острове
const n0 = 19

const α1_1 = 0.93; # Интенсивность рекламной кампании в первом случае(модель Мальтуса)
const α2_1 = 0.00003; # Эффективность распространения за счет осведомленных в первом случае
const α1_2 = 0.00003; # Интенсивность рекламной кампании во втором случае(логистическая кривая)
const α2_2 = 0.62; # Эффективность распространения за счет осведомленных во втором случае
"Интенсивность рекламной кампании в третьем случае"
function α1_3(t)
    0.88*cos(t)
end
"Эффективность распространения за счет осведомленных в третьем случае"
function α2_3(t)
    0.77*cos(2*t)
end

"Модель Мальтуса"
function F_1(u, p, t)
    return (α1_1 + α2_1*u)*(N - u)
end
"Модель с логистической кривой"
function F_2(u, p, t)
    return (α1_2 + α2_2*u)*(N - u)
end
"Третий случай с зависимыми от времени коэффициентами"
function F_3(u, p, t)
    return (α1_3(t) + α2_3(t)*u)*(N - u)
end

const u0 = n0
const T_1 = [0.0, 20.0]
const T_2 = [0.0, 0.02]
const T_3 = [0.0, 0.02]

prob1 = ODEProblem(F_1, u0, T_1)
prob2 = ODEProblem(F_2, u0, T_2)
prob3 = ODEProblem(F_3, u0, T_3)

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

sol3 = solve(
    prob3,
    #saveat = 0.05)
    abstol=1e-8,
    reltol=1e-8)    

function F2(u)
    return (α1_2 + α2_2*u)*(N - u)
end

F = collect(F2(u) for u in sol2.u) # Набор значений производной
k = argmax(F) #Индекс наибольшего значения, т.е. sol2.u[k]
t1 = sol2.t[k] # Время для найденного индекса

println("Момент наибыстрейшего роста числа информированных клиентов во второй модели t = ", t1)
#@show k
#@show F[k]
#@show t1

plt1 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt1,
    sol1.t,
    sol1.u,
    #idxs=(0,1),
    label="Число информированных клиентов",
    xlabel="Время",
    ylabel="Число людей",
    #ylims = (u0[2]-1, y1_max + 3),
    #yscale =:identity,
    #yticks = 0:1160:11600, 
    #xticks = 0:0.2:2,
    #formatter=:plain,
    legend_position=:bottomright,
    titlefontsize=:12,
    legend_font_pointsize=:6,
    color=:blue,
    title="Модель рекламной кампании в виде модели Мальтуса")

plt2 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt2,
    sol2.t,
    sol2.u,
    #idxs=(0,1),
    label="Число информированных клиентов",
    xlabel="Время",
    ylabel="Число людей",
    #ylims = (u0[2]-1, y1_max + 3),
    #yscale =:identity,
    #yticks = 0:1160:11600, 
    #xticks = 0:0.2:2,
    #formatter=:plain,
    legend_position=:bottomright,
    titlefontsize=:12,
    legend_font_pointsize=:6,
    color=:red,
    title="Модель рекламной кампании с логистической кривой")

plt3 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt3,
    sol3.t,
    sol3.u,
    #idxs=(0,1),
    label="Число информированных клиентов",
    xlabel="Время",
    ylabel="Число людей",
    #ylims = (u0[2]-1, y1_max + 3),
    #yscale =:identity,
    #yticks = 0:1160:11600, 
    #xticks = 0:0.2:2,
    #formatter=:plain,
    legend_position=:bottomright,
    titlefontsize=:11,
    legend_font_pointsize=:6,
    color=:green,
    title="Модель рекламной кампании с переменными коэффициентами")

savefig(plt1, "image/lab07_1.png")
savefig(plt2, "image/lab07_2.png")
savefig(plt3, "image/lab07_3.png")