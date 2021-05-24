# Задача 1 :
function insertsort!(A)
    m = length(A)

    for k = 2:m
        for i = 1:m-k
            if A[i]< A[k] <= A[i+1]
                insert!(A, i + 1,A[k])
            end
        end
    end
end
# Задача 2 :
function insertsort_poisk!(A)
    m = length(A)
    for k = 2:m
        if A[k-1]<A[k]<=A[k+1]
            n = k
        end
        i = poisk!(A[:n], A[n+1])
        insert!(A, i + 1 , A[n])
    end
    
end

function found!(b, c)
    n = length(b)
    l = 0
    while l<=n
        mid = (l+n)/2
        if b[mid] == c
            return mid
            break 
        else if b[mid] < c
            l = mid
            n = length(b)
        else 
            l = 0
            n = mid
        end
    end
    return mid
end
