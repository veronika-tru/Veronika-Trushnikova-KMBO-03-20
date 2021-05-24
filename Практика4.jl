# Задача 2-3:
function shenker!(a)
    len = length(a) # длина массива  
    f = true
    index_01 = 1 
    index_02 = len - 1 

    while (f == true)
        f = false

        # проход слева на право 
        for i in index_01:index_02
            if (a[i] > a[i + 1])
                a[i] , a[i + 1] = a[i + 1] , a[i]
                f = true
            end
        end

        if (not(f))
            break
        end

        f = false

        index_02 = index_02 - 1 

        # проход спарва на лево
        for i in (index_02 - 1):-1:(index_01 - 1) 
            if (a[i] > a[i + 1])
                a[i] , a[i + 1] = a[i + 1] , a[i]
                f = true
            end
        end

        index_01 = index_01 + 1
    end

    return a

end

#Сортировка Шелла:
function shell(a)
    len = length(a)
    p = len / 2

    while len >= 1
        for i in p:len
            x = a[i]
            j = i
        end

        while j >= p & a[j - p] > x 
            a[j] = a[j - p]
            j -= p
        end

        a[j] = p

        p /= 2
    end
    return a
end

# Сортировка выбором наибольшего(наименьшего) элемента
function vibor(a) # Очеедной максимальный элемент перемещается в конец массива сразу после того, как сначала будет найден его индекс
    for i in reverse(eachindex(a))
        i_max = arg_max(@view a[begin:i])
        a[i_max] , a[i] = a[i] , a[i_max]
    end
    return a 
end

# Перестановка элементов в массиве без использования дополнительного массива
# Задача 4:
function slice(A::Vector{T},p::Vector{Int}) :: Vector{T} where T
    b :: Vector{T}
    k = 0
    for i in p
        b[k] = a[i]
        k += 1
    end

    return b
end
# Задача 5:
function permute_!(a::Vector{T}, perm::Vector{Int}) :: Vector{T} where T
    count = 0
    for i in 1:length(a)
        if i != p[i]
            count += 1
        end
    end

    i = 1
    k = p[i]
    x = a[k]
    y = a[i]
    a[i] = a[k]

    count -= 1

    while count!= 0
        k = y
        x = p.index(k)
        y = a[x]
        a[x] = a[k]

        count -= 1
    end

    return a
end
# Вставка / удаление элементов массива
# Задача 6:
function deleteat!(a,x) # удаление элементов
    index = poisk(a,x)
    count = length(a)
    for  i in index:count-1
        a[i] = a[i + 1]
        count -= 1
    end
end
function poisk(ptr,x)
    for  i in 0:count-1
        if (ptr[i] == value)
            return i;
        end
    end
    return -1;
end

function insert!(a,x,index) # вставка элемента по индексу
    for  i in (count - 1):-1:index
        a[i + 1] = a[i]
    end
    a[index] = x
    count += 1
end
# Выбор всех уникальных элементов массив
# Задача 7:
function unique!(a)
    a = sort!(a)
    for i in 0:length(a) - 2
        if a[i]==a[i+1]
            deleteat!(a,a[i+1])
        end
    end
    return a
end

function unique_(a)
    a = sort!(a)
    k = 0
    for i in 0:length(a) - 2
        if a[i]!=a[i+1]
            b[k] = a[i]
            k += 1
        end
    end
    return b
end

function allunique(a)
    a = sort!(a)
    for i in 0:length(a) - 2
        if a[i]==a[i+1]
            return false
        end
    end
    return true
end
# Обращение последовательности
# Задача 8:
function reverse!(a)
    len = length(a)
    n = len
    for i in 0:len/2
        a[i] , a[i+n] = a[i+n], a[i]
        n -= 2
    end
end
# Сдвиг массива 
# Задача 9:
function sdvig(a,m)
    count = length(a)
    count += m
    for i in (count - n):-1:0
        a[i + n] = a[i]
    end

    for j in 0:n-1
        a[j] = -1 # чтобы показать, что мы сдвинули числа, иначе на n первых или последних позициях у нас останутся наши исходные числа
    end

    count -= n 
end

# Транспонирование матрицы
# Задача 10:
function transpose!(a::Matrix) # с использование доп массива 
    x = length(a) # строки 
    y = length(a[1])
    b :: Matrix
    for i in 1:a
        for j in 1:y 
            b[j][i] = a[i][j]
        end
    end
    return b
end
# Задача 11:
function transpose!(a::Matrix) # без использование доп массива
    x = length(a) # строки 
    y = length(a[1])
    b :: Matrix
    for i in 1:a/2+1
        for j in 1:y/2+1
            c = a[j][i]
            a[j][i] = a[i][j]
            a[i][j] = c
        end
    end
    return a
end