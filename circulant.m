function C = circulant(list)
    n = size(list,1);
    n1 = n-1;
    c = repmat(0:n1,n,1);
    c = mod(c+c',n);
    c = c+1;
    C = list(c);
end
    
    