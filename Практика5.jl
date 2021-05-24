# Функция eval_poly(x,A) является обобщенной: реальный исполняемый код будет зависеть от фактических типов её аргументов:
eval_poly(5,[1,2,3,4]) # 5^3+2*5^2+3*5+4 - первый аргумент типа Int64
eval_poly(0.5,[1,2,3,4]) # 0.5^3+2*0.5^2+3*0.5+4 - первый аргумент типа Float64
eval_poly(1//2,[1,2,3,4]) # (1//2)^3+2*(1//2)^2+3*1//2+4  - первый аргумент типа Rational{Int64}
eval_poly(1+2im,[1,2,3,4]) # (1+2im)^3+2*(1+2im)^2+3*(1+2im)+4 - первый аргумент типа Complex{Int64}
eval_poly(0.5,1:4) # - второй аргумент типа UnitRange{Int64}

struct Polynom{T} # это параметрический тип, позволяющий определять типы коэффициентов многочлена
    coeff::Vector{T} # вектор коэффициентов многочлена, заданных по убыванию степеней
end

module Polynoms
    import Base: +, * # это импортирование требуется, поскольку мы собираемся переопределить эти базовые опреации

    struct Polynom{T}
        coeff::Vector{T}
    end

    function +(p::Polynom, q::Polynom)
        np,nq = length(p.coeff), length(q.coeff)
        r=Vector{promote_type(eltype(p),eltype(q))}(undef,max(np,nq))
        if np >= nq
            r .= (@view p.coeff[end-nq+1:end]) .+ q.coeff  
        else
            r .= (@view q.coeff[end-np+1:end]) .+ p.coeff
        end
        return Polynom(r)
    end

#= ПОЯСНЕНИЯ
1. Здесь используется не векторизованное сложение массивов с формированием результата "на месте". Для этого использована запись соответствующих операций с точкой:  .=, .+. Например, запись
r .= (@view p.coeff[end-nq+1:end]) .+ q.coeff
есть просто краткая запись следующего цикла:
for i in length(p.coeff)-nq+1:length(p.coeff)
    r[i] = p.coeff[i] + q.coeff[i-length(p.coeff)+nq]
end
2. Здесь использована встроенная функция promote_type, которая получает на вход список типов и возвращает тот тип из этого списка,
к которому автоматически будут приведиться все остальные при выполнении встроенных операций, если аргументы этих операций будут иметь разные типы.
Например, при сложении значений типов Float64 и Int64, второе значение автоматически будет приведено к типу Float64. 
=#

    function +(p::Polynom, c::Number) # многочлен с числом
        coeff=p.coeff
        coeff[end]+=c
        return Polynom(coeff)
    end

    function +(c::Number, p::Polynom) # число с многочленом
        coeff=p.coeff
        coeff[end]+=c
        return Polynom(coeff)
    end

    function +(p::Polynom, q::Polynom) # многочлен с многочленом
        np,nq = length(p.coeff), length(q.coeff)
        coeff=zeros(promote_type(eltype(p),eltype(q)), np+nq-1)
        for i in eachindex(p.coeff), j in eachindex(q)
            coeff[i] += p.coeff[i]+q.coeff[j]
        end
        return Polynom(coeff)
    end

    +(c::Number, p::Polynom)=p+c

    function *(p::Polynom, q::Polynom) # многочлен на многочлен
        np,nq = length(p.coeff), length(q.coeff)
        coeff=zeros(promote_type(eltype(p),eltype(q)), np+nq-1)
        for i in eachindex(p.coeff), j in eachindex(q)
            coeff[i+j-1] += p.coeff[i]*q.coeff[j]
        end
        return Polynom(coeff)
    end

    function *(p::Polynom, c::Number) # многочлен на число
        np,nq = length(p.coeff), length(q.coeff)
        coeff=zeros(promote_type(eltype(p),typeof(c)), length(p))
        for i in eachindex(p.coeff)
            coeff[i] += coeff[i]*c
        end
        return Polynom(coeff)
    end
    function *(c::Number, p::Polynom) # число на многочлен
        np,nq = length(p.coeff), length(q.coeff)
        coeff=zeros(promote_type(eltype(p),typeof(c)), length(p))
        for i in eachindex(p.coeff)
            coeff[i] += coeff[i]*c
        end
        return Polynom(coeff)
    end
    
    *(c::Number, p::Polynom) = p*c
end
