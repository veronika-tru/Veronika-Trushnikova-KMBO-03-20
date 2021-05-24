#=На практическом занятии 6 предлагалось написать функциию merge(a,b), 
осуществляющую слияние двух заранее отсортированных массивов в один отсортированный за O(n) операций (где n - сумма длин обоих исходных массивов), 
без использования вспомогательного массива, и возвращающую ссылку на результирующий массив. Также там предлагалось написать функцию merge!(a,b,с), 
отличающуюся от предыдущей тем, что свой результат она помещает во внешний массив c.
С использованием этих функций можно реализовать алгоритм быстрой сортировки слияниями. Рассмотрим несколько вариантов реализации этого алгоритма.=#
#Рекурсивный вариант:
function mergesort!(a)
    if length(a)==1
        return a
    end
    a1 = mergesort!(a[begin:end÷2]) 
    a2 = mergesort!(a[end÷2+1:end])
    merge(a1, a2)
end
#=Какова будет оценка вычислительной сложности этого алгоритма? Почему правильный ответ будет 
$O(n\cdot log(n))$ (для ответа на этот вопрос, рассмотреть сначала случай, когда $n=2^m$).
Какова будет оценка потребляемого объема памяти? Почему правильный ответ будет $O(n\cdot log(n))$, 
и что можно сделать, чтобы получить оценку - $O(n)$.=#
#Задача 1. Реализовать рекурсивный вариант сортировки слияниями с оценками сложности и объема потребляемой памяти $O(n\cdot log(n))$.
function merge_sort(L, compare) # Основная идея алгоритма состоит в том, чтобы разделить (под) массивы пополам и отсортировать их рекурсивно. Мы будем продолжать делать это как можно больше, то есть до тех пор, пока не получим подмассивы, которые имеют только один элемент
    if len(L) < 2
        return L[:]
    else
        middle = int(len(L) / 2)
        left = merge_sort(L[:middle], compare)
        rigth = merge_sort(L[middle :], compare)
        return merge(left, right, compare)
    end
end
function merge!(left, right, compare)
    result = collect(1)
    u = 1
    i = 0
    j = 0
    while ((i < length(left)) & (j < length(right)))
        if compare(left[i], right[j])
            insert!(result, u, left[i])
            u += 1
            i += 1
        else
            insert!(result, u, right[j])
            u += 1
            j += 1
        end
    end
    while i < length(left)
        insert!(result, u, left[i])
        u += 1
        i += 1
    end
    while j < length(right)
        insert!(result, u, right[j])
        u += 1
        j += 1
    end
    return result
end
#Задача 2. Реализовать оба варианта нерекурсивной сортировки слияниями.
#=Замечание. Идею сортирвки слияниями (в нерекурсивном варианте) можно использовать, например, 
если размер сортируемого массива настолько большой, что его нельзя разместить в оператианой памяти, 
а можно хранить только на внешнем носителе. Для этого потребуется в частности переопределить функцию merge так, 
чтобы она получала файловые указатели на файлы, в один из которых записан массив a, а в другой - масив b, 
а также номера позиций в этих файлах, определяющих очередную пару упорядочиваемых блоков.=#
function msort(x)
    result = collect(1)
    u = 1
    if length(x) < 2
        return x
    mid = int(length(x)/2)
    y = msort(x[:mid])
    z = msort(x[mid :])
    while (length(y) > 0) || (length(z) > 0)
        if length(y) > 0 & length(z) > 0
            if y[0] > z[0]
                insert!(result, u, z[0])
                u += 1
                delete!(z,1)
            else
                insert!(result, u, y[0])
                u += 1
                delete!(y,1)
            end
        elseif length(z) > 0
            for i in z
                insert!(result, u, i)
                u += 1
                delete!(z,1)
            end
        else
            for i in y
                insert!(result, u, i)
                u += 1
                delete!(y,1)
            end
        end
    end
    return result
end
#=Задача 3. Сравнить время выполния различных реализаций алгоритма сортировки слияниями мужду собой и с встроенной функцией sort!. 
Длину массива следует взять достатоно большой, 
например, равной 1_000_000. Сортируемый массив формировать с помощью встроенного генератора случайных массивов randn.=#
#=Быстрая сортировка Хоара
На практическом занятии 6 рассматривалась также процедура partsort!(a,b), получающая указательна массив a и некотрое значение b, 
и перставляющая элементы в массиве так, что бы сначала в нем следовали все элементы меньшие b, затем - все равные b, и, наконец, - все большие b.
Или, в другом варианте, - переставляющая элементы в массиве так, что бы сначала в нем следовали все элементы меньшие или равные b, 
а затем - все равные b (в этом случае соответствующую функцию можно назвать partsort2!).
Каждая из этих вариантов данной процедуры partsort!(a,b), или partsort2!(a,b), может быть положен в основу процедуры быстой сортировки Хоара.
Вот рекурсивная запись сортировки Хоара, основанной на первом варианте функции partsort!(a,b):=#
function quicsort!(a)
    if isempty(a)
        return a
    end
    a, i, j = partsort!(a,a[begin]) 
    #УТВ: all(a[begin:i] .< b) && all(a[i+1:j] .== b) && all(a[j+1:end] .>= b)
    quicsort!(@viev a[begin:i])
    quicsort!(@viev a[j+1:end])
    return a
