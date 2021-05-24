
# Задача 1 : Написать все функции через пузырек

function bubblesort!(a)
    n = length(a)

    for k = 1:n-1
        for i = 1:n-k
            if a[i]>a[i+1]
                a[i],a[i+1]=a[i+1],a[i]
            end
        end
    end
    return a
end

bubblesort(a)=bubblesort!(copy(a)) 

function bubblesort(a)
    n = length(a)
    a=deepcopy(a)
    for k= 1:n-1
        for i = 1:n-k
            if a[i]>a[i+1]
                a[i],a[i+1]=a[i+1],a[i]
            end
        end
    end
    return a
end

function bubblesortperm!(a) # b- вектор индексов
    m = length(a)
    
    b=collect(1:length(a))  # составляем массив из индексов массива а

    for k= 1:m-1
        for i = 1:m-k
            if a[i]>a[i+1]
                a[i],a[i+1]=a[i+1],a[i]
                b[i],b[i+1]=b[i+1],b[i]
            end
        end
    end
    return b
end

bubblesortperm(a)=bubblesortperm!(deepcopy(a))

function bubblesortperm(a)
    n = length(a)

    b=collect(1:length(a)) 
    b= deepcopy(b)

    for k= 1:n-1
        for i = 1:n-k
            if a[i]>a[i+1]
                a[i],a[i+1]=a[i+1],a[i]
                b[i],b[i+1]=b[i+1],b[i]
            end
        end
    end
    return b
end


# Задача 2 : отсортировать все столбцы матрицы
function matrix!(a::Matrix)
    x = view(a,:,1)
    n = length(x)

    for k= 1:n-1
        for i = 1:n-k
            B = view(a,:,i)
            C = view(a,:,i+1)
            if B > C
                B,C=C,B
            end
        end
    end
    return a
end
# Задача 3 : отсортировать столбцы матрицы в порядке возрастания их суммы
function matrix!(a::Matrix)
    x = view(a,:,1)
    n = length(x)

    for k= 1:n-1
        for i = 1:n-k
            B = view(a,:,i)
            Bsum = sum(B)
            C = view(a,:,i+1)
            Csum = sum(C)
            if Bsum > Csum
                B,C=C,B
            end
        end
    end
    return a
end
# Задача 4 : отсортировать столбцы матрицы в порядке возрастания кол-ва нулей в них
function matrix!(a::Matrix)
    x = view(a,:,1)
    n = length(x)

    for k= 1:n-1
        for i = 1:n-k
            B = view(a,:,i)
            l = length(findall((x==0),B))
            C = view(a,:,i+1)
            m = length(findall((x==0),C))
            if  l > m 
                B,C=C,B
            end
        end
    end
    return a
end
# Задача 8 : реализовать ранее написанную функцию insertsort! с помощью встроенной функции reduce 
insertsort!(A)=reduce(1:length(A))do _, k # в данном случае при выполнении операции вставки первый аргумент фуктически не используется
    while k>1 && A[k-1] > A[k]
        A[k-1], A[k] = A[k], A[k-1]
        k-=1
    end
    return A
end