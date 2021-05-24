#Задача 1. Написать функцию, вычисляющую $n$-ую частичную сумму ряда Тейлора функции $$\cos(x)=1-\frac{x^2}{2!}+\frac{x^4}{4!}-\frac{x^6}{6!}+...$$ для заданного значения аргумента $x$. Вычислительная сложность алгоритма должна иметь оценку $O(n)$.
function cosinus(n,x)
    if n<2 
        return n
    c = x*x/(2*(n-1)*2*n)
    return (1-c)*cosinus(n-1, x) + c*cosinus(n-2,x) 
end    
#=Задача 2. Написать функцию, вычисляющую значение суммы ряда Тейлора функции $cos(x)$ в заданной точке с машинной точностью.
Указание. Постараться минимизировать число арифметических операций, при этом для ускорения сходимости воспользоваться формулами приведения.
Протестировать функцию, путем сравнения получаемых результатов с результатами, выдаваемыми встроенной функцией $\cos(x)$.=#
function teylor(eps,x) 
    n = 0
    an = x
    summ = 0
    while math.fabs(an) > eps 
        summ += an
        an*= -x * x / ((2. * n + 1.) * (2. * n + 2.))
        n += 1
    end
end

#=Задача 6. Написать функцию linsolve(A,b), получающую на вход невырожденную квадратную верхнетреугольную матрицу A (матрицу СЛАУ, приведенную к ступенчатому виду), 
вектор-столбец b (правую часть СЛАУ), и возвращающую решение соответствующей СЛАУ.
Пояснение. Матрица называется верхнетреугольной, если все её элементы, стоящие ниже главной диагонали равны нулю.=#
function linsolve(a,b)
    е = collect(length(a))

    for i in length(a):1
        for j in length(a)-1:i
            if a[j][k]>=0 & a[i][i]<=0 || a[j][k]<=0 & a[i][i]>=0
                a[j][i] = a[j][i] + a[i][i]*a[j][i]/a[i][i]
            else
                a[j][i] = a[j][i] - a[i][i]*a[j][i]/a[i][i]
            end
        end
    end

    for i in 1:length(a)
        e[i] = b[i]/a[i][i]
    end

    return e
end
#=Задача 7. Написать функцию convert!(A), получающую на вход прямоугольную матрицу (расширенную матрицу СЛАУ) и 
пробразующую эту матрицу к ступенчатому виду с помощью элементарных преобразований строк.
Указание. Преобразования осуществлять с выбором ведущего элемента в столбце.=#
function convert!(a)
    for i in 1:length(a)
        for j in i:length(a)
            for k in 1:length(a)
                if a[j][k]>=0 & a[i][i]<=0 || a[j][k]<=0 & a[i][i]>=0
                    a[j][k] = a[j][k] + a[i][i]*a[j][i]/a[i][i]
                else
                    a[j][k] = a[j][k] - a[i][i]*a[j][i]/a[i][i]
                end
            end
        end
    end
    return a
end
#=Задача 8. Написать функцию det(A), получающую на вход квадратную матрицу, и возвращающую значение её определителя.
Указание. Модернизировать convert! (и для нового варианта придумать новое имя, например, issingular_convert! с тем, 
чтобы если при приведении матрицы к ступенчатому виду обнаружится, что матрица вырожденная, 
то дальнейшие преобразования должны прекращаться, и функция вернет логичиское значение true, в противном случае возвращается false.=#
function det(A)
    m = lengtn(A)
    n = length(A[0])
    if m != n
        return None
    if n == 1
        return A[0][0]
    signum = 1
    det = 0
 
    for j in range(n)
        det += A[0][j] * signum * det(minor(A, 0, j))
        signum *= -1
    end
    return det
end
#=Задача 9. Написать функцию inv(A), получающую на вход квадратную матрицу, 
и возвращающую обратную матрицу, если матрица обратима, или - значение nothing, в противном случае.
Указание. Воспользоваться результатом, полученным при выполнении задачи 8.=#
function print_matrix(A)
    for strA in A
        print(strA)
    end
end
 
 
function minor(A, i, j)
    M = deepcopy(A)
    deleteat!(M,i)
    for i in range(len(A[0]) - 1)
        deleteat!(M,i,j)
    end
    return M
end
#=Задача 10. Написать функцию rang(A), получающую на вход матрицу (вообще говоря, прямоугольную), и возвращающую её ранг.
Указание. Воспользоваться функцией convert! из задачи 7.=#
function rang(A)
    A = convert!(A)
    n = length(A)
    count = 0
    for i in 1:n
        if A[i][i] != 0
            count += 1
        end
    end
    return count
end
#Задача 11. Написать функцию, получающую на вход матрицу СЛАУ приведенную к ступенчатому виду и возвращающую матрицу, содержащую фундаментальную систему решений этой СЛАУ, в случае, если система вырожденая, или пустой вектор-столбец (длина корого равна числу переменных, т.е. числу столбцов полученной матрицы).
function fundamentalnoe(a,b) 
    count = 0
    for i in 1:length(a)
        if a[i] == 0 & b[i]!=0
            for j in 1:length(a)
                x[j] = 0
            end
            return x
        else
            count += 1
        end
    end
    
    for i in length(a):1
        for j in length(a)-1:i
            if a[j][k]>=0 & a[i][i]<=0 || a[j][k]<=0 & a[i][i]>=0
                a[j][i] = a[j][i] + a[i][i]*a[j][i]/a[i][i]
            else
                a[j][i] = a[j][i] - a[i][i]*a[j][i]/a[i][i]
            end
        end
    end
    
    for i in 1:count 
        for j in 1:length(a)
            a[i][j] = a[i][j]/a[i][i]
        end
    end
    
    for k in 1:length(a)
        f = collect(length(a))
        for t in k:length(a)
            if t > count 
                f[t] = 0
            end
            if k == t
                f[t] =  -a[k][t]
            end
            if t == count+k
                f[t] = 1
            end
        end
        print(f)
    end
end
#Задача 12. Написать функцию, получающую на вход расширенную матрицу СЛАУ приведенную к ступенчатому виду и возвращающую какое-либо частное решение этой системы, если оно существует, или значение nothing, в противном случае.
function rashir(a) # 12
    count = 0
    
    for i in 1:length(a)
        if a(i,length(a)-1) == 0 & a(i,length(a))!=0
            return nothing
        else
            count += 1
        end
    end
    
    for i in length(a):1
        for j in length(a)-1:i
            if a[j][k]>=0 & a[i][i]<=0 || a[j][k]<=0 & a[i][i]>=0
                a[j][i] = a[j][i] + a[i][i]*a[j][i]/a[i][i]
            else
                a[j][i] = a[j][i] - a[i][i]*a[j][i]/a[i][i]
            end
        end
    end
    
    x = collect(length(a))
    for k in 1:length(a)
        if k<=count 
            for t in count+1:length(a)
                x[k] += a[k][t]
            end
        else
            x[k] = 1
        end
    end
    
    return x
end