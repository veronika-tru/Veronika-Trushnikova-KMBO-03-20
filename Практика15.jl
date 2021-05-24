
# Задача 1. Написать функцию convert_to_nested(tree::ConnectList{T}, root::T) where T, получающую на вход дерево, представленное списком смежностей tree и индексом его корня root, и возвращающая представление того же дерева в виде вложенных векторов.

ConnectList{T}=Vector{Vector{T}}
NestedVectors = Vector

function convert_to_nested(tree::ConnectList{T},root::T) where T
    nested_tree = []
    for subroot in tree[root]
        push!(nested_tree, convert(tree, subroot))
    end
    push!(nested_tree, root)
    return nested_tree
end

#---------ТЕСТ:
tree=[[2,3],
      [],
      [4,5],
      [],
      []]

nested_tree = convert_to_nested(tree, 1) 
println(nested_tree)  # Any[Any[2], Any[Any[4], Any[5], 3], 1] 


# Задача 2. Написать функцию convert_to_list(tree::NestedVectors), получающую на вход дерево, представленное вложенными векторами, и возвращающая кортеж из списка смежностей типа ConnectList этого дерева и индекса его корня.

function convert_to_dict(tree::NestedVectors)
    T=typeof(tree[end])
    connect_tree = Dict{T,Vector{T}}()
    
    function recurs_trace(tree)
        connect_tree[tree[end]]=[]
        for subtree in tree[1:end-1] # - перебор всех поддеревьев
            push!(connect_tree[tree[end]], recurs_trace(subtree))
        end
        return tree[end] # - индекс конрня
    end

    recurs_trace(tree)
    return connect_tree
end

#--------ТЕСТ:
nested_tree = Any[Any[2], Any[Any[4], Any[5], 3], 1] # - это результат предыдущего примера

dict_tree = convert_to_dict(nested_tree)
println(dict_tree) # Dict(5 => [], 4 => [], 2 => [], 3 => [4, 5], 1 => [2, 3])

#Затем, после того как будет получен список смежностей, представленный словарём, его можно будет легко преобразовать в требуемый одномерный массив (предполагается при этом, что в первоначальном дереве вершины имели сплошную порядковую индексацию: 1,2,3,... без пропусков).
#Соответствующее преобразование осуществляет следующая функция.

function convert_to_list(tree::Dict{T,Vector{T}}) where T
    list_tree=Vector{Vector{T}}(undef,length(tree))
    for subroot in eachindex(list_tree)
        list_tree[subroot]=tree[subroot]
    end
    return list_tree
end

#-----------ТЕСТ:
dict_tree = Dict(5 => [], 4 => [], 2 => [], 3 => [4, 5], 1 => [2, 3])
list_tree = convert_to_list(dict_tree)
println(list_tree) # [[2, 3], Int64[], [4, 5], Int64[], Int64[]]
# Задача 3. Написать функцию convert(tree::ConnectList{T}, root::T) where T, получающую на вход дерево, представленное списком смежностей tree и индексом его корня root, и возвращающая ссылку на связанные стркутруры типа Tree{T}, представляющие то же самое дерево, где

struct Tree{T}
    index::T
    sub::Vector{Tree{T}}}
    Tree{T}(index) where T = new(index, Tree{T}[])
end
