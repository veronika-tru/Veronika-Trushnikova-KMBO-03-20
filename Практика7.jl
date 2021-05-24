#Задача 1. Написать функцию pow(a, n::Integer), возвращающую значение $a^n$, и реалзующую алгоритм быстрого возведения в степень.
function pow(a, n::Integer)
    p = 1
    while k > 0

        if k % 2 != 1
            p *= a
        end

        a *= a
        k /= 2

    end

    return p
end
#Задача 2. Написать функцию fibonacci(n::Intrger), возвращающую n-ое число последовательности Фибоначчи, имеющую оценку алгоритмической сложности $O(log(n))$, и не используя известную формулу Бине.
function fibonacci(n::Integer) # с помощью разностного уравнения
    t = collect(1:n)
    t[1] = 0
    t[2] = 1
    for j in 2:n
        t[j] = t[j-1] + t[j-2]
    end
    return t[n]
end
#Задача 3. Написать функцию log(a::Real,x::Real,ε::Real), реализующую приближенное вычисление логарифма по основанию a>1 числа x>0 с максимально допустимой погрешностью ε>0 (без использования разложения логарифмической функции в степенной ряд).
function log(a::Real, x::Real, e::Real) 
    @assert a>1
    @assert x>0
    z, t, y = x, 1, 0
    #ИНВАРИАНТ: a^y * z^t == x (=const)
    while z > a || z < 1/a || t > ε   
        if z > a
            z /= a
            y += t # т.к. z^t = (z/a)^t * a^t
        elseif z < 1/a
            z *= a
            y -= t # т.к. z^t = (z*a)^t * a^-t
        else 
            t /= 2
            z *= z # т.к. z^t = (z*z)^(t/2)
        end
    end
    
end
#Задача 4. Изучить интерфейс встроенной функции gcd, реализующей расширенный алгоритм Евклида, и убедиться, что она является обобщенной, в частоностии, - в том, что её аргументами могут быть не только целые числа, но и, например, рациональные (типа Rational). Самостоятельно написать подобную функцию, реализующую расширенный алгоритм Евклида, воспользовавшись методом инварианта цикла (см. лекцию 3).
function gcd(a,b) # при этом a>b
    if b == 0
        return a
    end
    return gcd(b, a%b)
end

#Задача 6. Написать функцию inv(m::Integer,n::Integer) возвращающий обратный элемент к значению m в кольце вычетов по модулю n (см. лекцию 3). При этом, если значение n не обратимо, то должно возвращаться значение nothing.
function gcd(a::Integer, n::Integer)
    if a == 0
        return (n, 0, 1)
    else
        div, x, y = gcd(n % a, a)
    end
    return (div, y - (n // a) * x, x)
end
function inv(m::Integer, n::Integer)
    s, b, c = gcd(m,n)
    if b<0
        b += n
    end
    if m*b%n == 1
        return b
    else
        return "nothing"
    end
end
#Задача 7. Написать функцию isprime(n)::Bool, возвращающую значение true, если аргумент есть простое число, и - значение false, в противном случае. При этом следует иметь ввиду, что число 1 простым не считается.
function isprime(m)
    if m == 1
        return false
    else
        i = 2
        count = 0
        while i * i <= m
            while m % i == 0
                count += 1
                m = n / i
                i = i + 1
                if count > 1
                    return false
            end
        end
    end
    return true
end
#Задача 8. Написать функцию eratosphen(n), возвращающую вектор всех простых чисел, не превосходящих заданного натурального числа n.
function eratosphen(n::Integer)
    ser=fill(true,n)
    ser[1]=false
    k=2
    # все элементы в ser[1:k] c простыми индексами, и только они, имеют значение true
    
    while k<n || k != nothing
        ser[2k:k:end] .= false 
        k=findnext(ser, k+1)
    end
    return findall(ser)
end

#Задача 9. Написать функцию factor(n), получающую некоторое натуральное число n, и возвращающую кортеж, состоящий из вектора его простых делителей (в порядке возрастания) и вектора кратностей этих делителей. Оценка вычислительной сложности алгоритма должна быть $O(n \log(\log(n))$.
function factor(n)
    t = primfacs(n)
    s = collect(max(t))
    for i in t
        s[i] += 1
    end
    return t,s
end
function primfacs(n)
   i = 2
   j = 1
   primfac = collect(1:n)
   while i * i <= n
        while n % i == 0
            primfac[j] = i
            n = n / i
            j += 1
        end
        i = i + 1
    end
    return primfac
end
#Задача 10. Написать функцию, возвращающую все делители нуля кольца вычетов по заданному модулю $n$.
function delitel(m)
    for i in 1:m-1
        if gsd(i,m) != 1 
            print(i)
        end
    end
end
#Задача 11. Написать функцию, возвращающую для заданного n вектор всех не тривиальных нильпотентных элементов в кольце вычетов $\mathbb{Z}_n$.
function nilpotent(n)
    l = primfacs(n)
    for i in 2:length(l)
        if l[i] == l[i-1]
            delete!(l,i-1)
    end

    pr = 1
    for j in 1:length(l)
        pr *= l[j]
    end

    for k in 1:l[length(l)]
        if pr*k<l-1
            print(pr*k)
        else
            break
        end
    end
end
function primfacs(m)
    i = 2
    j = 1
    primfac = collect(1:m)
    while i * i <= m
         while m % i == 0
             primfac[j] = i
             m = m / i
             j += 1
         end
         i = i + 1
     end
     return primfac
end
#Задача 12. Написать функцию высшего порядка bisection(f::Function, a, b; atol, rtol) реализующую решатель уравнения вида $f(x)=0$, реализующую метод деления отрезка пополам, где аргументы atol, rtol задают требуемую абсолютную и относительную точность (atol, rtol - это именованные параметры, которым можно присвоить также некоторые значения по умолчанию).
