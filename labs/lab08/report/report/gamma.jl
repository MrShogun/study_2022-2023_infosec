include("C:/Users/User/Documents/work/study/2022-2023/Информационная безопасность/infosec/labs/lab07/report/report/gamma.jl")

function Gamma_Hijack_Message(Source_Message_1::String, Encrypted_Message_1::String, Encrypted_Message_2::String)::String
    n1 = length(Source_Message_1)  # Длина исходного сообщения 1
    n2 = length(Encrypted_Message_1)
    n3 = length(Encrypted_Message_2)
    println("Первое исходное сообщение - ", Source_Message_1)
    println("Первое зашифрованное сообщение - ", Encrypted_Message_1)
    println("Второе зашифрованное сообщение - ", Encrypted_Message_2)
    n1 != n2 != n3  ? println("Несоответсвие размерности исходного и зашифрованных сообщений") : skip
    Source_Code_1 = []
    Encrypted_Code_1 = []
    Encrypted_Code_2 = []
    for i ∈ Source_Message_1
        push!(Source_Code_1, Dictionary[i])
    end
    for i ∈ Encrypted_Message_1
        push!(Encrypted_Code_1, Dictionary[i])
    end
    for i ∈ Encrypted_Message_2
        push!(Encrypted_Code_2, Dictionary[i])
    end
    println("Код первого исходного сообщения - ", Source_Code_1)
    println("Код первого зашифрованного сообщения - ", Encrypted_Code_1)
    println("Код второго зашифрованного сообщения - ", Encrypted_Code_2)
    Source_Code_2 = []   # Код второго исходного сообщения
    for i ∈ range(1, n1)
        a = Encrypted_Code_2[i] - Encrypted_Code_1[i] + Source_Code_1[i]
        a <= 0 ? a += N : skip
        a > N ? a %= N : skip 
        push!(Source_Code_2, a)
    end
    println("Код второго исходного сообщения - ", Source_Code_2)
    Source_Message_2 = ""
    for i ∈ Source_Code_2
        Source_Message_2 *= Dictionary2[i]
    end
    println("Второе исходное сообщение - ", Source_Message_2)
    return Source_Message_2
end


P1 = "На Ваш исходящий от 1204"  # 24 символа
P2 = " в Северный филиал Банка"
Initial_Key = "АБВГДЕжзийклмнопрстуфхЦЧ"

println("Находим первое зашифрованное сообщение")
C1 = Gamma_Find_Encrypted_Text(P1, Initial_Key) # тексты зашифрованных сообщений
println("Находим второе зашифрованное сообщение")
C2 = Gamma_Find_Encrypted_Text(P2, Initial_Key)


println("Находим второе сообщение по известным шифротекстам и первому сообщению без использования ключа")
Hijacked_P2 = Gamma_Hijack_Message(P1, C1, C2)

if P2 == Hijacked_P2
    println("Взлом второго сообщения прошел успешно!")
else
    println("Неудача")
end



#=n = length(P1)
Source_Code_1 = []
Source_Code_2 = []
Encrypted_Code_1 = []
Encrypted_Code_2 = []
for i ∈ P1
    push!(Source_Code_1, Dictionary[i])
end
for i ∈ P2
    push!(Source_Code_2, Dictionary[i])
end
for i ∈ C1
    push!(Encrypted_Code_1, Dictionary[i])
end
for i ∈ C2
    push!(Encrypted_Code_2, Dictionary[i])
end

# C12 = P12 + 2K (mod N)
# P12 = P1 + P2 (mod N)
# P1 = C1 - K,  P2 = C2 - K
# C1 + C2 = P1 + (C2 - K) + 2K
# K = -(P1 + C2 - (C1 + C2)) => K = C1 + C2 - C2 - P1 = C1 - P1
# P2 = C2 - (C1 - P1) => P2 = C2 - C1 + P1

P12 = []
C12 = []

for i ∈ range(1, n)
    a = Source_Code_1[i] + Source_Code_2[i]
    a > N ? a %= N : skip 
    push!(P12, a)
end

for i ∈ range(1, n)
    a = Encrypted_Code_1[i] + Encrypted_Code_2[i]
    a > N ? a %= N : skip 
    push!(C12, a)
end

println("P1 + P2 = ", P12)
println("C1 + C2 = ", C12)

K = []

for i ∈ range(1, n)
    a = -(Source_Code_1[i] + Encrypted_Code_2[i] - (C12[i]))
    a > N ? a %= N : skip 
    a <= 0 ? a += N : skip
    push!(K, a)
end

println("Код ключа - ", K)

h_P2 = []
for i ∈ range(1, n)
    a = Encrypted_Code_2[i] - K[i]
    a > N ? a %= N : skip 
    a <= 0 ? a += N : skip
    push!(h_P2, a)
end

println("Код взломанного сообщения - ", h_P2) =#
