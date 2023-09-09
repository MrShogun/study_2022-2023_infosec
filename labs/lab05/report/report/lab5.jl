using Plots
using DifferentialEquations

const a = 0.31;    # Коэффициент смертности хищников
const b = 0.054;  # Коэффициент прироста популяции хищников
const c = 0.32;   # Коэффициент прироста популяции жертв
const d = 0.055;   # Коэффициент смертности жертв

# u[1] - x, u[2] - y, где x - численность популяции хищников, 
#y - численность популяции жертв, du[1]=dx/dt, du[2]=dy/dt
function lorenz1!(du,u,p,t)  # Модель хищник-жертва
    du[1] = -a*u[1] + b*u[1]*u[2]
    du[2] = c*u[2] - d*u[1]*u[2]
end

const u0 = [7, 15]
const T = [0.0, 100.0]

prob1 = ODEProblem(lorenz1!, u0, T)

sol1 = solve(
    prob1,
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
    idxs=(2,1),
    label="Эволюция популяции жертв и хищников",
    xlabel="Численность жертв",
    ylabel="Численность хищников",
    #ylims = (u0[2]-1, y1_max + 3),
    #yscale =:identity,
    #yticks = 0:20500:205000, 
    #xticks = 0:0.2:2,
    #formatter=:plain,
    legend_position=:topright,
    titlefontsize=:14,
    legend_font_pointsize=:6,
    color=:blue,
    title="Модель хищник-жертва")
           
plt2 = plot(
    #aspect_ratio=:equal,
    dpi=300,
    legend=true)
plot!(
    plt2,
    sol1,
    idxs=(0,1),
    label="Эволюция популяции хищников",
    xlabel="Время",
    ylabel="Численность популяции",
    #ylims = (u0[2] - 0.5, y2_max),
    #yscale =:identity,
    #yticks = 0:20500:205000, 
    #xticks = 0:0.2:2,
    #formatter=:plain,
    #legend_position=:bottomleft,
    #legend_font_pointsize=:7,
    titlefontsize=:14,
    color=:red,
    title="Модель хищник-жертва")

plot!(
    plt2,
    sol1,
    idxs=(0,2),
    label="Эволюция популяции жертв",
    #ylims = (u0[2] - 0.5, y2_max),
    #yscale =:identity,
    #yticks = 0:20500:205000, 
    color=:green)

savefig(plt1, "image/lab05_1.png")
savefig(plt2, "image/lab05_2.png")