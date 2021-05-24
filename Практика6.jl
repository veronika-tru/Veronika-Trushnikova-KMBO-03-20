#= Задача 1: Написать функцию, получающую 2 отсортированных массива `A` и `B`, и объединяющую их в одном отсортированном массиве `C`
`(length(C)=length(A)+length(B)=n`). Алгоритм должен иметь оценку сложности `O(n)`.
Функцию можно назвать `merge`. Реализовать 2 варианта:
а) `merge(A,B)` - возвращает массив `C`;
б) `merge!(A,B,C)` - используется внешний массив `C` (поэтому в конце имени функции и поставлен восклицательный знак).=#
function merge(A,B)
    C = collect(1:length(A)+length(B))
    if length(A)<length(B)
        k = 1
        for i in 1:length(A)
            if A[i] < B[i]
                C[k] = A[i]
                C[k+1] = B[i]
                k += 2
            end
        end

        for j in i:length(B)
            C[j] = B[j]
        end
    else
        k = 1
        for i in 1:length(B)
            if A[i] < B[i]
                C[k] = A[i]
                C[k+1] = B[i]
                k += 2
            end
        end

        for j in i:length(A)
            C[j] = A[j]
        end
    end

    return C
end

function merge!(A,B,C)

    C = deepcopy(C)

    if length(A)<length(B)
        k = 1
        for i in 1:length(A)
            if A[i] < B[i]
                C[k] = A[i]
                C[k+1] = B[i]
                k += 2
            end
        end

        for j in i:length(B)
            C[j] = B[j]
        end
    else
        k = 1
        for i in 1:length(B)
            if A[i] < B[i]
                C[k] = A[i]
                C[k+1] = B[i]
                k += 2
            end
        end

        for j in i:length(A)
            C[j] = A[j]
        end
    end

    return C
end
#= Задача 2: Написать функцию, выполняющую частичную сортировку. А именно, функция получает некоторый массив `A` и некотрое значение `b`, и переставляет элементы в массивае `A` так, что бы в нём сначала шли все элементы, меньшие `b`, затем - все, равные `b`, и затем, наконец, - все большие `b`. Алгоритм должен иметь оценку сложности `O(n)`.
Реализовать следующие 2 варианта этой функции
а) c использованием 3-х вспомогательных массивов (с последующим их объединением в один);
б) без использования вспомогательного массива (все перемещения элементов должны осуществляться в переделах одного массива).
Указание для варианта б). Ввести переменные `l,m,k` и воспользоваться инвариантом цикла: `A[1:l]<b && A[l+1:m]== b && A[k+1:n]>b` `(n=length(A))`.=#
function partsort_a(A,b)
    k = 1
    A1 = collect(1:length(A))
    t = 1
    A2 = collect(1:length(A))
    s = 1
    A3 = collect(1:length(A)) 

    for i in 1:length(A)
        if b > A[i]
            A1[k] = A[i]
            k += 1
        elseif b == A[i]
            A2[t] = A[i]
            t += 1
        else
            A3[s] = A[i]
            s += 1
        end
    end

    B = merge(A1,A2)
    B = merge(B,A3)

    return B
end

function  partsort_b(A,b)
    n = length(A)
    l = 0
    m = 1
    k = n
    for i in 1:length(A) 
        if A[i] < b
            l += 1
    end

    while m != k
        if A[m] == b
            A[m],A[m+1] = A[m+1],A[m]
            m += 1
        end

        if A[k] > b 
            A[k],A[k-1] = A[k-1],A[k]
            k -= 1
        end
    end 

    return A
end
#=Задача 3. Написать функцию, выполняющую частичную сортировку. `А` именно, функция получает некоторый массив `A` и некотрое значение `b`, 
и переставляет элементы в массивае `A` так, что бы в нём сначала шли все элементы, меньшие или равные b, а затем, - все большие b. Алгоритм должен иметь оценку сложности `O(n)`.=#
function  partsort_b(A,b)
    n = length(A)
    l = 1
    m = n
    
    while l != m
        if A[l] <= b
            A[l],A[l+1] = A[l+1],A[l]
            l += 1
        end

        if A[m] > b 
            A[m],A[m-1] = A[m-1],A[m]
            m -= 1
        end
    end 

    return A
end
#=Задача 4. Написать функию, для заданного натурального числа `n` возвращающую массив всех биномиальных коэффициентов порядка `n`.
Указание. Воспользоваться "треугольником" Паскаля.
(вопрос: почему формула $C_n^k=\frac{n!}{k!(n-k)!}$ при сколько-нибудь больших `n`не подходит для практических вычислений?).
Рассмотреть следующие варианты реализации вычисления биномиальных кэффициентов с использованием "треугольника"  Паскаля:
а) с использованием двух массивов длины `n` (плюс-минус 1)
б) с использованием только одного массива длины `n`
в) с использованием массиванием массива длины `n/2+1` - это возможно с учетом свойства симметрии биномиальных коэффициентов.=#
function natural_a(m)
    A = collect(1:m)

    if m == 1
        A[1] = 1 
    end

    if m == 2
        A[1] = 1
        A[2] = 1
    end

    if m > 2
        A[1] = 1
        A[2] = 1
        count = 2
        while count != m
            B = collect(1:m) 
            for i in 1:count
                if i == 1
                    B[i] = A[i]
                elseif i == count
                    B[count] = A[count]
                else
                    B[i] = A[i-1] + A[i]
                end 
            end
            A = B
            count += 1
        end
    end

    return A
end

function natural_b(k)
    A = collect(1:k)

    for i in 1:k
        if i==1 || i==k
            A[1] = 1
        else
            c = natural_b(k)
            A[k] = A[i-1] + A[i]
        end
    end

    return A
end

function natural_c(n)
    A = collect(1:n)

    if count % 2 == 0
        for i in 1:n/2
            if i==1 || i==n
                A[1] = 1
            else
                c = natural_b(n)
                A[n] = A[i-1] + A[i]
            end
        end

        k = 1

        for j in n/2+1:n
            A[j] = A[j-k]
            k += 2
        end
    else
        
    for i in 1:n/2+1
        if i==1 || i==n
            A[1] = 1
        else
            c = natural_b(n)
            A[n] = A[i-1] + A[i]
        end
    end

        k = 2
        for j in n/2+2:n
            A[j] = A[j-k]
            k += 2
        end
    end

    return A
end