end
#=Здесь имеется в виду, что функция partsort!(a,b) доработана таким образом
осуществления перестановки элементов массива требуемым образом, она также возвращает 
и индексы границ соотетствующих частей массива.
Зададимся вопросом, какова оценка алгоритмической сложности данного алгоритма. Если допустить, что длина a[begin:i]) почти всегда будет получиться приблизительно равной длине a[j+1:end]), то получим оценку сложности $O(n\cdot log(n))$. Это потому, что в этом случае каждый следующий рекурсивный вызов функции quicsort! будет получать на вход массив по крайней мере в двое короче исходного, и таким образом глубина рекурсии будет оцениваться как $O(log(n))$. И, так как оценка вычислительной сложности функцииpartsort!(a,a[begin]) - $O(n)$, то оценка вычислительной сложности всей сортировки получается - $O(n\cdot log(n)$.
Однако, если, например, массив a изначально был отсортирован, то длина a[begin:i]) всегда будет рана 0 (т.к. этот срез будет получиться пустым), и поэтому вычислительная сложность алгоритма сортировки будет иметь оценку $O(n^2)$, т.е. для этого случая алгоритм будет совсем не быстрым.
Избавиться от этого недостатка можно, если вместо значения a[begin] (это второй фактический параметр функции partsort!(a,a[begin])), брать наугад любой элемент массива a:
i, j = partsort!(a,a[rand(1:length(a))])
или, чтобы не привязываться к конкрентному способу индексирования элементов массива, лучше программировать так:
i, j = partsort!(a,a[rand(firstindex(a):lastindex(a))])
Тогда в подавляющем бльшинстве случаев наше предположение о приблизительном равенстве длин двух частей массива, 
на которые он разбивается процедурой partsort1, будет справедливой 
(это если средняя часть массива будет много меньше длины всего массива - в противном случае оценка сложности будет ещё лучше). 
Таким образом, это можно показать строго, алгоритм сортировки Хоара имеет в среднем оценку сложноности $O(n\cdot log(n))$.
Но это "в среднем", и это означет, что всегда можно искуственно подобрать такой исходный массив, 
на котором быстрая сортировка Хоара будет вырождаться в сортировку квадратичной сложности. 
Однако на практике алгоритм Хоара является одним из самых эффективных алгоритмов сортировки.=#
#Задача 4. Реализовать алгоритм быстрой сортировки Хоара двумя способами: 
#основываясь на двух, указанных выше возможных вариантах частичной сортировки (partsort!, или - partsort2!).
function partsort!(A)
    if length(A) <= 1
        return A
    else
        q = random.choice(A)
        L = [elem for elem in A if elem < q]
        M = [q] * A.count(q)
        R = [elem for elem in A if elem > q] 
        return partsort!(L) + M + partsort!(R)
    end
end
function partsort2!(A, l, r)
    if l >= r
        return 
    else
        q = random.choice(A[l:r + 1])
        i = l
        j = r
        while i <= j
            while A[i] < q
                i += 1
            end
            while A[j] > q
                j -= 1
            end
            if i <= j 
                A[i], A[j] = A[j], A[i]
                i += 1
                j -= 1 
                partsort2!(A, l, j)
                partsort2!(A, i, r)
            end
        end
    end
end
#Задача 5. Написать функцию, реализующую вычисление k-ой порядковой статистики, и - (на её основе) функции, вычисляющую медиану.
function print_statistics(arr)
    mediana = None
    number = None
    if not len(arr)
        print("Пустой или не предоставлен")
    else
        number = len(arr)
        number1 = (number - 1) // 2
        if number % 2 == 0:
            mediana = (arr[number1] + arr[number1 + 1]) / 2
        else:
            mediana = arr[number1]
        end
    end
        print(f"Длина - {number}, Среднее - {sum(arr) / number}, "
              f"Минимальное значение - {min(arr)}, Максимальное значение - {max(arr)}, "
              f"Медиана - {mediana}")
end