
#=Задача 1. Написать функцию, возвращающу одномерный массив заданной длины, содержаий случайные точки плоскости типа Vector2D.
Решение этой задачи в функциональном стиле было бы достаточно гибким:=#
using .Vector2Ds
"""
        randpoints(random::Function, num::Integer)

"""
randpoints(random::Function, num::Integer) = [(random(),random()) for _ in 1:num]
#Задача 2. Написать функцию, которая получает на вход массив точек плоскости типа Vector2D и отображает их на графике.
function proekt(a)
        for i in 1:length(a)
                plot!(a(i))  
end
#=Задача 3. Написать функцию, получающую вектор кортежей, содержащих пары точек типа Vector2D, 
и возвращающую графический объект (типа Plots.Plot), содержащий изображение соответствующих отрезков, расположенных на плоскости.
Решение:=#
function plotsegments(segments::Vector{Tuple{Vector2D,Vector2D}}; kwords...)
    p=plot(;kwords...)
    for s in segments
        plot!(collect(s); kwords...)
    end
    return p
end

#=Задача 4. Написать функцию, которая бы получала на вход аргумент segments, представляющий собой массив типа 
Vector{Tuple{Vector2D,Vector2D}}, или - генератор последовательности элементов типа Tuple{Vector2D,Vector2D} 
(представляющих некоторые отрезки), и возвращающую графический объект типа Plots.Plot, содержащий графики этих отрезков. 
Причем все точки пересечения этих отрезков толжна быть помечены красным крестообразным маркером.=#
function peresechenie(segment::Vector{Tuple{Vector2D,Vector2D}})

        plotsegments(segment) # используем функцию из прошлой задачи
        x,y = intersect(s for s in zip(randpoints(randn,20))) 
        plot!(x , y, color = "red")
end

function intersect((A₁,B₁)::Segment, (A₂,B₂)::Segment)    #функция вычисляющая точку пересечения между прямыми
    A = [B₁[2]-A₁[2]  A₁[1]-B₁[1]
         B₂[2]-A₂[2]  A₂[1]-B₂[1]]

    b = [A₁[2]*(A₁[1]-B₁[1])+A₁[1]*(B₁[2]-A₁[2])
         A₂[2]*(A₂[1]-B₂[1])+A₂[1]*(B₂[2]-A₂[2])]

    x,y = A\b

    if isinner((x, y), (A₁,B₁))==false || isinner((x, y), (A₂,B₂))==false
        return nothing
    end

    return (x,y)
end

isinner(P::Point, (A,B)::Segment) = 
    (A[1] <= P[1] <= B[1] || A[1] >= P[1] >= B[1]) &&
    (A[2] <= P[2] <= B[2] || A[2] >= P[2] >= B[2])
#=Задача 5. Написать функцию, получающую на вход последовательность точек плоскости (их массив или генератор) и 
ещё пару точек плоскости, определяющих некоторую прямую. Функция должна вернуть графический объект типа Plots.Plot, 
содержащий график этих точек (в виде круглых маркеров) и график заданной прямой, причем все точки должны быть раскрашены в два цвета 
(синий и красный) таким образом, чтобы все точки лежащие по одну сторону от прямой были бы раскрашены в какой-то один цвет, 
и точки лежащие по разную сторону от прямой были бы разного цвета.=#
function podsvetca(a,x1,y1, x2, y2)
        k = (y1 - y1)/(x1 - x2)
        b = y1 - k*x1
        for i in 1:length(a)
                if a[i+1] < k*a[i] + b
                        plot!(a[i], a[i+1,] color = "red")
                end
                if a[i+1] > k*a[i] + b
                        plot!(a[i], a[i+1,] color = "blue")
                end
                i += 2
                if i<= length(a)-2
                        Line(xdata=(a[i], a[i+1,]), ydata=(a[i+3], a[i+2,]))
        end
end
#=Задача 6. Написать функцию, получающую на вход последовательность точек плоскости (их массив или генератор) и 
ещё одну последовательность точек, определяющую координаты вершин некоторого многоугольника в порядке его обхода в одном из двух 
возможных направлений (например, для большей определенности, - в положительном). Многоугольник не обязательно выпуклый, 
но без самопересечений сторон. Функция должна вернуть графический объект типа Plots.Plot, содержащий график этих точек 
(в виде круглых маркеров) и график заданного многугольника, причем все точки должны быть раскрашены так, чтобы все точки лежащие 
внутри многоугоугольника были бы красного цвета, а все точки лежащие снаружи - в синего.=#
function podsvetca(a,b)

        for j in 1:length(b)
                if i<= length(a)-2
                        Line(xdata=(b[j], b[j+1,]), ydata=(b[j+3], b[j+2,]))
        end

        for i in a
                in_me(b,a[i])
end

function in_me(self, point)
        result = False
        n = len(self.corners)
        p1x = int(self.corners[0].x)
        p1y = int(self.corners[0].y)
        for i in range(n+1)
            p2x = int(self.corners[i % n].x)
            p2y = int(self.corners[i % n].y)
            if point.y > min(p1y,p2y)
                if point.x <= max(p1x,p2x)
                    if p1y != p2y
                        xinters = (point.y-p1y)*(p2x-p1x)/(p2y-p1y)+p1x
                        return xinters
                    end
                    if p1x == p2x || point.x <= xinters
                        result = - result
                    end
                end
        end
            p1x,p1y = p2x,p2y
        return result
end
#=Задача 7. Дана последовательность точек плоскости, 
определяющая вершины некоторго многоугольника (в порядке их обхода в одном из двух возможных направлений). 
Требуется написать функцию, получающую на вход такую последовательность и возвращающую значение true, если многоугольник выпуклый, 
или значение false - в противном случае.=#
function vipukliy(a, n)
        p = false
        n = false

        for i in 1:n
                x1 = a[i][1]
                y1 = a[i][2]
                x2 = a[(i+1)%n][1]
                y2 = a[(i+1)%n][2]
                x3 = a[(i+2)%n][1]
                y3 = a[(i+2)%n][2]
                d = (x2-x1)*(y3-y2)-(y2-y1)*(x3-x2)
                if d>0
                        p = true
                else
                        n = true
                end
        end

        if p && n
                return false
        else
                return true
        end
end
