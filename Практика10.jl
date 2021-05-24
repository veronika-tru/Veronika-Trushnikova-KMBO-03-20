#Задача 1
function newton(f::Function, x; a=1e-8, derrirative=20)
    x0 = a
    xn = f(x0)
    xn1 = xn - f(xn) / derrirative(xn)
    while abs(xn1-xn) > math.pow(10,-3)
        xn = xn1
        xn1 = xn - f(xn) / derrirative(xn)
    end

    return xn1

end
#Задача 2
Решение:
newton(ff::Tuple{Function,Function}, x; ε_x=1e-8, ε_y=1e-8, nmaxiter=20)=
    newton(x->ff[1](x)/ff[2](x), x; ε_x, ε_y, nmaxiter)

#Задача 4
Решение:
julia> newton((x->x-cos(x), x->sin(x)), 0.5) 
julia> newton((x->x-cos(x), sin), 0.5) 
#Задача 5
newton(ff, x; ε_x=1e-8, ε_y=1e-8, nmaxiter=20)
где ff - это функция одного аргумента ($x$), возвращающая кортеж значений, 
состоящий из значения функции $f(x)$ в текущей точке и из значения её производной $f^\prime(x)$ в той же точке.
#Задача 6
Решение:
julia> newton(x->(x-cos(x),sin(x)), 0.5) 
#Задача 7
newton(polynom_coeff::Vector{Number}, x; ε_x=1e-8, ε_y=1e-8, nmaxiter=20)=#
newton(polinom_coeff::Vector{Number}, x; ε_x=1e-8, ε_y=1e-8, nmaxiter=20)=
    newton(x->(y=evaldiffpoly(x, polynom_coeff); y[1]/y[2]), x; ε_x, ε_y, nmaxiter)

function evaldiffpoly(x,polynom_coeff)
    Q′=0
    Q=0
    for a in polinom_coeff
        Q′=Q′x+Q
        Q=Qx+a
    end
    return Q, Q′
end
#Задача 8 
function newton(x::Complex, root::Vector{Compex}, ε::AbstractFloat,nmaxiter::Integer) 
    n=lth(root)
    for m in 1:nmaxiter
x -= (x - 1/x^(n-1))/n
root_index = findfirst(r->abs(r-z) <= ε, root)
if !isnothing(root_index)
            return root_index
   end
   end
    return nothing
end
x = complex((rand(2) .- 0.5) . squaresize)
function visua(D, colors; marker, backend::Function)
    backend() 
    p=plot()
    for i in 1:lth(colors)
 plot!(p, real(D[i]), imag(D[i]),
 seriestype = :scatter,
 marker = marker,
 markercl = colors[i])
    end
    plot!(p; ratio = :equal, legend = false)

end
real.(D[i]), imag.(D[i])